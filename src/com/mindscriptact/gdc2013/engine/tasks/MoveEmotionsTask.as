package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.hero.HeroData;
import flash.geom.Point;
import org.mvcexpress.live.Task;
import starling.display.Image;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MoveEmotionsTask extends Task {
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_VIEWS')]
	public var emotionViews:Vector.<Image>;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_DATAS')]
	public var emotionDatas:Vector.<EmotionData>;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_CONFIG')]
	public var emotionConfig:EmotionsConfigVO;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_CONFIG')]
	public var heroConfig:HeroConfigVO;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_DATA')]
	public var heroData:HeroData;
	
	public static var maxPullAngle:Number;
	public static var maxPushAngle:Number;
	
	override public function run():void {
		
		// distance..	
		var spawnRadius:int = emotionConfig.spawnRadius;
		var distance:int = (spawnRadius * spawnRadius);
		var centerPointX:int = heroConfig.startingXPos;
		var centerPointY:int = heroConfig.startingXPos;
		
		var emotionCount:int = emotionDatas.length
		for (var i:int = 0; i < emotionCount; i++) {
			
			var emotionData:EmotionData = emotionDatas[i];
			
			// pull/push
			
			//find emotion rotation (to x axis).
			var initialAngle:Number = Math.atan2(emotionData.vectorY, emotionData.vectorX);
			var ca:Number = Math.cos(-initialAngle);
			var sa:Number = Math.sin(-initialAngle);
			
			//rotate hero (and emotion) to match x axis (to determine if left or right angle should be made)
			var tempHero:Point = new Point((heroData.x - emotionData.x) * ca - (heroData.y - emotionData.y) * sa, (heroData.x - emotionData.x) * sa + (heroData.y - emotionData.y) * ca);
			
			//rotation change limit for one frame (max angle)
			var angle:Number = Math.abs(heroData.heartState / heroConfig.life * maxPushAngle)
			
			//desired follow angle;
			var followAngle:Number = Math.atan2(tempHero.y, tempHero.x);
			
			//desired run away angle;
			var runawayAngle:Number = (followAngle > 0) ? followAngle - Math.PI : followAngle - Math.PI;
			
			if (Math.abs(angle) < Math.abs(followAngle)) {
				followAngle = angle * followAngle / Math.abs(followAngle);
			}
			
			if (Math.abs(angle) < Math.abs(runawayAngle)) {
				runawayAngle = angle * runawayAngle / Math.abs(runawayAngle);
			}
			
			angle = runawayAngle;
			
			//determine if run or follow
			if (heroData.heartState > 0) {
				if (emotionData.strength > 0) { //traukiam
					angle = followAngle;
				} else { //stumiam
					angle = runawayAngle;
				}
			} else {
				if (emotionData.strength > 0) { //stumiam
					angle = runawayAngle;
				} else { //traukiam
					angle = followAngle;
				}
			}
			
			//rotate emotion
			ca = Math.cos(angle);
			sa = Math.sin(angle);
			
			var tx:Number = emotionData.vectorX * ca - emotionData.vectorY * sa;
			var ty:Number = emotionData.vectorX * sa + emotionData.vectorY * ca;
			
			emotionData.vectorX = tx;
			emotionData.vectorY = ty;
			
			// move
			emotionData.x += emotionData.vectorX;
			emotionData.y += emotionData.vectorY;
			
			// colide with radius
			var distX:int = emotionData.x - centerPointX;
			var distY:int = emotionData.y - centerPointY;
			
			var newDist:int = distX * distX + distY * distY;
			
			if (newDist > distance) {
				//emotionData.x = centerPointX + (centerPointX - emotionData.x);
				//emotionData.y = centerPointY + (centerPointY - emotionData.y);
				sendPostMessage(Message.REMOVE_EMOTION, emotionData);
			}
			
			// render
			emotionViews[i].x = emotionData.x;
			emotionViews[i].y = emotionData.y;
			
		}
	
	}

}
}
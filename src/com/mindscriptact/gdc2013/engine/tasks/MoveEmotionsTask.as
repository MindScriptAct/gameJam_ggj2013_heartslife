package com.mindscriptact.gdc2013.engine.tasks {
import adobe.utils.CustomActions;
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.hero.HeroData;
import flash.display.GraphicsTrianglePath;
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
	
	private var maxAngle:Number = Math.PI / 60;
	
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
			
			// a, b, c
			
			// ((b.x - a.x)* (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) > 0
			
			var pointX:Number = heroData.x - emotionData.x;
			var pointY:Number = heroData.y - emotionData.y;
			
			var angle:Number = heroData.heartState / heroConfig.life * maxAngle;
			
			var positiveEngle:Boolean = (emotionData.vectorX * pointY - emotionData.vectorY * pointX) > 0;
			
			if (positiveEngle) { 
				if (emotionData.strength > 0) { // raudonas
					if (heroData.heartState > 0) { // imt raudona
						
					} else { // imt melina
						
					}
				} else { // melinas
					if (heroData.heartState > 0) { // imt raudona
						
					} else { // imt melina
						
					}
				}
			} else {
				if (emotionData.strength > 0) { // raudonas
					if (heroData.heartState > 0) { // imt raudona
						
					} else { // imt melina
						
					}
				} else { // melinas
					if (heroData.heartState > 0) { // imt raudona
						
					} else { // imt melina
						
					}
				}
			}
			
			//if (angle > 0) {
			//
			// melini arteja
			//
			//if (emotionData.strength > 0) { // raudonas
			//
			//} else { // melinas
			//
			//}
			//
			//} else {
			// raudoni arteja.
			//if (emotionData.strength > 0) { // raudonas
			//
			//} else { // melinas
			//
			//}
			//
			//}
			
			var ca:Number = Math.cos(angle);
			var sa:Number = Math.sin(angle);
			
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
	
		// push / pull
	
	}

	// push/pull

	//var difX:int = heroData.x - emotionDatas[i].x;
	//var difY:int = heroData.y - emotionDatas[i].y;
	//
	//var heroDistance:Number = Math.sqrt(difX * difX + difY * difY);
	//
	//var oneX:Number = difX / heroDistance;
	//var oneY:Number = difY / heroDistance;

	//emotionDatas[i].x += Math.round(oneX * 10);
	//emotionDatas[i].y += Math.round(oneY * 10);

	//emotionDatas[i].vectorX += Math.round(oneX / 10);
	//emotionDatas[i].vectorY += Math.round(oneY / 10);

}
}
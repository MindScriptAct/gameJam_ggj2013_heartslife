package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
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
	
	override public function run():void {
		
		// distance..
		// TODO..
		
		var spawnRadius:int = emotionConfig.spawnRadius;
		var distance:int = (spawnRadius * spawnRadius);
		var centerPointX:int = heroConfig.startingXPos;
		var centerPointY:int = heroConfig.startingXPos;
		
		var emotionCount:int = emotionDatas.length
		for (var i:int = 0; i < emotionCount; i++) {
			emotionDatas[i].x += emotionDatas[i].vectorX;
			emotionDatas[i].y += emotionDatas[i].vectorY;
			
			emotionViews[i].x = emotionDatas[i].x;
			emotionViews[i].y = emotionDatas[i].y;
			
			var distX:int = emotionViews[i].x - centerPointX;
			var distY:int = emotionViews[i].y - centerPointY;
			
			var newDist:int = distX * distX + distY * distY;
			
			if (newDist > distance) {
				
				emotionDatas[i].x = centerPointX + (centerPointX - emotionDatas[i].x);
				emotionDatas[i].y = centerPointY + (centerPointY - emotionDatas[i].y);
				
			}
			
			emotionViews[i].x = emotionDatas[i].x;
			emotionViews[i].y = emotionDatas[i].y;
			
		}
	}

}
}
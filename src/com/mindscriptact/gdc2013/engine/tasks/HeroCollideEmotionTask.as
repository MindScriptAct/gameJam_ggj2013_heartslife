package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.hero.HeroData;
import org.mvcexpress.live.Task;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class HeroCollideEmotionTask extends Task {
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_DATAS')]
	public var emotionDatas:Vector.<EmotionData>;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_DATA')]
	public var heroData:HeroData;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_CONFIG')]
	public var emotionConfig:EmotionsConfigVO;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_CONFIG')]
	public var heroConfig:HeroConfigVO;
	
	override public function run():void {
		
		var dist:int = heroConfig.size / 2 + emotionConfig.size / 2;
		
		var distance:int = dist * dist;
		
		var emotionCount:int = emotionDatas.length
		for (var i:int = 0; i < emotionCount; i++) {
			var distX:int = emotionDatas[i].x - heroData.x;
			var distY:int = emotionDatas[i].y - heroData.y;
			
			var newDist:int = distX * distX + distY * distY;
			
			if (newDist < distance) {
				sendPostMessage(Message.CONSUME_EMOTION, emotionDatas[i]);
			}
		}
	
	}

}
}
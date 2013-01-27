package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionsInfo;
import flash.utils.getTimer;
import org.mvcexpress.live.Task;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class EmotionSpawnTask extends Task {
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTIONS_INFO')]
	public var emotionsInfo:EmotionsInfo;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.EMOTION_CONFIG')]
	public var emotionConfig:EmotionsConfigVO;
	
	override public function run():void {
		var timer:int = getTimer();
		
		if (emotionsInfo.lastSpawn + emotionsInfo.spawnGaps < timer) {
			emotionsInfo.lastSpawn = timer;
			sendFinalMessage(Message.SPAWN_EMOTION);
		}
		
		emotionsInfo.spawnGaps -= emotionsInfo.spawnReduceRate;
		
		if (emotionsInfo.spawnGaps < emotionsInfo.minimalGaps) {
			emotionsInfo.spawnGaps = emotionsInfo.minimalGaps
		}
	}

}
}
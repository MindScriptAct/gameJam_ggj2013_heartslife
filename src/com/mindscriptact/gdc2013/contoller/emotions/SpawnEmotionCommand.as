package com.mindscriptact.gdc2013.contoller.emotions {
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import org.mvcexpress.mvc.PooledCommand;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class SpawnEmotionCommand extends PooledCommand {
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	public function execute(blank:Object):void {
		
		var id:int = Math.floor(Math.random() * 6) + 1;
		
		var emotionData:EmotionData = new EmotionData(id);
		emotionData.x = 150 + Math.random() * 400;
		emotionData.y = 150 + Math.random() * 400;
		
		emotionData.vectorX = Math.random() * 5 + 2;
		emotionData.vectorY = Math.random() * 5 + 2;
		
		if (Math.random() > 0.5) {
			emotionData.vectorX *= -1;
		}
		if (Math.random() > 0.5) {
			emotionData.vectorY *= -1;
		}
		emotionProxy.addEmotion(emotionData);
	}

}
}
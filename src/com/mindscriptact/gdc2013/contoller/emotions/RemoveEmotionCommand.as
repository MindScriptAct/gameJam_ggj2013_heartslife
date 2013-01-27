package com.mindscriptact.gdc2013.contoller.emotions {
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import org.mvcexpress.mvc.Command;
import org.mvcexpress.mvc.PooledCommand;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class RemoveEmotionCommand extends PooledCommand {
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	[Inject]
	public var gameProxy:GameProxy;
	
	public function execute(emotion:EmotionData):void {
		
		gameProxy.reduceScore(emotionProxy.getEmotionScore(emotion.emotionId) * emotionProxy.getPenaltyPercentage());
		
		emotionProxy.removeEmotion(emotion);
	}

}
}
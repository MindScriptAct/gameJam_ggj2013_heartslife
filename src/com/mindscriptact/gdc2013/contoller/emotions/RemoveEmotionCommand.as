package com.mindscriptact.gdc2013.contoller.emotions {
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import org.mvcexpress.mvc.Command;
import org.mvcexpress.mvc.PooledCommand;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class RemoveEmotionCommand extends PooledCommand {
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	public function execute(emotion:EmotionData):void {
		emotionProxy.removeEmotion(emotion);
	}

}
}
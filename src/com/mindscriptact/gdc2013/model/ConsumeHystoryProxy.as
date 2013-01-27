package com.mindscriptact.gdc2013.model {
import com.bit101.components.Component;
import com.mindscriptact.gdc2013.messages.DataMessage;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class ConsumeHystoryProxy extends Proxy {
	private var emotionIds:Vector.<int> = new Vector.<int>();
	private var isPositives:Vector.<Boolean> = new Vector.<Boolean>();
	
	public function ConsumeHystoryProxy() {
	
	}
	
	public function rememberEmotion(emotionId:int, isPositive:Boolean):void {
		emotionIds.unshift(emotionId);
		isPositives.unshift(isPositive);
		
		sendMessage(DataMessage.EMOTION_ADDED_TO_HYSTORY, emotionId);
	}
	
	public function reset():void {
		emotionIds.length = 0;
		isPositives.length = 0;
		
		sendMessage(DataMessage.EMOTION_HYSTORY_RESET);
	}
	
	public function getHystoryChain():int {
		var chainCount:int = 0;
		if (isPositives.length) {
			var chainMood:Boolean = isPositives[0];
			for (var i:int = 0; i < isPositives.length; i++) {
				if (chainMood == isPositives[i]) {
					chainCount++;
				}
			}
		}
		return chainCount;
	}
	
	override protected function onRegister():void {
	
	}
	
	override protected function onRemove():void {
	
	}

}
}
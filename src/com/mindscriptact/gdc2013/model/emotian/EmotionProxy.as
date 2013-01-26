package com.mindscriptact.gdc2013.model.emotian {
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import flash.utils.Dictionary;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class EmotionProxy extends Proxy {
	
	private var emotionConfig:EmotionsConfigVO;
	
	private var emotionDatas:Vector.<EmotionData> = new Vector.<EmotionData>();
	
	private var emotionsData:EmotionsInfo = new EmotionsInfo();
	
	private var emotionStrength:Dictionary = new Dictionary();
	
	public function EmotionProxy(emotionConfig:EmotionsConfigVO) {
		this.emotionConfig = emotionConfig;
		
		for (var i:int = 0; i < emotionConfig.emotions.length; i++) {
			var strength:int = emotionConfig.emotions[i].strength;
			if (!emotionConfig.emotions[i].positive) {
				strength *= -1;
			}
			emotionStrength[emotionConfig.emotions[i].id] = strength;
		}
	
	}
	
	public function getConfig():EmotionsConfigVO {
		return emotionConfig;
	}
	
	public function addEmotion(emotionData:EmotionData):void {
		emotionDatas.push(emotionData);
		
		sendMessage(DataMessage.EMOTION_SPOWN, emotionData);
	}
	
	public function getEnemySpawnRadius():int {
		return emotionConfig.spawnRadius;
	}
	
	public function removeEmotion(emotion:EmotionData):void {
		for (var i:int = 0; i < emotionDatas.length; i++) {
			if (emotion == emotionDatas[i]) {
				emotionDatas.splice(i, 1);
				sendMessage(DataMessage.EMOTION_REMOVED, i);
				break;
			}
		}
	}
	
	public function getEmotionStrength(emotionId:int):int {
		return emotionStrength[emotionId];
	}
	
	override protected function onRegister():void {
		provide(emotionDatas, ProvideId.EMOTION_DATAS);
		provide(emotionsData, ProvideId.EMOTIONS_INFO);
	}
	
	override protected function onRemove():void {
	
	}

}
}
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
	
	private var emotionsInfo:EmotionsInfo = new EmotionsInfo();
	
	private var emotionStrength:Dictionary = new Dictionary();
	private var emotionScore:Dictionary = new Dictionary();
	
	public function EmotionProxy(emotionConfig:EmotionsConfigVO) {
		this.emotionConfig = emotionConfig;
		
		for (var i:int = 0; i < emotionConfig.emotions.length; i++) {
			var strength:int = emotionConfig.emotions[i].strength;
			if (!emotionConfig.emotions[i].positive) {
				strength *= -1;
			}
			emotionStrength[emotionConfig.emotions[i].id] = strength;
			emotionScore[emotionConfig.emotions[i].id] = emotionConfig.emotions[i].score;
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
				sendMessage(DataMessage.EMOTION_REMOVED, {nr: i, instant: emotion.outOfBounds});
				break;
			}
		}
	}
	
	public function getEmotionStrength(emotionId:int):int {
		return emotionStrength[emotionId];
	}
	
	public function removeAll():void {
		emotionDatas.length = 0;
		sendMessage(DataMessage.All_EMOTIONS_REMOVED);
	}
	
	public function getEmotionScore(emotionId:int):int {
		return emotionScore[emotionId];
	}
	
	public function getPenaltyPercentage():Number {
		return emotionConfig.penaltyPercentage;
	}
	
	public function resetSpawnTimer():void {
		emotionsInfo.lastSpawn = 0;
		emotionsInfo.spawnGaps = emotionConfig.spawnRateStart;
		emotionsInfo.minimalGaps = emotionConfig.spawnRateMin;
		emotionsInfo.spawnReduceRate = emotionConfig.spawnRateChange;
	}
	
	override protected function onRegister():void {
		provide(emotionDatas, ProvideId.EMOTION_DATAS);
		provide(emotionsInfo, ProvideId.EMOTIONS_INFO);
	}
	
	override protected function onRemove():void {
	
	}

}
}
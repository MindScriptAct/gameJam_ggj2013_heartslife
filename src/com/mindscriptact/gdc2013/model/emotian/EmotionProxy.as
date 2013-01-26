package com.mindscriptact.gdc2013.model.emotian {
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class EmotionProxy extends Proxy {
	
	private var emotionConfig:EmotionsConfigVO;
	
	private var emotionDatas:Vector.<EmotionData> = new Vector.<EmotionData>();
	
	private var emotionsData:EmotionsInfo = new EmotionsInfo();
	
	
	public function EmotionProxy(emotionConfig:EmotionsConfigVO) {
		this.emotionConfig = emotionConfig;
	
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
	
	override protected function onRegister():void {
		provide(emotionDatas, ProvideId.EMOTION_DATAS);
		provide(emotionsData, ProvideId.EMOTIONS_INFO);
	}
	
	override protected function onRemove():void {
	
	}

}
}
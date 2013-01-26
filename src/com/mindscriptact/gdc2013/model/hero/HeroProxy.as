package com.mindscriptact.gdc2013.model.hero {
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class HeroProxy extends Proxy {
	
	private var heroConfig:HeroConfigVO;
	
	private var heroData:HeroData = new HeroData();
	
	public function HeroProxy(heroConfig:HeroConfigVO) {
		this.heroConfig = heroConfig;
	}
	
	override protected function onRegister():void {
		setToDefault();
		
		provide(heroData, ProvideId.HERO_DATA);
	}
	
	override protected function onRemove():void {
	
	}
	
	public function setToDefault():void {
		heroData.x = heroConfig.startingXPos;
		heroData.y = heroConfig.startingYPos;
		
		heroData.heartState = 0;
		
		sendMessage(DataMessage.HERO_POSITON_CHANGED);
		sendMessage(DataMessage.HERO_HEART_CHANGED, heroData.heartState);
	}
	
	public function getAssetSize():int {
		return heroConfig.assetSize;
	}
	
	public function getHeroPosX():int {
		return heroData.x;
	}
	
	public function getHeroPosY():int {
		return heroData.y;
	}
	
	public function getHeroConfig():HeroConfigVO {
		return heroConfig
	}
	
	public function changeHeart(heartValue:int):void {
		heroData.heartState += heartValue;
		sendMessage(DataMessage.HERO_HEART_CHANGED, heroData.heartState);
	}
	
	public function getHeartState():int {
		return heroData.heartState;
	}
}
}
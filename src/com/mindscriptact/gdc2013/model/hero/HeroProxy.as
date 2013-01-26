package com.mindscriptact.gdc2013.model.hero {
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
		hositionToDefault();
	}
	
	override protected function onRemove():void {
	
	}
	
	public function hositionToDefault():void {
		heroData.x = heroConfig.startingXPos;
		heroData.y = heroConfig.startingYPos;
		
		sendMessage(DataMessage.HERO_POSITON_SET);
	}
}
}
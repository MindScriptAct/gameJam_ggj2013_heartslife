package com.mindscriptact.gdc2013.model.game{
import com.mindscriptact.gdc2013.model.config.data.GameConfigVO;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameProxy extends Proxy {
	private var gameConfig:GameConfigVO;
	
	public function GameProxy(gameConfig:GameConfigVO) {
		this.gameConfig = gameConfig;
		
	}
	
	override protected function onRegister():void {
	
	}
	
	override protected function onRemove():void {
	
	}

}
}
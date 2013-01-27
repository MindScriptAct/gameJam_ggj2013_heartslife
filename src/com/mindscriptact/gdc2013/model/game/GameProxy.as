package com.mindscriptact.gdc2013.model.game {
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.GameConfigVO;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameProxy extends Proxy {
	
	private var gameConfig:GameConfigVO;
	
	private var currentScore:int = 0;
	
	public function GameProxy(gameConfig:GameConfigVO) {
		this.gameConfig = gameConfig;
	
	}
	
	public function resetScore():void {
		currentScore = 0;
		
		sendMessage(DataMessage.SCORE_CHANGE, currentScore);
	}
	
	public function getScore():int {
		return currentScore;
	}
	
	public function increaseScore(score:int):void {
		currentScore += score;
		sendMessage(DataMessage.SCORE_CHANGE, currentScore);
	}
	
	public function reduceScore(score:int):void {
		currentScore -= score;
		sendMessage(DataMessage.SCORE_CHANGE, currentScore);
	}	
	
	override protected function onRegister():void {
	
	}
	
	override protected function onRemove():void {
	
	}

}
}
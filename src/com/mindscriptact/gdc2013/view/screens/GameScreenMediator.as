package com.mindscriptact.gdc2013.view.screens {
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.GameConfigVO;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameScreenMediator extends Mediator {
	
	[Inject]
	public var view:GameScreenSPR;
	
	[Inject]
	public var gameProxy:GameProxy;
	
	override public function onRegister():void {
		addHandler(DataMessage.SCORE_CHANGE, handleScoreChange);
		view.score_txt.text = String(gameProxy.getScore());
	}
	
	private function handleScoreChange(score:int):void {
		view.score_txt.text = String(score);
	}
	
	override public function onRemove():void {
	
	}

}
}
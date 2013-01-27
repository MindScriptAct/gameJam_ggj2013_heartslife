package com.mindscriptact.gdc2013.view.screens {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ViewMessage;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import flash.events.Event;
import flash.events.MouseEvent;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameOverScreenMediator extends Mediator {
	
	[Inject]
	public var view:GameOverScreenSPR;
	
	[Inject]
	public var gameProxy:GameProxy;
	
	override public function onRegister():void {
		view.startGame_btn.addEventListener(MouseEvent.CLICK, handleStartGame);
		view.back_btn.addEventListener(MouseEvent.CLICK, handleBack);
		view.score_txt.text = String(gameProxy.getScore());
	}
	
	private function handleBack(event:Event):void {
		sendMessage(Message.SHOW_SCREEN, ScreenIds.START);
	}
	
	private function handleStartGame(event:MouseEvent):void {
		sendMessage(ViewMessage.PRESS_START_GAME);
	}
	
	override public function onRemove():void {
	
	}

}
}
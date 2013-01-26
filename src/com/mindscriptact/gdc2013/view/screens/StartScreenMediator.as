package com.mindscriptact.gdc2013.view.screens{
import com.mindscriptact.gdc2013.messages.ViewMessage;
import flash.events.MouseEvent;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class StartScreenMediator extends Mediator {
	
	[Inject]
	public var view:StartScreenSPR;
	
	override public function onRegister():void {
		view.startGame_btn.addEventListener(MouseEvent.CLICK, handleStartGame);
	}
	
	private function handleStartGame(event:MouseEvent):void {
		sendMessage(ViewMessage.PRESS_START_GAME);
	}
	
	override public function onRemove():void {
		
	}
	
}
}
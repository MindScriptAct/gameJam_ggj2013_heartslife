package com.mindscriptact.gdc2013.view.screens {
import com.mindscriptact.gdc2013.messages.ViewMessage;
import flash.events.MouseEvent;
import flash.net.navigateToURL;
import flash.net.URLRequest;
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
		
		addListener(view.flashButton, MouseEvent.CLICK, handleFlashLinkButton);
		addListener(view.mvcExpressButton, MouseEvent.CLICK, handleExpressLinkButton);
		
		addListener(view.blogButton, MouseEvent.CLICK, handleBlogLinkButton);
		addListener(view.twitterButton, MouseEvent.CLICK, handleTwitterLinkButton);
	}
	
	private function handleStartGame(event:MouseEvent):void {
		sendMessage(ViewMessage.PRESS_START_GAME);
	}
	
	override public function onRemove():void {
	
	}
	
	private function handleFlashLinkButton(event:MouseEvent):void {
		navigateToURL(new URLRequest("http://gaming.adobe.com/getstarted/"), "_blank");
	}
	
	private function handleExpressLinkButton(event:MouseEvent):void {
		navigateToURL(new URLRequest("http://mvcexpress.org/"), "_blank");
	}
	
	private function handleStarlingLinkButton(event:MouseEvent):void {
		navigateToURL(new URLRequest("http://gamua.com/starling/"), "_blank");
	}
	
	private function handleBlogLinkButton(event:MouseEvent):void {
		navigateToURL(new URLRequest("http://www.mindscriptact.com/"), "_blank");
	}
	
	private function handleTwitterLinkButton(event:MouseEvent):void {
		navigateToURL(new URLRequest("https://twitter.com/Deril"), "_blank");
	}

}
}
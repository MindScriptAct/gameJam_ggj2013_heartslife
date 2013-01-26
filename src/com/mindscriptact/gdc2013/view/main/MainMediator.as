package com.mindscriptact.gdc2013.view.main {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.Main;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.view.preload.PreloadView;
import flash.display.Sprite;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MainMediator extends Mediator {
	private var loader:PreloadView;
	private var screen:Sprite;
	
	[Inject]
	public var view:Main;
	
	override public function onRegister():void {
		addHandler(Message.SHOW_LOADER, handleShowLoader);
		addHandler(Message.HIDE_LOADER, handleHideLoader);
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
	}
	
	override public function onRemove():void {
	
	}
	
	private function handleShowScreen(screenName:String):void {
		if (screen) {
			view.removeChild(screen);
			mediatorMap.unmediate(screen);
			screen = null;
		}
		switch (screenName) {
			case ScreenIds.START: 
				screen = new StartScreenSPR();
				break;
			case ScreenIds.GAME: 
				screen = new GameScreenSPR();
				break;
			case ScreenIds.GAMEOVER: 
				screen = new GameOverScreenSPR();
				break;
			default: 
				throw Error("TODO")
		}
		if (screen) {
			view.addChild(screen);
			mediatorMap.mediate(screen);
		}
	}
	
	private function handleShowLoader(blank:Object):void {
		loader = new PreloadView();
		view.addChild(loader);
		mediatorMap.mediate(loader);
	}
	
	private function handleHideLoader(blank:Object):void {
		mediatorMap.unmediate(loader);
		view.removeChild(loader);
		loader = null;
	}

}
}
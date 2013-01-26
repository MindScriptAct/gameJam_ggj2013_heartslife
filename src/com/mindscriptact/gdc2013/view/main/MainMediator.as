package com.mindscriptact.gdc2013.view.main {
import com.mindscriptact.gdc2013.Main;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.view.preload.PreloadView;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MainMediator extends Mediator {
	private var loader:PreloadView;
	
	[Inject]
	public var view:Main;
	
	override public function onRegister():void {
		addHandler(Message.SHOW_LOADER, handleShowLoader);
		addHandler(Message.HIDE_LOADER, handleHideLoader);
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
	
	override public function onRemove():void {
	
	}

}
}
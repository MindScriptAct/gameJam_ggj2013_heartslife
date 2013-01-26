package com.mindscriptact.gdc2013.view.preload {

import com.mindscriptact.gdc2013.messages.DataMessage;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class PreloadViewMediator extends Mediator {
	
	[Inject]
	public var view:PreloadView;
	
	override public function onRegister():void {
		view.preloadText.x = 300;
		view.preloadText.y = 500;
		addHandler(DataMessage.LOAD_STEP_REPORT, handleProleadMesage);
	}
	
	override public function onRemove():void {
	}
	
	private function handleProleadMesage(text:String):void {
		view.setText(text);
	}
	
	
}
}
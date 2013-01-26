package com.mindscriptact.gdc2013.contoller.preload {
import com.mindscriptact.gdc2013.messages.KeyMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ProcessMessage;
import com.mindscriptact.gdc2013.model.keyboard.KeyboardProxy;
import flash.ui.Keyboard;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class DonePreloadCommand extends Command {
	
	[Inject]
	public var keyboardProxy:KeyboardProxy;
	
	public function execute(blank:Object):void {
		sendMessage(Message.HIDE_LOADER);
		
		//keyboardProxy.registerMessageSendOnPress(Keyboard.UP, KeyMessage.KEY_UP);
		//keyboardProxy.registerMessageSendOnPress(Keyboard.DOWN, KeyMessage.KEY_DOWN);
		//keyboardProxy.registerMessageSendOnPress(Keyboard.LEFT, KeyMessage.KEY_LEFT);
		//keyboardProxy.registerMessageSendOnPress(Keyboard.RIGHT, KeyMessage.KEY_RIGHT);
		
		keyboardProxy.registerMessageSendOnPress(Keyboard.NUMPAD_SUBTRACT, KeyMessage.KEY_SUBTRACT);
		keyboardProxy.registerMessageSendOnPress(Keyboard.NUMPAD_ADD, KeyMessage.KEY_ADD);
		
		sendMessage(ProcessMessage.START_TEST_IMAGE_MOVE);
	}

}
}
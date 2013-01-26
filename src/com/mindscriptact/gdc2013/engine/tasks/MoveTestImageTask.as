package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.constants.ProcessId;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import org.mvcexpress.live.Task;
import starling.display.Image;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MoveTestImageTask extends Task {
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProcessId.TEST_IMAGE')]
	public var testImage:Image;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProcessId.KEYBOARD_REGISTRY')]
	public var keyDictionary:Dictionary;
	
	override public function run():void {
		if (keyDictionary[Keyboard.UP] as Boolean) {
			testImage.y += 10;
		}
		if (keyDictionary[Keyboard.DOWN] as Boolean) {
			testImage.y -= 10;
		}
		if (keyDictionary[Keyboard.LEFT] as Boolean) {
			testImage.x += 10;
		}
		if (keyDictionary[Keyboard.RIGHT] as Boolean) {
			testImage.x -= 10;
		}
	
	}

}
}
package com.mindscriptact.gdc2013.view.game {
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.assetLibrary.assets.PICAsset;
import com.mindscriptact.gdc2013.constants.AssetIds;
import com.mindscriptact.gdc2013.constants.ProcessId;
import com.mindscriptact.gdc2013.messages.KeyMessage;
import com.mindscriptact.gdc2013.messages.Message;
import flash.ui.Keyboard;
import org.mvcexpress.mvc.Mediator;
import starling.display.Image;
import starling.textures.Texture;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameMediator extends Mediator {
	private var testImage:Image;
	
	[Inject]
	public var view:Game;
	
	override public function onRegister():void {
		trace("GameMediator.onRegister");
		
		view.touchable = false;
		
		addHandler(Message.HIDE_LOADER, showCollorTest);
		
		//addHandler(KeyMessage.KEY_DOWN, handleKeyPress);
		//addHandler(KeyMessage.KEY_UP, handleKeyPress);
		//addHandler(KeyMessage.KEY_LEFT, handleKeyPress);
		//addHandler(KeyMessage.KEY_RIGHT, handleKeyPress);
		addHandler(KeyMessage.KEY_ADD, handleKeyPress);
		addHandler(KeyMessage.KEY_SUBTRACT, handleKeyPress);
	
	}
	
	private function handleKeyPress(keyCode:int):void {
		trace("GameMediator.handleKe0yPress > keyCode : " + keyCode);
		switch (keyCode) {
			//case Keyboard.UP: 
			//testImage.y -= 100;
			//break;
			//case Keyboard.DOWN: 
			//testImage.y += 100;
			//break;
			//case Keyboard.LEFT: 
			//testImage.x -= 100;
			//break;
			//case Keyboard.RIGHT: 
			//testImage.x += 100;
			//break;
			case Keyboard.NUMPAD_ADD: 
				testImage.scaleX *= 2;
				testImage.scaleY *= 2;
				break;
			case Keyboard.NUMPAD_SUBTRACT: 
				testImage.scaleX /= 2;
				testImage.scaleY /= 2;
				break;
			default: 
		}
	}
	
	private function showCollorTest(blank:Object):void {
		AssetLibrary.sendAssetToFunction(AssetIds.COLOR_TEST, handleTestPic);
	}
	
	private function handleTestPic(asset:PICAsset):void {
		var texture:Texture = Texture.fromBitmap(asset.getBitmap());
		
		testImage = new Image(texture);
		view.addChild(testImage);
		
		provide(testImage, ProcessId.TEST_IMAGE);
	}
	
	override public function onRemove():void {
	
	}

}
}
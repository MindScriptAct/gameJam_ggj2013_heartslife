package com.mindscriptact.gdc2013.view.preload {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * COMMENT
 * @author Deril
 */
public class PreloadView extends Sprite {
	
	public var preloadText:TextField;
	private var newFormat:TextFormat;
	
	public function PreloadView() {
		preloadText = new TextField();
		this.addChild(preloadText);
		preloadText.text = '...';
		preloadText.mouseEnabled = false;
		preloadText.autoSize = TextFieldAutoSize.LEFT;
		
		newFormat = new TextFormat();
		newFormat.size = 12;
		newFormat.font = 'Verdana';
		newFormat.color = 0xFFFFFF;
		newFormat.bold = true;
		
		preloadText.setTextFormat(newFormat);
	}
	
	public function setText(text:String):void {
		preloadText.text = text;
		preloadText.setTextFormat(newFormat);
	}
}
}
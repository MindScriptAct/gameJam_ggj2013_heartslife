package com.mindscriptact.gdc2013 {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.text.TextField;
import flash.utils.getDefinitionByName;

/**
 * ...
 * @author Raimundas Banevicius (http://mvcexpress.org)
 */
public class Preloader extends MovieClip {
	private var myTextField:TextField;
	
	public function Preloader() {
		if (stage) {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		addEventListener(Event.ENTER_FRAME, checkFrame);
		loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		
		// show loader
		
		myTextField = new TextField();
		this.addChild(myTextField);
		myTextField.text = '...';
		myTextField.textColor = 0xFFFFFF;
		myTextField.x = 1280 / 2 - 30;
		myTextField.y = 720 / 2;
		myTextField.width = 200;
		myTextField.height = 50;
	
	}
	
	private function ioError(e:IOErrorEvent):void {
		trace(e.text);
		myTextField.text = e.text;
	}
	
	private function progress(event:ProgressEvent):void {
		// TODO update loader
		
		myTextField.text = "Game is loading...\n" + (event.bytesLoaded / 1024) + " / " + (event.bytesTotal / 1024) + " bytes.";
	
	}
	
	private function checkFrame(e:Event):void {
		if (currentFrame == totalFrames) {
			stop();
			loadingFinished();
		}
	}
	
	private function loadingFinished():void {
		removeEventListener(Event.ENTER_FRAME, checkFrame);
		loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
		loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
		
		//  hide loader
		this.removeChild(myTextField);
		myTextField = null;
		
		startup();
	}
	
	private function startup():void {
		var mainClass:Class = getDefinitionByName("com.mindscriptact.gdc2013.Main") as Class;
		addChild(new mainClass() as DisplayObject);
	}

}

}
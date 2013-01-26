package com.mindscriptact.gdc2013 {
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ViewMessage;
import com.mindscriptact.mvcExpressLogger.MvcExpressLogger;
import flash.display.Sprite;
import flash.events.Event;
import org.mvcexpress.utils.checkClassStringConstants;
import utils.debug.Stats;

/**
 * ...
 * @author rBanevicius
 */
[Frame(factoryClass="com.mindscriptact.gdc2013.Preloader")]

public class Main extends Sprite {
	
	public function Main():void {
		if (stage)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		// entry point
		
		CONFIG::debug {
			checkClassStringConstants(Message, ViewMessage, DataMessage);
			MvcExpressLogger.init(this.stage);
			this.addChild(new Stats(100, 50, 0, true, true, true));
		}
		
		// start
		new GameModule().start(this);
	
	}

}

}
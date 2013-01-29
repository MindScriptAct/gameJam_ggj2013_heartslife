package com.mindscriptact.gdc2013 {
import com.gamua.flox.Flox;
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.gdc2013.engine.tasks.MoveHeroTask;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ViewMessage;
import com.mindscriptact.mvcExpressLogger.MvcExpressLogger;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.getDefinitionByName;
import org.mvcexpress.utils.checkClassStringConstants;
import utils.debug.Stats;
/**
 * ...
 * @author rBanevicius
 */
[Frame(factoryClass="com.mindscriptact.gdc2013.Preloader")]

public class Main extends Sprite {
	
	static public var FLOX_ENABLED:Boolean = false;
	
	private var _leftDown:Boolean;
	private var _rightDown:Boolean;
	private var _topDown:Boolean;
	private var _downDown:Boolean;
	
	public function Main():void {
		if (stage)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void {
		
		try {
			var floxConfigClass:Class = getDefinitionByName("FloxConfig") as Class;
			if (floxConfigClass) {
				Flox.init(floxConfigClass["GAME_ID"], floxConfigClass["GAME_KEY"], floxConfigClass["GAME_VERSION"]);
			}
			Main.FLOX_ENABLED = true;
		} catch (err:Error) {
			// ignore error.
			Main.FLOX_ENABLED = false;
		}
		
		removeEventListener(Event.ADDED_TO_STAGE, init);
		// entry point
		
		CONFIG::debug {
			checkClassStringConstants(Message, ViewMessage, DataMessage);
			MvcExpressLogger.init(this.stage);
			this.addChild(new Stats(100, 50, 0, true, true, true));
		}
		
		// start
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		
		new GameModule().start(this);
	
	}
	
	//Settings.add("move_left", Keyboard.A);
	//Settings.add("move_right", Keyboard.D);
	//Settings.add("move_up", Keyboard.W);
	//Settings.add("move_down", Keyboard.S);	
	
	//keyboard hack
	public function keyDown(e:KeyboardEvent):void {
		switch (e.keyCode) {
			
			case Keyboard.LEFT: 
				_leftDown = true;
				MoveHeroTask.directionX = -1;
				break;
			case Keyboard.RIGHT: 
				_rightDown = true;
				MoveHeroTask.directionX = 1;
				break;
			case Keyboard.UP: 
				_topDown = true;
				MoveHeroTask.directionY = -1;
				break;
			case Keyboard.DOWN: 
				_downDown = true;
				MoveHeroTask.directionY = 1;
				break;
		}
	}
	
	public function keyUp(e:KeyboardEvent):void {
		switch (e.keyCode) {
			case Keyboard.LEFT: 
				_leftDown = false;
				MoveHeroTask.directionX = (_rightDown) ? 1 : 0;
				break;
			case Keyboard.RIGHT: 
				_rightDown = false;
				MoveHeroTask.directionX = (_leftDown) ? -1 : 0;
				break;
			case Keyboard.UP: 
				_topDown = false;
				MoveHeroTask.directionY = (_downDown) ? 1 : 0;
				break;
			case Keyboard.DOWN: 
				_downDown = false;
				MoveHeroTask.directionY = (_topDown) ? -1 : 0;
				break;
		}
	}
}

}
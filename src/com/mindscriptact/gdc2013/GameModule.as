package com.mindscriptact.gdc2013 {
import com.mindscriptact.gdc2013.contoller.preload.StartPreloadingCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupControllerCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupEngineCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupModelCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupViewCommand;
import com.mindscriptact.gdc2013.view.game.Game;
import com.mindscriptact.gdc2013.view.starling.StarlingMediator;
import flash.events.Event;
import flash.geom.Rectangle;
import org.mvcexpress.modules.ModuleCore;
import starling.core.Starling;

/**
 * COMMENT : todo
 * @author rBanevicius
 */
public class GameModule extends ModuleCore {
	private var starlingObj:Starling;
	private var main:Main;
	
	static public const NAME:String = "GameModule";
	
	public function GameModule() {
		super(GameModule.NAME);
	}
	
	override protected function onInit():void {
	
	}
	
	public function start(main:Main):void {
		this.main = main;
		
		commandMap.execute(SetupControllerCommand);
		
		commandMap.execute(SetupModelCommand, main.stage);
		
		commandMap.execute(SetupViewCommand);
		
		processMap.setStage(main.stage);
		commandMap.execute(SetupEngineCommand);
		
		mediatorMap.mediate(main);
		
		
		starlingObj = new Starling(Game, main.stage, new Rectangle(0, 0, 1280, 960));
		starlingObj.stage.stageWidth = 1280;
		starlingObj.stage.stageHeight = 960;
		
		this.main = main;
		main.stage.addEventListener(Event.RESIZE, onResize);
		
		//var mStarling:Starling = new Starling(Game, main.stage, new Rectangle(0, 0, 800, 600),null, Context3DRenderMode.SOFTWARE);
		mediatorMap.mediateWith(starlingObj, StarlingMediator);
		
		commandMap.execute(StartPreloadingCommand);
		
		//force resize
		onResize(null);
	}
	
	private function onResize(e:Event):void 
	{
		//1280x960
		
		var scale:Number = Math.min(main.stage.stageWidth/1280, main.stage.stageHeight/960);
		var contentWidth:Number = (1280 * scale);
		var contentHeight:Number = (960 * scale);
		
		
		starlingObj.viewPort = new Rectangle((main.stage.stageWidth-contentWidth)/2, (main.stage.stageHeight-contentHeight)/2, contentWidth, contentHeight);
		main.x = starlingObj.viewPort.left;
		main.y = starlingObj.viewPort.top;

		main.scaleX = main.scaleY = scale;
		//main.scaleX = macontentWidth;
		//main.height = contentHeight;
		
	}
	
	override protected function onDispose():void {
	
	}

}
}
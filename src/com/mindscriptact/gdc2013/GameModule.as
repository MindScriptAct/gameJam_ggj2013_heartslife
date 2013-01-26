package com.mindscriptact.gdc2013 {
import com.mindscriptact.gdc2013.contoller.preload.StartPreloadingCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupControllerCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupEngineCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupModelCommand;
import com.mindscriptact.gdc2013.contoller.setup.SetupViewCommand;
import com.mindscriptact.gdc2013.view.game.Game;
import com.mindscriptact.gdc2013.view.starling.StarlingMediator;
import flash.geom.Rectangle;
import org.mvcexpress.modules.ModuleCore;
import starling.core.Starling;

/**
 * COMMENT : todo
 * @author rBanevicius
 */
public class GameModule extends ModuleCore {
	
	static public const NAME:String = "GameModule";
	
	public function GameModule() {
		super(GameModule.NAME);
	}
	
	override protected function onInit():void {
	
	}
	
	public function start(main:Main):void {
		
		commandMap.execute(SetupControllerCommand);
		
		commandMap.execute(SetupModelCommand, main.stage);
		
		commandMap.execute(SetupViewCommand);
		
		processMap.setStage(main.stage);
		commandMap.execute(SetupEngineCommand);
		
		mediatorMap.mediate(main);
		
		var starlingObj:Starling = new Starling(Game, main.stage, new Rectangle(0, 0, main.stage.stageWidth, main.stage.stageHeight));
		//var mStarling:Starling = new Starling(Game, main.stage, new Rectangle(0, 0, 800, 600),null, Context3DRenderMode.SOFTWARE);
		mediatorMap.mediateWith(starlingObj, StarlingMediator);
		
		commandMap.execute(StartPreloadingCommand);
	
	}
	
	override protected function onDispose():void {
	
	}

}
}
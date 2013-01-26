package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.Main;
import com.mindscriptact.gdc2013.view.game.Game;
import com.mindscriptact.gdc2013.view.game.GameMediator;
import com.mindscriptact.gdc2013.view.main.MainMediator;
import com.mindscriptact.gdc2013.view.preload.PreloadView;
import com.mindscriptact.gdc2013.view.preload.PreloadViewMediator;
import com.mindscriptact.gdc2013.view.starling.StarlingMediator;
import org.mvcexpress.mvc.Command;
import starling.core.Starling;

/**
 * TODO:CLASS COMMENT
 * @author rBanevicius
 */
public class SetupViewCommand extends Command {
	
	//[Inject]
	//public var myProxy:MyProxy;
	
	public function execute(blank:Object):void {
		
		Starling, StarlingMediator;
		{
			mediatorMap.map(Game, GameMediator);
		}
		
		mediatorMap.map(Main, MainMediator);
		{
			mediatorMap.map(PreloadView, PreloadViewMediator);
		}
	
	}

}
}
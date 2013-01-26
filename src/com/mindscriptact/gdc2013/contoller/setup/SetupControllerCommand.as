package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.contoller.emotions.SpawnEmotionCommand;
import com.mindscriptact.gdc2013.contoller.game.StartNewGameCommand;
import com.mindscriptact.gdc2013.contoller.preload.DonePreloadCommand;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ViewMessage;
import com.mindscriptact.gdc2013.view.screens.GameOverScreenMediator;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author rBanevicius
 */
public class SetupControllerCommand extends Command {
	
	//[Inject]
	//public var myProxy:MyProxy;
	
	public function execute(blank:Object):void {
		
		commandMap.map(DataMessage.PRELOAD_DONE, DonePreloadCommand);
		commandMap.map(DataMessage.CONFIG_PARSED, SetupConfigModelCommand);
		
		commandMap.map(ViewMessage.PRESS_START_GAME, StartNewGameCommand);
		
		commandMap.map(Message.SPAWN_EMOTION, SpawnEmotionCommand);
	
	}

}
}
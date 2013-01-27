package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.contoller.debug.IncreaseLifeCommand;
import com.mindscriptact.gdc2013.contoller.debug.ReduceLifeCommand;
import com.mindscriptact.gdc2013.contoller.emotions.ConsumeEmotionCommand;
import com.mindscriptact.gdc2013.contoller.emotions.RemoveEmotionCommand;
import com.mindscriptact.gdc2013.contoller.emotions.SpawnEmotionCommand;
import com.mindscriptact.gdc2013.contoller.game.StartNewGameCommand;
import com.mindscriptact.gdc2013.contoller.preload.DonePreloadCommand;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.KeyMessage;
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
		commandMap.map(Message.CONSUME_EMOTION, ConsumeEmotionCommand);
		commandMap.map(Message.REMOVE_EMOTION, RemoveEmotionCommand);
		
		CONFIG::debug {
			commandMap.map(KeyMessage.KEY_F2, ReduceLifeCommand);
			commandMap.map(KeyMessage.KEY_F3, IncreaseLifeCommand);
		}
	
	}

}
}
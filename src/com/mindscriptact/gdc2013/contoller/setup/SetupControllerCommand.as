package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.contoller.preload.DonePreloadCommand;
import com.mindscriptact.gdc2013.messages.DataMessage;
import org.mvcexpress.mvc.Command;
	
/**
 * TODO:CLASS COMMENT
 * @author rBanevicius
 */
public class SetupControllerCommand extends Command{
	
	//[Inject]
	//public var myProxy:MyProxy;
	
	public function execute(blank:Object):void{
		
		
		commandMap.map(DataMessage.PRELOAD_DONE, DonePreloadCommand);
	}
	
}
}
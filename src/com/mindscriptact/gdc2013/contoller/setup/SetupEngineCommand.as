package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.engine.GameProcess;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class SetupEngineCommand extends Command {
	
	public function execute(blank:Object):void {
		processMap.mapFrameProcess(GameProcess);
		processMap.startProcess(GameProcess);
	}

}
}
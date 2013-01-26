package com.mindscriptact.gdc2013.engine {
import com.mindscriptact.gdc2013.engine.tasks.MoveTestImageTask;
import com.mindscriptact.gdc2013.messages.ProcessMessage;
import org.mvcexpress.live.Process;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameProcess extends Process {
	
	override protected function onRegister():void {
		addHandler(ProcessMessage.START_TEST_IMAGE_MOVE, handleStartTestImageMove);
	}
	
	private function handleStartTestImageMove(blank:Object):void {
		addTask(MoveTestImageTask);
	}

}
}
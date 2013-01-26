package com.mindscriptact.gdc2013.engine {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.engine.tasks.MoveEmotionsTask;
import com.mindscriptact.gdc2013.engine.tasks.MoveHeroTask;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ProcessMessage;
import org.mvcexpress.live.Process;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameProcess extends Process {
	
	override protected function onRegister():void {
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
		
		addHandler(ProcessMessage.START_TEST_IMAGE_MOVE, handleShowScreen);
	}
	
	private function handleShowScreen(screenName:String):void {
		if (screenName == ScreenIds.GAME) {
			addTask(MoveHeroTask);
			addTask(MoveEmotionsTask);
		} else {
			removeTask(MoveHeroTask);
			removeTask(MoveEmotionsTask);
		}
	}

}
}
package com.mindscriptact.gdc2013.engine {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.engine.tasks.EmotionSpawnTask;
import com.mindscriptact.gdc2013.engine.tasks.HeroCollideEmotionTask;
import com.mindscriptact.gdc2013.engine.tasks.MoveEmotionsTask;
import com.mindscriptact.gdc2013.engine.tasks.MoveHeroTask;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.messages.ProcessMessage;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import org.mvcexpress.live.Process;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameProcess extends Process {
	
	
	override protected function onRegister():void {
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
		
		addHandler(ProcessMessage.START_TEST_IMAGE_MOVE, handleShowScreen);
		
		addTask(EmotionSpawnTask);
		addTask(MoveHeroTask);
		addTask(MoveEmotionsTask);
		addTask(HeroCollideEmotionTask);
		
		disableTask(EmotionSpawnTask);
		disableTask(MoveHeroTask);
		disableTask(MoveEmotionsTask);
		disableTask(HeroCollideEmotionTask);
	
	}
	
	private function handleShowScreen(screenName:String):void {
		if (screenName == ScreenIds.GAME) {
			enableTask(EmotionSpawnTask);
			enableTask(MoveHeroTask);
			enableTask(MoveEmotionsTask);
			enableTask(HeroCollideEmotionTask);
		} else {
			disableTask(EmotionSpawnTask);
			disableTask(MoveHeroTask);
			disableTask(MoveEmotionsTask);
			disableTask(HeroCollideEmotionTask);
		}
	}

}
}
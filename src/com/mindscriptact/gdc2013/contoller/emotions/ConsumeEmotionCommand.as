package com.mindscriptact.gdc2013.contoller.emotions {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import org.mvcexpress.mvc.Command;
import org.mvcexpress.mvc.PooledCommand;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class ConsumeEmotionCommand extends PooledCommand {
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	[Inject]
	public var heroProxy:HeroProxy;
	
	public function execute(emotion:EmotionData):void {
		trace("ConsumeEmotionCommand.execute > emotion : " + emotion);
		
		heroProxy.changeHeart(emotionProxy.getEmotionStrength(emotion.emotionId));
		
		var heartState:int = heroProxy.getHeartState();
		
		var life:int = heroProxy.getHeroConfig().life;
		
		if (heartState > life) {
			sendMessage(Message.SHOW_SCREEN, ScreenIds.GAMEOVER);
		}
		
		if (heartState < -life) {
			sendMessage(Message.SHOW_SCREEN, ScreenIds.GAMEOVER);
		}
		
		emotionProxy.removeEmotion(emotion);
	
	}

}
}
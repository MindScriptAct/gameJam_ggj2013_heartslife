package com.mindscriptact.gdc2013.contoller.game {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.ConsumeHystoryProxy;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import flash.display.ShaderPrecision;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class StartNewGameCommand extends Command {
	
	[Inject]
	public var heroProxy:HeroProxy;
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	[Inject]
	public var gameProxy:GameProxy;
	
	[Inject]
	public var consumeHystoryProxy:ConsumeHystoryProxy;
	
	public function execute(blank:Object):void {
		
		heroProxy.setToDefault();
		
		emotionProxy.removeAll();
		
		emotionProxy.resetSpawnTimer();
		
		gameProxy.resetScore();
		
		consumeHystoryProxy.reset();
		
		sendMessage(Message.SHOW_SCREEN, ScreenIds.GAME);
	
	}

}
}
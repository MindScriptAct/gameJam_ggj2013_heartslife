package com.mindscriptact.gdc2013.contoller.emotions {
import com.gamua.flox.Flox;
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.Main;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.ConsumeHystoryProxy;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import com.mindscriptact.gdc2013.view.main.MainMediator;
import flash.media.SoundTransform;
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
	
	[Inject]
	public var gameProxy:GameProxy;
	
	[Inject]
	public var consumeHystoryProxy:ConsumeHystoryProxy;
	
	public function execute(emotion:EmotionData):void {
		//trace("ConsumeEmotionCommand.execute > emotion : " + emotion);
		
		var emotionConfig:EmotionsConfigVO = emotionProxy.getConfig();
		
		// score
		gameProxy.increaseScore(emotionProxy.getEmotionScore(emotion.emotionId));
		
		// register history
		consumeHystoryProxy.rememberEmotion(emotion.emotionId, emotion.strength > 0);
		
		// TODO ... check for score..
		var comboSize:int = consumeHystoryProxy.getHystoryChain();
		if (comboSize > emotionConfig.comboStarts) {
			gameProxy.increaseScore((comboSize - emotionConfig.comboStarts) * emotionConfig.comboScores);
		}
		
		if (MainMediator.currentScreen == ScreenIds.GAME)
			AssetLibrary.playMP3("eat", 0, 0, new SoundTransform(0.4));
		//emotionProxy.removeAll();
		
		// change life
		heroProxy.changeHeart(emotionProxy.getEmotionStrength(emotion.emotionId));
		
		// game over check.
		var heartState:int = heroProxy.getHeartState();
		var life:int = heroProxy.getHeroConfig().life;
		if (heartState >= life || heartState <= -life) {
			sendMessage(Message.SHOW_SCREEN, ScreenIds.GAMEOVER);
			
			if (Main.FLOX_ENABLED) {
				var score:int = gameProxy.getScore();
				Flox.postScore("Top-10-gjj-heartslife", score, "Guest");
			}
			
		}
		
		emotionProxy.removeEmotion(emotion);
	
	}

}
}
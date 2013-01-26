package com.mindscriptact.gdc2013.contoller.emotions {
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import org.mvcexpress.mvc.PooledCommand;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class SpawnEmotionCommand extends PooledCommand {
	
	[Inject]
	public var emotionProxy:EmotionProxy;
	
	[Inject]
	public var heroProxy:HeroProxy;
	
	public function execute(blank:Object):void {
		
		// todo
		var id:int = Math.floor(Math.random() * 6) + 1;
		var emotionData:EmotionData = new EmotionData(id);
		
		var angle:Number = Math.random() * Math.PI * 2;
		//var angle:Number = 0.5 * Math.PI;
		
		var heroConfig:HeroConfigVO = heroProxy.getHeroConfig();
		
		var spawnRadius:int = emotionProxy.getEnemySpawnRadius() - 2
		
		emotionData.x = heroConfig.startingXPos + Math.sin(angle) * spawnRadius;
		emotionData.y = heroConfig.startingYPos + Math.cos(angle) * spawnRadius;
		
		var emotionConfig:EmotionsConfigVO = emotionProxy.getConfig();
		
		emotionData.vectorX = Math.random() * emotionConfig.emotionMoveSpeeed + emotionConfig.emotionMoveRandom;
		emotionData.vectorY = Math.random() * emotionConfig.emotionMoveSpeeed + emotionConfig.emotionMoveRandom;
		
		if (emotionData.x > heroConfig.startingXPos) {
			emotionData.vectorX *= -1;
		}
		if (emotionData.y > heroConfig.startingYPos) {
			emotionData.vectorY *= -1;
		}
		emotionProxy.addEmotion(emotionData);
	}

}
}
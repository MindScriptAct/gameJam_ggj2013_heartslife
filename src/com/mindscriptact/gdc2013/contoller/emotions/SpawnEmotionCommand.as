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
		
		//var id:int = 1
		//
		//var emotionData:EmotionData = new EmotionData(id);
		//
		//emotionData.x
		//emotionData.y
		
		//*
		
		// todo
		var id:int = Math.floor(Math.random() * 10) + 1;
		var emotionData:EmotionData = new EmotionData(id);
		
		var angle:Number = Math.random() * Math.PI * 2;
		//var angle:Number = 0.5 * Math.PI;
		
		var heroConfig:HeroConfigVO = heroProxy.getHeroConfig();
		
		var spawnRadius:int = emotionProxy.getEnemySpawnRadius() - 2
		
		emotionData.x = heroConfig.startingXPos + Math.sin(angle) * (spawnRadius-20);
		emotionData.y = heroConfig.startingYPos + Math.cos(angle) * (spawnRadius-20);
		
		angle = Math.random() * Math.PI * 2;
		var emotionTargetX:Number = heroConfig.startingXPos + Math.sin(angle) * spawnRadius / 3;
		var emotionTargetY:Number = heroConfig.startingYPos + Math.cos(angle) * spawnRadius / 3;
		
		var emotionConfig:EmotionsConfigVO = emotionProxy.getConfig();
		emotionData.strength = emotionProxy.getEmotionStrength(id);
		
		var speed:Number = Math.random() * emotionConfig.emotionMoveRandom + emotionConfig.emotionMoveSpeeed;
		emotionData.vectorX = (emotionTargetX - emotionData.x);
		emotionData.vectorY = (emotionTargetY - emotionData.y);
		
		var length:Number = Math.sqrt(emotionData.vectorX * emotionData.vectorX + emotionData.vectorY * emotionData.vectorY);
		if (length == 0)
			length = 0.001
		
		emotionData.vectorX = emotionData.vectorX / length * speed;
		emotionData.vectorY = emotionData.vectorY / length * speed;
		
		emotionData.rotation = Math.random() * emotionConfig.emotionRotateRandom + emotionConfig.emotionRotateSpeeed;
		
		if (Math.random() > 0.5) {
			emotionData.rotation *= -1;
		}
		
		//emotionData.vectorX = Math.random() * emotionConfig.emotionMoveRandom + emotionConfig.emotionMoveSpeeed;
		//emotionData.vectorY = Math.random() * emotionConfig.emotionMoveRandom + emotionConfig.emotionMoveSpeeed;
		
		/*if (emotionData.x > heroConfig.startingXPos) {
		   emotionData.vectorX *= -1;
		   }
		   if (emotionData.y > heroConfig.startingYPos) {
		   emotionData.vectorY *= -1;
		 }*/
		
		emotionProxy.addEmotion(emotionData);
	
		//*/
	}

}
}
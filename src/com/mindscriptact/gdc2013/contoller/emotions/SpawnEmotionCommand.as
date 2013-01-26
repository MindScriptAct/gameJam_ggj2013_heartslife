package com.mindscriptact.gdc2013.contoller.emotions {
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
		
		var angle:Number = Math.random() * Math.PI;
		
		var spawnRadius:int = emotionProxy.getEnemySpawnRadius() - 2
		
		emotionData.x = heroProxy.getHeroPosX() + Math.sin(angle) * spawnRadius;
		emotionData.y = heroProxy.getHeroPosY() + Math.cos(angle) * spawnRadius;
		
		emotionData.vectorX = Math.random() * 5 + 2;
		emotionData.vectorY = Math.random() * 5 + 2;
		
		if (emotionData.x > heroProxy.getHeroPosX()) {
			emotionData.vectorX *= -1;
		}
		if (emotionData.y > heroProxy.getHeroPosY()) {
			emotionData.vectorY *= -1;
		}
		emotionProxy.addEmotion(emotionData);
	}

}
}
package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.model.config.data.AllConfigsVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.game.GameProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class SetupConfigModelCommand extends Command {
	
	public function execute(allConfig:AllConfigsVO):void {
		proxyMap.map(new HeroProxy(allConfig.heroConfig));
		proxyMap.map(new GameProxy(allConfig.gameConfig));
		proxyMap.map(new EmotionProxy(allConfig.emotionConfig));
	}

}
}
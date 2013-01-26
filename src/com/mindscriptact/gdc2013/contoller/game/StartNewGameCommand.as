package com.mindscriptact.gdc2013.contoller.game {
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.messages.Message;
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
	
	public function execute(blank:Object):void {
		
		heroProxy.setToDefault();
		
		
		sendMessage(Message.SHOW_SCREEN, ScreenIds.GAME);
	
	}

}
}
package com.mindscriptact.gdc2013.contoller.debug {
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class ReduceLifeCommand extends Command {
	
	[Inject]
	public var heroProxy:HeroProxy;
	
	public function execute(blank:Object):void {
		heroProxy.changeHeart(-4);
	}

}
}
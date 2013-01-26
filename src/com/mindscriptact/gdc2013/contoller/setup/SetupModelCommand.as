package com.mindscriptact.gdc2013.contoller.setup {
import com.mindscriptact.gdc2013.model.keyboard.KeyboardProxy;
import com.mindscriptact.gdc2013.model.preload.PreloadProxy;
import flash.display.Stage;
import org.mvcexpress.mvc.Command;

/**
 * TODO:CLASS COMMENT
 * @author rBanevicius
 */
public class SetupModelCommand extends Command {
	
	//[Inject]
	//public var myProxy:MyProxy;
	
	public function execute(stage:Stage):void {
		
		proxyMap.map(new KeyboardProxy(stage));
		
		proxyMap.map(new PreloadProxy());
	
	}

}
}
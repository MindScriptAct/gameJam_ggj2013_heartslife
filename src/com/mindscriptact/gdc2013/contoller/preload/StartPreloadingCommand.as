package com.mindscriptact.gdc2013.contoller.preload{
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.preload.PreloadProxy;
import org.mvcexpress.mvc.Command;
	
/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class StartPreloadingCommand extends Command {
	
	
	
	[Inject]
	public var preloadProxy:PreloadProxy;
	
	public function execute(blank:Object):void {
		
		sendMessage(Message.SHOW_LOADER);
		
		preloadProxy.startPreloading();
		
	}
	
}
}
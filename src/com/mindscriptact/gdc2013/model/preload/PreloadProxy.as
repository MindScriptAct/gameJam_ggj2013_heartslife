package com.mindscriptact.gdc2013.model.preload {
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.assetLibrary.AssetLibraryIndex;
import com.mindscriptact.assetLibrary.AssetLibraryLoader;
import com.mindscriptact.assetLibrary.assets.XMLAsset;
import com.mindscriptact.assetLibrary.event.AssetEvent;
import com.mindscriptact.gdc2013.constants.AssetIds;
import com.mindscriptact.gdc2013.constants.PreloadSteps;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.model.config.data.GameConfigVO;
import com.mindscriptact.utils.xml.XmlHelper;
import org.mvcexpress.mvc.Proxy;

/**
 * TODO:CLASS COMMENT
 * @author rBanevicius
 */
public class PreloadProxy extends Proxy {
	
	private var preloadingStep:int = PreloadSteps.PRELOAD_PERNAMENTS
	private var assetLibLoader:AssetLibraryLoader;
	;
	
	public function PreloadProxy() {
	}
	
	override protected function onRegister():void {
	}
	
	public function startPreloading():void {
		doNextStep();
	}
	
	private function doNextStep():void {
		if (preloadingStep == PreloadSteps.PRELOAD_PERNAMENTS) {
			var assetLibIndex:AssetLibraryIndex = AssetLibrary.getIndex();
			assetLibIndex.addAssetsFromXML("xml/Assets.xml");
			
			assetLibLoader = AssetLibrary.getLoader();
			assetLibLoader.addEventListener(AssetEvent.ALL_PERMANENTS_LOADED, handleAllPernamentsLoaded);
			assetLibLoader.addEventListener(AssetEvent.ASSET_LOADING_STARTED, handleaAssetLoaded);
			assetLibLoader.preloadPermanents();
			
		} else if (preloadingStep == PreloadSteps.PRELOAD_CONFIG) {
			
			AssetLibrary.sendAssetToFunction(AssetIds.CONFIG_XML, handleXmlAsset);
			
			sendMessage(DataMessage.LOAD_STEP_REPORT, "Loading configs...");
		}
	
	}
	
	private function handleaAssetLoaded(event:AssetEvent):void {
		//trace("PreloadProxy.handleaAssetLoaded > event : " + event);
		sendMessage(DataMessage.LOAD_STEP_REPORT, "Loading " + event.assetId + "...");
	}
	
	private function handleAllPernamentsLoaded(event:AssetEvent):void {
		//trace("PreloadProxy.handleAllPernamentsLoaded > event : " + event);
		sendMessage(DataMessage.LOAD_STEP_REPORT, "All pernaments loaded.");
		
		assetLibLoader.removeEventListener(AssetEvent.ALL_PERMANENTS_LOADED, handleAllPernamentsLoaded);
		assetLibLoader.removeEventListener(AssetEvent.ASSET_LOADING_STARTED, handleaAssetLoaded);
		assetLibLoader = null;
		
		preloadingStep = PreloadSteps.PRELOAD_CONFIG;
		
		doNextStep();
	}
	
	private function handleXmlAsset(asset:XMLAsset):void {
		//trace("PreloadProxy.handleXmlAsset > asset : " + asset);
		sendMessage(DataMessage.LOAD_STEP_REPORT, "Parsing configs...");
		
		var config:GameConfigVO = XmlHelper.fillObjectWithXml(GameConfigVO, asset.getXml()) as GameConfigVO;
		
		
		// use config..
		
		sendMessage(DataMessage.PRELOAD_DONE);
	}
	
	override protected function onRemove():void {
	
	}

}
}
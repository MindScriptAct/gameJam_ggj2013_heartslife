package com.mindscriptact.assetLibrary.assets {
import com.mindscriptact.assetLibrary.AssetAbstract;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.media.Sound;

/**
 * Wraper for swf asset
 * @author Raimundas Banevicius
 */
public class SWFAsset extends AssetAbstract {

	public function SWFAsset(assetId:String){
		super(assetId);
	}

	/**
	 * Gives instance of SWF file stage.
	 * It can be used only once(this function does not create instance of the stage, it gives stage itself.)
	 * If you need to use it twice - create MovieClip object in library instead.
	 * @return	Content of swf file stage.
	 */
	public function getStageContent():MovieClip {
		if ((content as MovieClip).stage != null) {
			throw Error("AssetSWF content is already added to display list. You can't use it twice, remove first instance from display list. [assetId:" + assetId+"]");
		}
		return content as MovieClip;
	}
	
	/**
	 * Gives instance of MovieClip object from library
	 * @param	lincageId	object lincage id in swf file library
	 * @return	instance of MovieClip taken from asset library, using lincageId
	 */
	public function getMovieClip(lincageId:String):MovieClip {
		if (!_isLoaded){
			throw Error("AssetSWF has no loaded content. assetID:" + assetId);
		}
		try {
			var lincageClass:Class = applicationDomain.getDefinition(lincageId) as Class;
		} catch (error:Error){
			throw Error("AssetSWF could not find class with lincageId:" + lincageId + " in assetID:" + assetId);
		}
		return new lincageClass();
	}
	
	/**
	 * Gives instance of Sprite object from library
	 * @param	lincageId	object lincage id in swf file library
	 * @return	instance of Sprite taken from asset library, using lincageId
	 */
	public function getSprite(lincageId:String):Sprite {
		if (!_isLoaded){
			throw Error("AssetSWF has no loaded content. assetID:" + assetId);
		}
		try {
			var lincageClass:Class = applicationDomain.getDefinition(lincageId) as Class;
		} catch (error:Error){
			throw Error("AssetSWF could not find class with lincageId:" + lincageId + " in assetID:" + assetId);
		}
		return new lincageClass();
	}
	
	/**
	 * Gives instance of SimpleButton object from library
	 * @param	lincageId	object lincage id in swf file library
	 * @return	instance of SimpleButton taken from asset library, using lincageId
	 */
	public function getSimpleButton(lincageId:String):SimpleButton {
		if (!_isLoaded){
			throw Error("AssetSWF has no loaded content. assetID:" + assetId);
		}
		try {
			var lincageClass:Class = applicationDomain.getDefinition(lincageId) as Class;
		} catch (error:Error){
			throw Error("AssetSWF could not find class with lincageId:" + lincageId + " in assetID:" + assetId);
		}
		return new lincageClass();
	}
	
	/**
	 * Gives instance of BitmapData object from library
	 * @param	lincageId	object lincage id in swf file library
	 * @return	instance of BitmapData taken from asset library, using lincageId
	 */
	public function getBitmapData(lincageId:String):BitmapData {
		if (!_isLoaded){
			throw Error("AssetSWF has no loaded content. assetID:" + assetId);
		}
		try {
			var lincageClass:Class = applicationDomain.getDefinition(lincageId) as Class;
		} catch (error:Error){
			throw Error("AssetSWF could not find class with lincageId:" + lincageId + " in assetID:" + assetId);
		}
		return new lincageClass();
	}
	
	/**
	 * Gives instance of Sound object from library
	 * @param	lincageId	object lincage id in swf file library
	 * @return	instance of Sound taken from asset library, using lincageId
	 */
	public function getSound(lincageId:String):Sound {
		if (!_isLoaded){
			throw Error("AssetSWF has no loaded content. assetID:" + assetId);
		}
		try {
			var lincageClass:Class = applicationDomain.getDefinition(lincageId) as Class;
		} catch (error:Error){
			throw Error("AssetSWF could not find class with lincageId:" + lincageId + " in assetID:" + assetId);
		}
		return new lincageClass();
	}	

}
}
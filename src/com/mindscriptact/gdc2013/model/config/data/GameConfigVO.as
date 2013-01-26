package com.mindscriptact.gdc2013.model.config.data {
	import com.mindscriptact.gdc2013.model.config.data.ItemsVO;

/**
 * COMMENT
 * @author Deril
 */
public class GameConfigVO {
	
	public var gameName:String;
	public var heroSize:int;
	public var speed:Number;
	
	public var debug:Boolean;
	
	public var itemList:Vector.<ItemsVO> = new Vector.<ItemsVO>();
	
	
}
}
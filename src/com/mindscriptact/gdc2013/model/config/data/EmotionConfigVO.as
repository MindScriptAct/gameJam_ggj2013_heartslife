package com.mindscriptact.gdc2013.model.config.data {

/**
 * COMMENT
 * @author Deril
 */
public class EmotionConfigVO {
	
	public var size:int;
	
	public var spawnRateStarting:Number;
	public var spawnRateChange:Number;
	
	public var waveProgressStarting:Number;
	public var waveProgressSpeed:Number;
	public var waveGrowRate:Number;
	
	public var spawnRadius:int;
		
		public var emotions:Vector.<EmotionVO> = new Vector.<EmotionVO>();
}
}
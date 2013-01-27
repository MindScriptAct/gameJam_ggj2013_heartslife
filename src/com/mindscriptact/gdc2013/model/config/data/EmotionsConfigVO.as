package com.mindscriptact.gdc2013.model.config.data {

/**
 * COMMENT
 * @author Deril
 */
public class EmotionsConfigVO {
	
	public var size:int;
	public var assetSize:int;
	
	public var waveProgressStarting:Number;
	public var waveProgressSpeed:Number;
	
	public var waveGrowRate:Number;
	public var spawnRateStart:int;
	
	public var emotionMoveSpeeed:Number;
	public var emotionMoveRandom:Number;
	
	public var spawnRadius:int;
	
	public var penaltyPercentage:Number;
	
	
	public var maxPull:Number;
	public var maxPush:Number;

	public var emotions:Vector.<EmotionVO> = new Vector.<EmotionVO>();
}
}
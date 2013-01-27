package com.mindscriptact.gdc2013.model.config.data {

/**
 * COMMENT
 * @author Deril
 */
public class EmotionsConfigVO {
	
	public var size:int;
	public var assetSize:int;
	
	public var spawnRateStart:int;
	public var spawnRateChange:Number;
	public var spawnRateMin:Number;
	
	
	public var emotionMoveSpeeed:Number;
	public var emotionMoveRandom:Number;
	
	public var emotionRotateSpeeed:Number;
	public var emotionRotateRandom:Number;
	
	public var spawnRadius:int;
	
	public var penaltyPercentage:Number;
	
	
	public var maxPull:Number;
	public var maxPush:Number;
	
	
	
	
	public var comboStarts:int;
	public var comboScores:int;

	public var emotions:Vector.<EmotionVO> = new Vector.<EmotionVO>();
}
}
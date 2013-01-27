package com.mindscriptact.gdc2013.model.emotian {

/**
 * COMMENT
 * @author Deril
 */
public class EmotionData {
	
	public var emotionId:int;
	public var x:Number;
	public var y:Number;
	public var vectorX:Number;
	public var vectorY:Number;
	
	public var strength:int;
	
	public function EmotionData(emotionId:int) {
		this.emotionId = emotionId;
	
	}

}
}
package com.mindscriptact.gdc2013.view.main.elemets {
import adobe.utils.CustomActions;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.getTimer;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;

/**
 * ...
 * @author Raimundas Sakalauskas, www.PinStudios.com
 */
public class CardioChart extends Sprite {
	private var _bitmapWidth:int;
	private var _bitmapHeight:int;
	
	private var _bitmap:Bitmap;
	private var _bitmapData:BitmapData;
	private var _bitmapRect:Rectangle;
	private var _clearRect:Rectangle;
	
	private var _steps:int;
	private var _margins:int;
	private var _color:uint;
	
	private var _dotBitmap:BitmapData;
	private var _dotRect:Rectangle;
	private var _dotPos:Point;
	private var _dotMatrix:Matrix;
	
	private var _nextBeat:uint;
	private var _animationFrame:int;
	
	private var _currentPos:int = 0;
	private var _scrollSpeed:int = 2;
	private var _amplitude:Number = 50;
	private var _delay:int = 500;
	
	private var _glowFilter:GlowFilter;
	private var _filterRect:Rectangle;
	private var _zeroPoint:Point;
	
	public function CardioChart(width:int, height:int, steps:int, color:uint, maxAmplitude:int) {
		_bitmapWidth = width;
		_bitmapHeight = height;
		
		_steps = steps;
		_color = color;
		
		_zeroPoint = new Point(0, 0);
		_bitmapData = new BitmapData(_bitmapWidth, maxAmplitude * 2 + 1+20, true, 0x00000000);
		
		_bitmap = new Bitmap(_bitmapData);
		_bitmapRect = new Rectangle(0, 0, _bitmapWidth, _bitmapData.height);
		_clearRect = new Rectangle(0, 0, _scrollSpeed, _bitmapData.height);
		addChild(_bitmap);
		
		_dotBitmap = new BitmapData(1, 1, false, _color);
		_dotRect = new Rectangle(0, 0, _dotBitmap.width, _dotBitmap.height);
		_dotPos = new Point(0, Math.floor(_bitmapData.height / 2));
		_dotMatrix = new Matrix();
		
		_glowFilter = new GlowFilter(_color, 0.4, 6, 6, 2);
		_filterRect = new Rectangle(0, 0, _scrollSpeed, _bitmapRect.height);
		
		reset();
	}
	
	public function reset():void {
		_animationFrame = -1;
		
		_currentPos = 0;
		updateBitmapPos();
		
		_dotPos.x = 0;
		_dotPos.y = Math.floor(_bitmapData.height / 2);
		
		_nextBeat = getTimer() + _delay;
		
		_bitmapData.lock();
		_bitmapData.fillRect(_bitmapRect, 0x00000000);
		
		for (var i:int = 0; i < _bitmapRect.width; i = i + _scrollSpeed)
		{
			onEnterFrame(null, true);
		}
		
		_bitmapData.unlock();
	}
	
	public function start():void {
		if (!hasEventListener(Event.ENTER_FRAME))
			addEventListener(Event.ENTER_FRAME, onEnterFrame)
		
		reset();
	}
	
	public function pause():void {
		if (hasEventListener(Event.ENTER_FRAME))
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event, startup:Boolean = false):void {
		
		if (!startup)
			_bitmapData.lock();
		
		//scroll and clear
		_bitmapData.scroll(_scrollSpeed, 0);
		_bitmapData.fillRect(_clearRect, 0x00000000);
		
		//reset to center
		var newY:Number = Math.floor(_bitmapData.height / 2);
		
		//eval if animation should start
		if ((getTimer() > _nextBeat) && (_nextBeat != int.MAX_VALUE)) {
			_nextBeat = int.MAX_VALUE;
			_animationFrame = 0;
			//todo: dispatch sound event
		}
		
		//animate (if needed)
		newY += evalFrame();
		
		//draw smooth curve
		var distX:int = _scrollSpeed;
		var distY:int = Math.round(newY - _dotPos.y);
		
		var dist:int = Math.max(Math.floor(Math.abs(newY - _dotPos.y)), distX);
		
		var stepY:int = (distY == 0) ? 0 : ((distY > 0) ? 1 : -1);
		var stepX:Number = distX / dist;
		
		for (var i:int = 0; i < dist; i++) {
			_dotPos.x = (stepX * (dist - i));
			_dotPos.y += stepY;
			drawPixel();
		}
		
		_dotPos.y = newY;
		_dotPos.x = 0;
		drawPixel();
		//end of draw smooth curve
		
		_bitmapData.applyFilter(_bitmapData, _filterRect, _zeroPoint, _glowFilter);
		
		if (!startup)
			_bitmapData.unlock();
	}
	
	private function drawPixel():void {
		//_dotMatrix.identity();
		_dotMatrix.translate(_dotPos.x, _dotPos.y);
		_bitmapData.draw(_dotBitmap, _dotMatrix, null, null, null, true);
		_dotMatrix.translate(-_dotPos.x, -_dotPos.y);
		//_bitmapData.copyPixels(_dotBitmap, _dotRect, _dotPos, null, null, true);
	}
	
	private function evalFrame():Number {
		_animationFrame++;
		switch (_animationFrame) {
			case 0: 
				_animationFrame--;
				return 0;
				break;
			case 1: 
			case 2: 
			case 3: 
				return (_animationFrame) / 3 * (_amplitude);
				break;
			case 4: 
				return -1 * _amplitude;
				break;
			case 5: 
				return _amplitude * 0.25
				break;
			case 6: 
				return _amplitude * 0.5
				break;
			case 7: 
				return _amplitude * 0.25
				break;
			case 8: 
				return 0;
				break;
			case 9: 
				return -1 * _amplitude / 4;
				break;
			case 10: 
				return 0;
				break;
			case 11: 
				return _amplitude / 8;
				break;
			case 12: 
				_animationFrame = -1;
				_nextBeat = getTimer() + _delay;
				return 0;
				break;
		}
		return 0;
	
	}
	
	private function updateBitmapPos():void {
		
		var maxOffset:int = (_bitmapHeight - _bitmapData.height) / 2;
		var tween:Tween = new Tween(_bitmap, 0.2, Transitions.EASE_IN_OUT);
		tween.moveTo(_bitmap.x, maxOffset + maxOffset * (_currentPos / _steps));
		Starling.juggler.add(tween);
	}
	
	public function add(value:int = 1):void {
		_currentPos -= value;
		if (_currentPos < -1 * _steps)
			_currentPos = -1 * _steps;
		
		updateBitmapPos();
	}
	
	public function substract(value:int = 1):void {
		_currentPos += value;
		if (_currentPos > _steps)
			_currentPos = _steps;
		
		updateBitmapPos();
	}
	
	public function get amplitude():Number {
		return _amplitude;
	}
	
	public function set amplitude(value:Number):void {
		_amplitude = value;
	}
	
	/*public function get scrollSpeed():int
	   {
	   return _scrollSpeed;
	   }
	
	   public function set scrollSpeed(value:int):void
	   {
	   _clearRect.width = value;
	   _scrollSpeed = value;
	 }*/
	
	public function get delay():int {
		return _delay;
	}
	
	public function set delay(value:int):void {
		_delay = value;
	}
	
	override public function get height():Number {
		return _bitmapHeight;
	}
	
	public function get currentPos():int {
		return _currentPos;
	}
}
}	
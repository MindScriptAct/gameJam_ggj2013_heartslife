package com.mindscriptact.gdc2013.view.main {
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.Main;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import com.mindscriptact.gdc2013.view.main.elemets.CardioChart;
import com.mindscriptact.gdc2013.view.preload.PreloadView;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MainMediator extends Mediator {
	private var loader:PreloadView;
	private var screen:Sprite;
	private var debugSprite:Sprite;
	
	CONFIG::debug
	private var heartTestlabel:Label;
	
	private var uiSprite:Sprite;
	
	[Inject]
	public var view:Main;
	
	override public function onRegister():void {
		addHandler(Message.SHOW_LOADER, handleShowLoader);
		addHandler(Message.HIDE_LOADER, handleHideLoader);
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
		
		uiSprite = new Sprite();
		view.addChild(uiSprite);
		
		//var cardio:CardioChart = 
		
		
		CONFIG::debug {
			debugSprite = new Sprite();
			view.addChild(debugSprite);
			
			addHandler(Message.INIT_GAME_ELEMENT, handleInitDebugShow);
			
			addHandler(DataMessage.HERO_HEART_CHANGED, handleHeroHeartChange);
			
			new PushButton(debugSprite, 1100, 800, "spawnEmotion", handleSpawn);
			
			heartTestlabel = new Label(debugSprite, 1100, 400, "-");
		}
	}
	
	CONFIG::debug
	private function handleHeroHeartChange(heartStat:int):void {
		heartTestlabel.text = String(heartStat);
	}
	
	CONFIG::debug
	private function handleSpawn(event:Event):void {
		sendMessage(Message.SPAWN_EMOTION);
	}
	
	CONFIG::debug
	private function handleInitDebugShow(blank:Object):void {
		var heroProxy:HeroProxy = proxyMap.getProxy(HeroProxy) as HeroProxy;
		var heroConfig:HeroConfigVO = heroProxy.getHeroConfig();
		
		var emotionProxy:EmotionProxy = proxyMap.getProxy(EmotionProxy) as EmotionProxy;
		var emotionConfig:EmotionsConfigVO = emotionProxy.getConfig();
		
		var circle:Shape = new Shape();
		circle.graphics.lineStyle(0.1, 0xFF0000);
		circle.graphics.drawCircle(0, 0, heroConfig.moveRadius);
		circle.graphics.endFill();
		debugSprite.addChild(circle);
		circle.x = heroConfig.startingXPos;
		circle.y = heroConfig.startingYPos;
		
		circle = new Shape();
		circle.graphics.lineStyle(0.1, 0x8000FF);
		circle.graphics.drawCircle(0, 0, emotionConfig.spawnRadius);
		circle.graphics.endFill();
		debugSprite.addChild(circle);
		circle.x = heroConfig.startingXPos;
		circle.y = heroConfig.startingYPos;
	
	}
	
	override public function onRemove():void {
	
	}
	
	private function handleShowScreen(screenName:String):void {
		if (screen) {
			view.removeChild(screen);
			mediatorMap.unmediate(screen);
			screen = null;
		}
		switch (screenName) {
			case ScreenIds.START: 
				screen = new StartScreenSPR();
				break;
			case ScreenIds.GAME: 
				screen = new GameScreenSPR();
				break;
			case ScreenIds.GAMEOVER: 
				screen = new GameOverScreenSPR();
				break;
			default: 
				throw Error("TODO")
		}
		if (screen) {
			view.addChild(screen);
			mediatorMap.mediate(screen);
		}
		
		uiSprite.visible = screenName == ScreenIds.GAME;
		
		CONFIG::debug {
			debugSprite.visible = screenName == ScreenIds.GAME;
		}
	}
	
	private function handleShowLoader(blank:Object):void {
		loader = new PreloadView();
		view.addChild(loader);
		mediatorMap.mediate(loader);
	}
	
	private function handleHideLoader(blank:Object):void {
		mediatorMap.unmediate(loader);
		view.removeChild(loader);
		loader = null;
	}

}
}
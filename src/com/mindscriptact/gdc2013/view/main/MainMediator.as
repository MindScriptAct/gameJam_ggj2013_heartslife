package com.mindscriptact.gdc2013.view.main {
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.assetLibrary.assets.PICAsset;
import com.mindscriptact.gdc2013.constants.AssetIds;
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
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.media.SoundTransform;
import org.mvcexpress.mvc.Mediator;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MainMediator extends Mediator {
	private var loader:PreloadView;
	private var screen:Sprite;
	
	//private var debugSprite:Sprite;
	
	//CONFIG::debug
	//private var heartTestlabel:Label;
	
	private var uiSprite:Sprite;
	private var cardio:CardioChart;
	private var maxLife:int
	
	//TODO: HACK!!!
	public static var currentScreen:String;
	
	[Inject]
	public var view:Main;
	
	override public function onRegister():void {
		
		//if (view == null) {
		//throw Error("AAAAA");
		//}
		
		addHandler(Message.SHOW_LOADER, handleShowLoader);
		addHandler(Message.HIDE_LOADER, handleHideLoader);
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
		
		uiSprite = new Sprite();
		//try {
		view.addChild(uiSprite);
		//} catch (error:Error) {
		//throw Error("WTF");
		//}
		
		uiSprite.mouseChildren = false;
		uiSprite.mouseEnabled = false;
		
		//AssetLibrary.sendAssetToFunction(AssetIds.BACKGROUND, handleBgPic);
		//var backBitmap:Bitmap = AssetLibrary.getPICBitmap(AssetIds.BACKGROUND);
		//
		
		//cardio.amplitude = 50;
		//cardio.delay = 150;
		//cardio.add(20)
		
		//cardio.amplitude = 0;
		//cardio.delay = 1000;
		//cardio.substract(20);
		
		//cardio.delay = 10;
		//cardio.x = 1040;
		//cardio.y = 400 - 200;
		//
		//
		//
		//cardio.delay = 300;
		//cardio.x = 1040;
		//cardio.y = 400 + 200;	
		
		addHandler(Message.INIT_GAME_ELEMENT, handleInitDebugShow);
		
		//CONFIG::debug {
		//debugSprite = new Sprite();
		//view.addChild(debugSprite);
		//
		//
		//new PushButton(debugSprite, 1100, 800, "spawnEmotion", handleSpawn);
		//
		//heartTestlabel = new Label(debugSprite, 1100, 400, "-");
		//}
		addHandler(DataMessage.HERO_HEART_CHANGED, handleHeroHeartChange);
	
	}
	
	private function handleBgPic(asset:PICAsset):void {
	
	}
	
	private function handleHeroHeartChange(heartStat:int):void {
		
		if (cardio) {
			//heartTestlabel.text = String(heartStat);
			cardio.add(cardio.currentPos - heartStat);
			cardio.amplitude = 50 * (1 - (cardio.currentPos + maxLife) / (maxLife * 2));
			cardio.delay = 1500 * ((cardio.currentPos + maxLife) / (maxLife * 2));
		}
	
	}
	
	//CONFIG::debug
	//private function handleSpawn(event:Event):void {
	//sendMessage(Message.SPAWN_EMOTION);
	//}
	
	private function handleInitDebugShow(blank:Object):void {
		
		var heroProxy:HeroProxy = proxyMap.getProxy(HeroProxy) as HeroProxy;
		maxLife = heroProxy.getMaxLife();
		
		cardio = new CardioChart(160, 515, maxLife, 0xFFFFFF, 50);
		uiSprite.addChild(cardio);
		cardio.x = 1040;
		cardio.y = 190;
		cardio.start();
	
		//var backBitmap:Bitmap = AssetLibrary.getPICBitmap(AssetIds.BACKGROUND);
		//uiSprite.addChild(backBitmap);
		//if (cardio) {
		//uiSprite.setChildIndex(cardio, 1);
		//}
	
		//CONFIG::debug {
		//
		//var heroConfig:HeroConfigVO = heroProxy.getHeroConfig();
		//
		//var emotionProxy:EmotionProxy = proxyMap.getProxy(EmotionProxy) as EmotionProxy;
		//var emotionConfig:EmotionsConfigVO = emotionProxy.getConfig();
		//
		//var circle:Shape = new Shape();
		//circle.graphics.lineStyle(0.1, 0xFF0000);
		//circle.graphics.drawCircle(0, 0, heroConfig.moveRadius);
		//circle.graphics.endFill();
		//debugSprite.addChild(circle);
		//circle.x = heroConfig.startingXPos;
		//circle.y = heroConfig.startingYPos;
		//
		//circle = new Shape();
		//circle.graphics.lineStyle(0.1, 0x8000FF);
		//circle.graphics.drawCircle(0, 0, emotionConfig.spawnRadius);
		//circle.graphics.endFill();
		//debugSprite.addChild(circle);
		//circle.x = heroConfig.startingXPos;
		//circle.y = heroConfig.startingYPos;
		//}
	
	}
	
	override public function onRemove():void {
	
	}
	
	private function handleShowScreen(screenName:String):void {
		if (currentScreen != screenName) {
			currentScreen = screenName;
			
			if (screen) {
				view.removeChild(screen);
				mediatorMap.unmediate(screen);
				screen = null;
			}
			switch (screenName) {
				case ScreenIds.START: 
					screen = new StartScreenSPR();
					cardio.pause();
					break;
				case ScreenIds.GAME: 
					screen = new GameScreenSPR();
					cardio.start();
					break;
				case ScreenIds.GAMEOVER: 
					screen = new GameOverScreenSPR();
					cardio.pause();
					
					var soundTransform:SoundTransform = new SoundTransform(0.05);
					AssetLibrary.playMP3("heart_death", 0, 0, soundTransform);
					AssetLibrary.playMP3("heart_splash");
					break;
				default: 
					throw Error("TODO")
			}
			if (screen) {
				view.addChild(screen);
				mediatorMap.mediate(screen);
			}
			
			uiSprite.visible = screenName == ScreenIds.GAME;
		}
		//CONFIG::debug {
		//debugSprite.visible = screenName == ScreenIds.GAME;
		//}
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
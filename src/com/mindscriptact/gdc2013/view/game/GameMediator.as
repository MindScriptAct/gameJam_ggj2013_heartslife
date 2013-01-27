package com.mindscriptact.gdc2013.view.game {
import com.mindscriptact.assetLibrary.AssetLibrary;
import com.mindscriptact.assetLibrary.assets.PICAsset;
import com.mindscriptact.gdc2013.constants.AssetIds;
import com.mindscriptact.gdc2013.constants.ProvideId;
import com.mindscriptact.gdc2013.constants.ScreenIds;
import com.mindscriptact.gdc2013.messages.DataMessage;
import com.mindscriptact.gdc2013.messages.KeyMessage;
import com.mindscriptact.gdc2013.messages.Message;
import com.mindscriptact.gdc2013.model.config.data.EmotionsConfigVO;
import com.mindscriptact.gdc2013.model.config.data.EmotionVO;
import com.mindscriptact.gdc2013.model.emotian.EmotionData;
import com.mindscriptact.gdc2013.model.emotian.EmotionProxy;
import com.mindscriptact.gdc2013.model.hero.HeroProxy;
import com.mindscriptact.gdc2013.view.main.elemets.CardioChart;
import flash.display.Bitmap;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import org.mvcexpress.mvc.Mediator;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.textures.Texture;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameMediator extends Mediator {
	private var heroProxy:HeroProxy;
	private var emotionProxy:EmotionProxy;
	private var emotionTextures:Dictionary = new Dictionary();
	private var emotionViews:Vector.<Image> = new Vector.<Image>()
	private var emotionSize:int;
	private var backGroundImage:Image;
	private var elementHolder:Sprite;
	
	private var heroSprite:Sprite;
	private var heroImage:Image;
	private var heroImage_norm:Image;
	private var heroImage_pos:Image;
	private var heroImage_neg:Image;
	
	//private var testImage:Image;
	
	[Inject]
	public var view:Game;
	
	override public function onRegister():void {
		trace("GameMediator.onRegister");
		
		view.touchable = false;
		
		provide(emotionViews, ProvideId.EMOTION_VIEWS);
		
		addHandler(Message.INIT_GAME_ELEMENT, handleInitGameScreen);
		
		addHandler(DataMessage.HERO_POSITON_CHANGED, handleHeroPositionSet);
		
		addHandler(DataMessage.EMOTION_SPOWN, handleEmotionSpawn);
		addHandler(DataMessage.EMOTION_REMOVED, handleEmotionRemove);
		addHandler(DataMessage.All_EMOTIONS_REMOVED, handleAllEmotionRemove);
		
		addHandler(Message.SHOW_SCREEN, handleShowScreen);
		
		addHandler(DataMessage.HERO_HEART_CHANGED, handleHeartChange);
	
		//addHandler(Message.HIDE_LOADER, showCollorTest);
	
		//addHandler(KeyMessage.KEY_DOWN, handleKeyPress);
		//addHandler(KeyMessage.KEY_UP, handleKeyPress);
		//addHandler(KeyMessage.KEY_LEFT, handleKeyPress);
		//addHandler(KeyMessage.KEY_RIGHT, handleKeyPress);
		//addHandler(KeyMessage.KEY_ADD, handleKeyPress);
		//addHandler(KeyMessage.KEY_SUBTRACT, handleKeyPress);		
	}
	
	//todo:hero image
	private function handleHeartChange(heartState:int):void {
		//trace( "GameMediator.handleHeartChange > heartState : " + heartState );
		
		if (heroImage_neg && heroImage_pos) {
			if (heartState < 0) {
				heroImage_pos.visible = true;
				heroImage_pos.alpha = heartState / -20;
			} else {
				heroImage_pos.visible = false;
			}
			if (heartState > 0) {
				heroImage_neg.visible = true;
				heroImage_neg.alpha = heartState / 20;
			} else {
				heroImage_neg.visible = false;
			}
		}
	}
	
	private function handleAllEmotionRemove(blank:Object):void {
		while (emotionViews.length) {
			var emotionSpawn:Image = emotionViews.pop();
			elementHolder.removeChild(emotionSpawn);
		}
	}
	
	private function handleEmotionRemove(nr:int):void {
		var emotionSpawn:Image = emotionViews[nr];
		elementHolder.removeChild(emotionSpawn);
		emotionViews.splice(nr, 1);
	}
	
	private function handleEmotionSpawn(emotionData:EmotionData):void {
		
		var emotionSpawn:Image = new Image(emotionTextures[emotionData.emotionId]);
		elementHolder.addChild(emotionSpawn);
		emotionSpawn.x = emotionData.x;
		emotionSpawn.y = emotionData.y;
		
		emotionSpawn.pivotX = emotionSize >> 1;
		emotionSpawn.pivotY = emotionSize >> 1;
		
		emotionViews.push(emotionSpawn);
	
	}
	
	private function handleShowScreen(screenName:String):void {
		view.visible = (screenName == ScreenIds.GAME)
	
	}
	
	public function handleInitGameScreen(blank:Object):void {
		
		// get proxy
		heroProxy = proxyMap.getProxy(HeroProxy) as HeroProxy;
		emotionProxy = proxyMap.getProxy(EmotionProxy) as EmotionProxy;
		
		var emotionsCanfig:EmotionsConfigVO = emotionProxy.getConfig();
		
		emotionSize = emotionsCanfig.assetSize;
		
		// init textures
		var heroBitma:Bitmap = AssetLibrary.getPICBitmap(AssetIds.HERO_HEART);
		var heroTexture:Texture = Texture.fromBitmap(heroBitma);
		
		var heroBitmaNorm:Bitmap = AssetLibrary.getPICBitmap(AssetIds.HERO_NORMAL);
		var heroTextureNorm:Texture = Texture.fromBitmap(heroBitmaNorm);
		
		var heroBitmaPos:Bitmap = AssetLibrary.getPICBitmap(AssetIds.HERO_POSITIVE);
		var heroTexturePos:Texture = Texture.fromBitmap(heroBitmaPos);
		
		var heroBitmaNeg:Bitmap = AssetLibrary.getPICBitmap(AssetIds.HERO_NEGATIVE);
		var heroTextureNeg:Texture = Texture.fromBitmap(heroBitmaNeg);
		
		var backBitmap:Bitmap = AssetLibrary.getPICBitmap(AssetIds.BACKGROUND);
		var backTexture:Texture = Texture.fromBitmap(backBitmap);
		
		for (var i:int = 0; i < emotionsCanfig.emotions.length; i++) {
			var emotion:EmotionVO = emotionsCanfig.emotions[i];
			
			var emotionBitma:Bitmap = AssetLibrary.getPICBitmap(AssetIds.EMOTION_PREFIX + emotion.id);
			
			emotionTextures[emotion.id] = Texture.fromBitmap(emotionBitma);
		}
		
		var bg:Quad = new Quad(1270, 950, 0x373737, false);
		bg.x = 5;
		bg.y = 5;
		view.addChild(bg)
		
		// add element holder.
		elementHolder = new Sprite();
		view.addChild(elementHolder);
		
		// init background
		backGroundImage = new Image(backTexture);
		view.addChild(backGroundImage);
		
		// init hero.
		
		heroSprite = new Sprite();
		elementHolder.addChild(heroSprite);
		
		var assetSize:int = heroProxy.getAssetSize();
		
		heroImage_norm = new Image(heroTextureNorm);
		heroSprite.addChild(heroImage_norm);
		heroImage_norm.pivotX = assetSize >> 1;
		heroImage_norm.pivotY = assetSize >> 1;
		
		heroImage_pos = new Image(heroTextureNeg);
		heroSprite.addChild(heroImage_pos);
		heroImage_pos.pivotX = assetSize >> 1;
		heroImage_pos.pivotY = assetSize >> 1;
		heroImage_pos.visible = false;
		
		heroImage_neg = new Image(heroTexturePos);
		heroSprite.addChild(heroImage_neg);
		heroImage_neg.pivotX = assetSize >> 1;
		heroImage_neg.pivotY = assetSize >> 1
		heroImage_neg.visible = false;
		
		heroImage = new Image(heroTexture);
		heroSprite.addChild(heroImage);
		//TODO: Refactor!!!!
		heroImage.pivotX = (assetSize >> 1) + heroImage.width*0.08; 
		heroImage.pivotY = (assetSize >> 1) + heroImage.height*0.08;
		heroImage.x += 14;
		heroImage.y += 17;
		
		//TODO: Refactor!!!!
		CardioChart.heroImage = heroImage;
		
		
		handleHeroPositionSet();
		
		provide(heroSprite, ProvideId.HERO);
	}
	
	private function handleHeroPositionSet(blank:Object = null):void {
		if (heroProxy) {
			heroSprite.x = heroProxy.getHeroPosX();
			heroSprite.y = heroProxy.getHeroPosY();
		}
	}
	
	//private function handleKeyPress(keyCode:int):void {
	//trace("GameMediator.handleKe0yPress > keyCode : " + keyCode);
	//switch (keyCode) {
	//case Keyboard.UP: 
	//testImage.y -= 100;
	//break;
	//case Keyboard.DOWN: 
	//testImage.y += 100;
	//break;
	//case Keyboard.LEFT: 
	//testImage.x -= 100;
	//break;
	//case Keyboard.RIGHT: 
	//testImage.x += 100;
	//break;
	//case Keyboard.NUMPAD_ADD: 
	//testImage.scaleX *= 2;
	//testImage.scaleY *= 2;
	//break;
	//case Keyboard.NUMPAD_SUBTRACT: 
	//testImage.scaleX /= 2;
	//testImage.scaleY /= 2;
	//break;
	//default: 
	//}
	//}
	
	//private function showCollorTest(blank:Object):void {
	//AssetLibrary.sendAssetToFunction(AssetIds.COLOR_TEST, handleTestPic);
	//}
	
	//private function handleTestPic(asset:PICAsset):void {
	//var texture:Texture = Texture.fromBitmap(asset.getBitmap());
	//
	//testImage = new Image(texture);
	//view.addChild(testImage);
	//
	//provide(testImage, ProcessId.TEST_IMAGE);
	//}
	
	override public function onRemove():void {
	
	}

}
}
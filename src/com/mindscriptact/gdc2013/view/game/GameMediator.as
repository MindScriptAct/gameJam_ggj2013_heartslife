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
import flash.display.Bitmap;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import org.mvcexpress.mvc.Mediator;
import starling.display.Image;
import starling.textures.Texture;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class GameMediator extends Mediator {
	private var heroImage:Image;
	private var heroProxy:HeroProxy;
	private var emotionProxy:EmotionProxy;
	private var emotionTextures:Dictionary = new Dictionary();
	private var emotionViews:Vector.<Image> = new Vector.<Image>()
	private var emotionSize:int;
	private var backGroundImage:Image;
	;
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
	
		//addHandler(Message.HIDE_LOADER, showCollorTest);
	
		//addHandler(KeyMessage.KEY_DOWN, handleKeyPress);
		//addHandler(KeyMessage.KEY_UP, handleKeyPress);
		//addHandler(KeyMessage.KEY_LEFT, handleKeyPress);
		//addHandler(KeyMessage.KEY_RIGHT, handleKeyPress);
		//addHandler(KeyMessage.KEY_ADD, handleKeyPress);
		//addHandler(KeyMessage.KEY_SUBTRACT, handleKeyPress);
	
	}
	
	private function handleAllEmotionRemove(blank:Object):void {
		while (emotionViews.length) {
			var emotionSpawn:Image = emotionViews.pop();
			view.removeChild(emotionSpawn);
		}
	}
	
	private function handleEmotionRemove(nr:int):void {
		var emotionSpawn:Image = emotionViews[nr];
		view.removeChild(emotionSpawn);
		emotionViews.splice(nr, 1);
	}
	
	private function handleEmotionSpawn(emotionData:EmotionData):void {
		
		var emotionSpawn:Image = new Image(emotionTextures[emotionData.emotionId]);
		view.addChild(emotionSpawn);
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
		var heroBitma:Bitmap = AssetLibrary.getPICBitmap(AssetIds.HERO);
		var heroTexture:Texture = Texture.fromBitmap(heroBitma);
		
		//var backBitmap:Bitmap = AssetLibrary.getPICBitmap(AssetIds.BACKGROUND);
		//var backTexture:Texture = Texture.fromBitmap(backBitmap);
		
		for (var i:int = 0; i < emotionsCanfig.emotions.length; i++) {
			var emotion:EmotionVO = emotionsCanfig.emotions[i];
			
			var emotionBitma:Bitmap = AssetLibrary.getPICBitmap(AssetIds.EMOTION_PREFIX + emotion.id);
			
			emotionTextures[emotion.id] = Texture.fromBitmap(emotionBitma);
		}
		
		// init background
		
		//backGroundImage = new Image(backTexture);
		//view.addChild(backGroundImage);
		
		// init hero.
		heroImage = new Image(heroTexture);
		var assetSize:int = heroProxy.getAssetSize();
		heroImage.pivotX = assetSize >> 1;
		heroImage.pivotY = assetSize >> 1;
		provide(heroImage, ProvideId.HERO);
		view.addChild(heroImage);
		handleHeroPositionSet();
	}
	
	private function handleHeroPositionSet(blank:Object = null):void {
		if (heroProxy) {
			heroImage.x = heroProxy.getHeroPosX();
			heroImage.y = heroProxy.getHeroPosY();
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
package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.hero.HeroData;
import com.mindscriptact.gdc2013.view.game.GameMediator;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import org.mvcexpress.live.Task;
import starling.display.Sprite;

/**
 * TODO:CLASS COMMENT
 * @author Deril
 */
public class MoveHeroTask extends Task {
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_DATA')]
	public var heroData:HeroData;
	
	//[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.KEYBOARD_REGISTRY')]
	//public var keyDictionary:Dictionary;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO')]
	public var heroView:Sprite;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_CONFIG')]
	public var heroConfig:HeroConfigVO;
	
	private var speedEasing:Number = 0.5;
	
	
	public static var directionX:Number = 0;
	public static var directionY:Number = 0;
		
	override public function run():void 
	{
		
		heroData.speedX += (heroConfig.moveSpeed * directionX - heroData.speedX) * speedEasing;
		heroData.speedY += (heroConfig.moveSpeed * directionY - heroData.speedY) * speedEasing;
		
		if (Math.abs(heroData.speedX) <= 0.05)
			heroData.speedX = 0;		
		
		if (Math.abs(heroData.speedY) <= 0.05)
			heroData.speedY = 0;		
		
		var prevX:Number = heroData.x;
		var prevY:Number = heroData.y;
		
		heroData.x += heroData.speedX;
		heroData.y += heroData.speedY;
		
		var distance:int = (heroConfig.moveRadius - heroConfig.size / 2) * (heroConfig.moveRadius - heroConfig.size / 2)
		
		var distX:int = heroConfig.startingXPos - heroData.x;
		var distY:int = heroConfig.startingYPos - heroData.y;
		
		var newDistance:int = distX * distX + distY * distY;
		
		if (newDistance > distance) {
			heroData.x = prevX;
			heroData.y = prevY;
			heroData.speedX = 0;
			heroData.speedY = 0;
		}
		
		//if (GameMediator.heroSprite != null)
		//{
		//	GameMediator.heroSprite.rotation = Math.atan2(heroData.speedX, heroData.speedY);
		//}
		
		heroView.x = heroData.x;
		heroView.y = heroData.y
	
	}

}
}
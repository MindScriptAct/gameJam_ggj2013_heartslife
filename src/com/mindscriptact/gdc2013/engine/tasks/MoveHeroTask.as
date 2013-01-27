package com.mindscriptact.gdc2013.engine.tasks {
import com.mindscriptact.gdc2013.model.config.data.HeroConfigVO;
import com.mindscriptact.gdc2013.model.hero.HeroData;
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
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.KEYBOARD_REGISTRY')]
	public var keyDictionary:Dictionary;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO')]
	public var heroView:Sprite;
	
	[Inject(constName='com.mindscriptact.gdc2013.constants::ProvideId.HERO_CONFIG')]
	public var heroConfig:HeroConfigVO;
	
	private var speedEasing:Number = 0.5;
	
	override public function run():void {
		
		if (keyDictionary[Keyboard.UP] as Boolean) {
			heroData.speedY += (-heroConfig.moveSpeed - heroData.speedY) * speedEasing;
			//heroData.y -= heroConfig.moveSpeed;
		}
		if (keyDictionary[Keyboard.DOWN] as Boolean) {
			heroData.speedY += (heroConfig.moveSpeed - heroData.speedY) * speedEasing;
			//heroData.y += heroConfig.moveSpeed;
		}
		if (!(keyDictionary[Keyboard.UP] as Boolean) && !(keyDictionary[Keyboard.DOWN] as Boolean))
		{
			heroData.speedY *= speedEasing;
			if (Math.abs(heroData.speedY) <= 0.05)
				heroData.speedY = 0;			
		}
		
		if (keyDictionary[Keyboard.LEFT] as Boolean) {
			heroData.speedX += (-heroConfig.moveSpeed - heroData.speedX) * speedEasing;
			//heroData.x -= heroConfig.moveSpeed;
		}
		if (keyDictionary[Keyboard.RIGHT] as Boolean) {
			heroData.speedX += (heroConfig.moveSpeed - heroData.speedX) * speedEasing;
			//heroData.x += heroConfig.moveSpeed;
		}
		if (!(keyDictionary[Keyboard.LEFT] as Boolean) && !(keyDictionary[Keyboard.RIGHT] as Boolean))
		{
			heroData.speedX *= speedEasing;
			if (Math.abs(heroData.speedX) <= 0.05)
				heroData.speedX = 0;
		}		
		
		heroData.x += heroData.speedX;
		heroData.y += heroData.speedY;
		
		var distance:int = (heroConfig.moveRadius - heroConfig.size / 2) * (heroConfig.moveRadius - heroConfig.size / 2)
		
		var distX:int = heroConfig.startingXPos - heroData.x;
		var distY:int = heroConfig.startingYPos - heroData.y;
		
		var newDistance:int = distX * distX + distY * distY;
		
		if (newDistance > distance) {
			if (keyDictionary[Keyboard.UP] as Boolean) {
				heroData.y += heroConfig.moveSpeed;
			}
			if (keyDictionary[Keyboard.DOWN] as Boolean) {
				heroData.y -= heroConfig.moveSpeed;
			}
			if (keyDictionary[Keyboard.LEFT] as Boolean) {
				heroData.x += heroConfig.moveSpeed;
			}
			if (keyDictionary[Keyboard.RIGHT] as Boolean) {
				heroData.x -= heroConfig.moveSpeed;
			}
			
		}
		
		heroView.x = heroData.x;
		heroView.y = heroData.y
	
	}

}
}
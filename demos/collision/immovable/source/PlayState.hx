package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var spriteA:FlxSprite;
	private var boxA:FlxSprite;
	
	private var spriteB:FlxSprite;
	private var boxB:FlxSprite;
	
	override public function create():Void
	{
		bgColor = 0;
		super.create();
		
		boxA = createBox(.25);
		boxB = createBox(.75);
		
		spriteA = createSprite(.25);
		spriteB = createSprite(.75);
		
		boxB.immovable = true;
	}
	
	private function createBox(xFactor:Float):FlxSprite
	{
		var box = new FlxSprite(AssetPaths.bigbox__png);
		box.x = FlxG.width / 2 - box.width / 2;
		box.y = FlxG.height * xFactor - box.height / 2;
		add(box);
		return box;
	}
	
	private function createSprite(xFactor:Float):FlxSprite
	{
		var sprite = new FlxSprite(AssetPaths.sprite__png);
		sprite.x = 16;
		sprite.y = FlxG.height * xFactor - sprite.height / 2;
		sprite.velocity.x = 200;
		add(sprite);
		return sprite;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		updateMovableExample();
		updateImmovableExample();
	}
	
	private function updateMovableExample():Void
	{
		FlxG.collide(spriteA, boxA);
		
		if (spriteA.velocity.x > 0)
		{
			if (spriteA.x >= FlxG.width - spriteA.width)
			{
				spriteA.velocity.x = -200;
				boxA.velocity.x = -150;
			}
			else
			{
				spriteA.velocity.x = 150;
			}
		}
		else if (spriteA.x <= 0)
		{
			spriteA.x = 0;
			spriteA.velocity.x = 150;
		}
		
		if (boxA.velocity.x < 0 && boxA.x <= FlxG.width / 2 - boxA.width / 2)
		{
			boxA.velocity.x = 0;
			boxA.x = FlxG.width / 2 - boxA.width / 2;
		}
	}
	
	private function updateImmovableExample():Void
	{
		FlxG.collide(spriteB, boxB);
		
		if (spriteB.justTouched(FlxObject.ANY))
		{
			spriteB.velocity.x = -100;
		}
		else if (spriteB.velocity.x < 0 && spriteB.x <= 0)
		{
			spriteB.velocity.x = 150;
			spriteB.x = 0;
		}
	}
}

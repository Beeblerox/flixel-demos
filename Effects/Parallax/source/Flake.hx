package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;

class Flake extends FlxSprite
{
	private var _rnd:FlxRandom;
	private var _level:Int = 0;
	private var _initialized:Bool = false;
	
	
	public function new(Level:Int = 0) 
	{
		
		super();
		_level = Level;
		_rnd  = new FlxRandom();
		var size:Int = Std.int(FlxMath.bound(_level / 2, 1, 2));
		makeGraphic(size, size);
		revive();
		_initialized = true;
	}
	
	override public function revive():Void 
	{
		super.revive();
		alpha = 1;
		if (_initialized)
		{
			x = _rnd.int(0, FlxG.width * 4 * _level);
			y = _rnd.int( -5, -10);
		}
		else
		{
			x = _rnd.int(0, FlxG.width * 4 * _level);
			y = _rnd.int( -10, FlxG.height);
		}
		color = FlxColor.WHITE.getDarkened(.5 - (_level * .06));
		scrollFactor.set(.7 + (_level * .08), 0);
		velocity.y = _rnd.int(20, 40) * ((_level+1) * .2);
		velocity.x = _rnd.int( -25, -50) * ((_level+1) * .1);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (x < 0 || y > FlxG.height || alpha <= 0)
		{
			revive();
		}
		else if (y >= FlxG.height - 64 && _level < 5)
		{
			velocity.set();
			y = FlxG.height - 65;
		}
		
		if (velocity.y == 0)
			alpha -= elapsed * .5;
			
		super.update(elapsed);
		
	}
}
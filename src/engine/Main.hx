package engine;
import openfl.display.Sprite;

/**
 * ...
 * @author TBaudon
 */
class Main extends Sprite
{

	public function new() 
	{
		super();
		
		graphics.beginFill(0xff0000);
		graphics.drawRect(0, 0, 20, 20);
		graphics.endFill();
	}
	
}
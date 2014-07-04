package ;
import openfl.display.Sprite;

/**
 * ...
 * @author TBaudon
 */
class Connection extends Sprite
{

	var _input : Sprite;
	var _output : Sprite;
	
	public function new(input : Sprite, output : Sprite) 
	{
		super();
		
		_input = input;
		_output = output;
		
		mouseEnabled = false;
	}
	
	public function draw(destX : Int, destY : Int) {
		graphics.clear();
		
		var startX = _output.x + _output.parent.x;
		var startY = _output.y + _output.parent.y;
		
		var midX = startX + (destX - startX) / 2;
		var midY = startY + (destY - startY) / 2;
		
		graphics.lineStyle(2, 0xffffff);
		graphics.moveTo(startX, startY);
		graphics.curveTo(startX + 20, startY, midX, midY);
		graphics.curveTo(destX - 20, destY, destX, destY);
	}
	
	public function update() {
		draw(cast _input.x + _input.parent.x,cast _input.y + _input.parent.y);
	}
	
	public function grab(mx : Int, my : Int) {
		draw(mx, my);
	}
	
	public function setInput(input : Sprite) {
		_input = input;
	}
}
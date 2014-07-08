package ;
import flash.events.Event;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author TBaudon
 */
class Connection extends Sprite
{

	var _input : Sprite;
	var _output : Sprite;
	
	var _mouseOver : Bool;
	
	public function new(input : Sprite, output : Sprite) 
	{
		super();
		
		_input = input;
		_output = output;
		
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
	}
	
	private function onRightClick(e:Event):Void 
	{
		if (_mouseOver && _input != null)
		{
			if (Type.getClass(_input) == Input)
			{
				var a : Input = cast _input;
				a.disconect();
			}
		}
	}
	
	private function onMouseOut(e:Event):Void 
	{
		_mouseOver = false;
		update();
	}
	
	private function onMouseOver(e:Event):Void 
	{
		_mouseOver = true;
		update();
	}
	
	public function draw(destX : Int, destY : Int) {
		graphics.clear();
		
		var startX = _output.x + _output.parent.x;
		var startY = _output.y + _output.parent.y;
		
		var midX = startX + (destX - startX) / 2;
		var midY = startY + (destY - startY) / 2;
		
		var size : Int = 2;
		if (_mouseOver && _input!= null)
			size = 4;
		
		graphics.lineStyle(size, 0xffffff);
		graphics.moveTo(startX, startY);
		graphics.curveTo(startX + 20, startY, midX, midY);
		graphics.curveTo(destX - 20, destY, destX, destY);
	}
	
	public function update() {
		if (_input != null)
		draw(cast _input.x + _input.parent.x,cast _input.y + _input.parent.y);
	}
	
	public function grab(mx : Int, my : Int) {
		draw(mx, my);
	}
	
	public function setInput(input : Sprite) {
		_input = input;
	}
	
	public function getInput() : Sprite {
		return _input;
	}
}
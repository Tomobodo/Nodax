package ;
import flash.events.Event;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import Type;
/**
 * ...
 * @author Thomas B
 */
class Output extends Sprite
{
	
	public var type : ValueType;
	public var value : Dynamic;
	
	var _line : Sprite;
	var _pressed : Bool;

	public function new(name : String, type : ValueType) 
	{
		super();
		this.name = name;
		this.type = type;
		
		graphics.beginFill(0xffcc33);
		graphics.drawCircle(0, 0, 5);
		graphics.endFill();
		
		buttonMode = true;
		useHandCursor = true;
		
		addEventListener(MouseEvent.MOUSE_DOWN, onPress);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		this.mouseChildren = false;
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		if(_pressed){
			_line.graphics.clear();
			_line.graphics.lineStyle(3, 0xdddddd);
			_line.graphics.lineTo((e.stageX - (parent.x + x))/1.1, (e.stageY - (parent.y + y))/1.1);
		}
	}
	
	private function onRelease(e:MouseEvent):Void 
	{
		if (_pressed) {
			var target : Dynamic = e.target;
			if (Std.is(target, Input)) {
				var input : Input = target;
				if (input.type == type)
					input.setOutput(this);
				else{
					removeChild(_line);
					_line = null;
				}
			}else {
				removeChild(_line);
				_line = null;
			}
		}
		_pressed = false;
	}
	
	private function onPress(e:MouseEvent):Void 
	{
		_line = new Sprite();
		_line.mouseEnabled = false;
		addChild(_line);
		_pressed = true;
	}
	
	public function set(value : Dynamic) {
		this.value = value;
	}
	
}
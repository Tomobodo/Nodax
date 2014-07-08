package ;
import flash.events.Event;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import Type;
/**
 * ...
 * @author Thomas B
 */
class Node extends Sprite
{

	var _inputs : Map<String, Dynamic>;
	var _outputs : Map<String, Dynamic>;
	
	var _nbInput : UInt;
	var _nbOutput : UInt;
	
	public var nextNode : Node;
	public var graph : Graph;
	
	var _pressed : Bool;
	var _mouseOffX : Int;
	var _mouseOffY : Int;
	var _bg : Sprite;
	var _baseClass : String;
	
	public function new() 
	{
		super();
		
		_inputs = new Map<String, Dynamic>();
		_outputs = new Map<String, Dynamic>();
		
		for (field in Type.getInstanceFields(Type.getClass(this)))
		{
			if (field.indexOf('I_') == 0)
			{
				var inputName = field.substr(2, field.length - 1);
				addInput(inputName, Type.typeof(Reflect.field(this, field)));
			}else if (field.indexOf('O_') == 0)
			{
				var outputName = field.substr(2, field.length - 1);
				addOutput(outputName, Type.typeof(Reflect.field(this, field)));
			}
		}
		
		_bg = new Sprite();
		_bg.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);

		draw();
	}
	
	private function onRightClick(e:Event):Void 
	{
		for (input in _inputs)
			input.disconect();
		for (output in _outputs)
			output.disconect();
		graph.removeNode(this);
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		if(_pressed){
			x = e.stageX - _mouseOffX - parent.parent.x;
			y = e.stageY - _mouseOffY - parent.parent.y;
			
			for (output in _outputs) 
				output.updateConnections();
			
			for (input in _inputs) 
				input.updateConnections();
		}
	}
	
	private function onRelease(e:Event):Void 
	{
		_pressed = false;
	}
	
	private function onPress(e:MouseEvent):Void 
	{
		e.stopPropagation();
		_pressed = true;
		
		_mouseOffX = cast e.localX;
		_mouseOffY = cast e.localY;
	}
	
	function draw() {
		
		addChild(_bg);
		
		var maxHeight : Int;
		
		var name : String = Type.getClassName(Type.getClass(this));
		var namePart = name.split('.');
		name = namePart[namePart.length - 1];
		var namePart2 = name.split('_');
		name = namePart2[namePart2.length - 1];
		var txtName = new TextField();
		txtName.defaultTextFormat = new TextFormat("arial", 16, 0xcc9933, true);
		txtName.mouseEnabled = false;
		txtName.selectable = false;
		txtName.autoSize = TextFieldAutoSize.LEFT;
		txtName.text = name;
		
		var i = 0;
		for (input in _inputs) {
			addChild(input);
			input.x = 0;
			input.y = i * 20 + txtName.height + 10;
			++i;
		}
		
		txtName.x += 20;
		
		i = 0;
		
		for (output in _outputs) {
			addChild(output);
			output.x = txtName.x + txtName.width + 20;
			output.y = i * 20 + txtName.height + 10;
			++i;
		}
		
		addChild(txtName);
		
		_bg.graphics.clear();
		_bg.graphics.beginFill(0x333333, 0.5);
		_bg.graphics.lineStyle(4, 0x333333);
		_bg.graphics.drawRoundRect(0, 0, txtName.x + txtName.width + 20, height + 10, 10,10);
	}
	
	public function process() {
		
	}
	
	function getInput(name : String) : Input {
		var input : Input = _inputs[name];
		if (input != null) {
			if (input.output != null)
			{
				var previousNode : Node = input.output.node;
				previousNode.process();
			}
		}
		return input;
	}
	
	public function addInput(name : String, type : ValueType) {
		var input = new Input(name, type);
		input.node = this;
		_inputs[name] = input;
		_nbInput++;
	}
	
	public function addOutput(name : String, type : ValueType) {
		var output = new Output(name, type);
		output.node = this;
		_outputs[name] = output;
		_nbOutput++;
	}
	
}
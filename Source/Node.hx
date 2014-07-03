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
	
	public function new() 
	{
		super();
		
		_inputs = new Map<String, Dynamic>();
		_outputs = new Map<String, Dynamic>();
		
		create();
		
		_bg = new Sprite();
		_bg.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

		draw();
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		if(_pressed){
			x = e.stageX - _mouseOffX;
			y = e.stageY - _mouseOffY;
			
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
		_pressed = true;
		
		_mouseOffX = cast e.localX;
		_mouseOffY = cast e.localY;
	}
	
	function create() {
		
	}
	
	function draw() {
		
		addChild(_bg);
		
		var maxHeight : Int;
		
		var name : String = Type.getClassName(Type.getClass(this)).split('.')[1];
		var txtName = new TextField();
		txtName.mouseEnabled = false;
		txtName.selectable = false;
		txtName.autoSize = TextFieldAutoSize.LEFT;
		txtName.text = name;
		
		var i = 0;
		for (input in _inputs) {
			addChild(input);
			input.x = 0;
			input.y = i * 20 + txtName.height;
			++i;
		}
		
		txtName.x += 20;
		
		i = 0;
		
		for (output in _outputs) {
			addChild(output);
			output.x = txtName.x + txtName.width + 20;
			output.y = i * 20 + txtName.height;
			++i;
		}
		
		addChild(txtName);
		
		_bg.graphics.clear();
		_bg.graphics.beginFill(0x999999, 0.7);
		_bg.graphics.drawRect(0, 0, width-10, height + 10);
	}
	
	public function process() {
		
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
package ;
import flash.events.Event;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import Type;
/**
 * ...
 * @author Thomas B
 */
class Input extends Sprite
{
	
	public var type : ValueType;
	public var output : Output;
	public var node : Node;
	
	var _connection : Connection;
	var _nameTxt:TextField;
	
	var _customValue : Bool;

	public function new(name : String, type : ValueType) 
	{
		super();
		this.name = name;
		this.type = type;
		
		graphics.beginFill(0x6666ff);
		graphics.drawCircle(0, 0, 5);
		graphics.endFill();
		
		buttonMode = true;
		useHandCursor = true;
		
		_nameTxt = new TextField();
		_nameTxt.defaultTextFormat = new TextFormat("arial", 12, 0xffffff);
		_nameTxt.autoSize = TextFieldAutoSize.LEFT;
		_nameTxt.text = name;
		_nameTxt.selectable = false;
		addChild(_nameTxt);
		_nameTxt.x = 5;
		_nameTxt.y = -_nameTxt.height / 2;
		
		_nameTxt.addEventListener(MouseEvent.CLICK, onNameClicked);
	}
	
	private function onNameClicked(e:Event):Void 
	{
		if(output == null){
			_nameTxt.selectable = true;
			_nameTxt.type = TextFieldType.INPUT;
			_customValue = true;
		}
	}
	
	public function connect(output : Output, connection : Connection) : Void {
		if (this.output != null)
			disconect();
		this.output = output;
		_connection = connection;
		
		_nameTxt.selectable = false;
		_nameTxt.type = TextFieldType.DYNAMIC;
		_nameTxt.text = name;
	}
	
	public function disconect() {
		output = null;
		if(_connection != null)
			node.graph.removeConnection(_connection);
		_connection = null;
	}
	
	public function updateConnections() {
		if(_connection != null)
		_connection.update();
	}
	
	public function getValue() : Dynamic {
		if (output != null)
			return output.value;
		else if (_customValue) {
			if(type == TInt)
				return Std.parseInt(_nameTxt.text);
			else if (type == TFloat) 
				return Std.parseFloat(_nameTxt.text);
			else return _nameTxt.text;
		}
		else return null;
	}
}
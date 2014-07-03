package ;
import openfl.display.Sprite;
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
	
	var _connections : Array<Connection>;

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
		
		_connections = new Array<Connection>();
	}
	
	public function connect(output : Output, connection : Connection) : Void {
		this.output = output;
		_connections.push(connection);
	}
	
	public function disconect(connection : Connection) {
		output = null;
		_connections.remove(connection);
	}
	
	public function updateConnections() {
		for (connection in _connections) connection.update();
	}
}
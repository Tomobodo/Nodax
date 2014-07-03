package ;
import flash.events.Event;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.popups.ListPopupContent;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.events.UIEvent;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;

/**
 * ...
 * @author Thomas B
 */
class Graph extends Sprite
{

	var _entryNode : Node;
	var _nodes : Array<Node>;
	var _connections : Array<Connection>;
	
	var _connectionContainer : Sprite;
	var _nodeContainer : Sprite;
	
	var _nodeList : ListView;
	
	public function new() 
	{
		super();
		
		_nodes = new Array<Node>();
		_connections = new Array<Connection>();
		
		_connectionContainer = new Sprite();
		addChild(_connectionContainer);
		
		_nodeContainer = new Sprite();
		addChild(_nodeContainer);
		
		CompileTime.importPackage('nodes');

		_nodeList = new ListView();
		_nodeList.width = 150;
		_nodeList.height = 300;
		for (cls in CompileTime.getAllClasses('nodes')) {
			_nodeList.dataSource.add( { text:cls, data:cls} );
		}
		
		_nodeList.addEventListener(UIEvent.CLICK, onListClicked);
		
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
	}
	
	private function onListClicked(e:UIEvent):Void 
	{
		Main.uiRoot.removeChild(_nodeList, false);
		trace(_nodeList.selectedItems, _nodeList.userData);
	}
	
	private function onRightClick(e:MouseEvent):Void 
	{
		Main.uiRoot.addChild(_nodeList);
		_nodeList.x = e.stageX;
		_nodeList.y = e.stageY;
	}
	
	public function add(node : Node) {
		if (_entryNode == null) _entryNode = node;
		_nodes.push(node);
		node.graph = this;
		_nodeContainer.addChild(node);
	}
	
	public function addConnection(output : Output, input : Input) : Connection{
		var connect = new Connection(input, output);
		_connections.push(connect);
		_connectionContainer.addChild(connect);
		return connect;
	}
	
	public function removeConnection(connection: Connection) {
		_connectionContainer.removeChild(connection);
		_connections.remove(connection);
	}
	
}
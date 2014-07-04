package ;
import flash.display.BitmapData;
import flash.events.Event;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.popups.ListPopupContent;
import haxe.ui.toolkit.controls.selection.ListSelector;
import haxe.ui.toolkit.events.UIEvent;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Matrix;
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
	var _nodeListShown : Bool;
	var _backgroundimage:flash.display.BitmapData;
	var _pressed : Bool;
	var _offY : Int;
	var _offX : Int;
	
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
		
		for (cls in CompileTime.getAllClasses('nodes')) 
			_nodeList.dataSource.add( { text:Type.getClassName(cls).split('.')[1], data:cls} );
		
		_nodeList.addEventListener(UIEvent.CLICK, onListClicked);
		
		addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
		addEventListener(MouseEvent.CLICK, onClick);
		addEventListener(MouseEvent.MOUSE_DOWN, onMousePress);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		Lib.current.stage.addEventListener(Event.RESIZE, onStageResize);
		
		initBg();
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		if (_pressed)
		{
			x = e.stageX + _offX;
			y = e.stageY + _offY;
			initBg();
		}
	}
	
	private function onMouseUp(e:MouseEvent):Void 
	{
		_pressed = false;
	}
	
	private function onMousePress(e:MouseEvent):Void 
	{
		_pressed = true;
		_offX = cast x - e.stageX;
		_offY = cast y - e.stageY;
	}
	
	private function onStageResize(e:Event):Void 
	{
		initBg();
	}
	
	function initBg() 
	{
		if(_backgroundimage == null){
			var bgElem : Shape = new Shape();
			bgElem.graphics.lineStyle(4, 0xFFFFFF, 0.1);
			bgElem.graphics.lineTo(0, 25);
			bgElem.graphics.lineTo(25, 25);
			
			_backgroundimage = new BitmapData(25, 25, false, 0x666666);
			_backgroundimage.draw(bgElem);
		}
		
		graphics.clear();
		graphics.beginBitmapFill(_backgroundimage);
		graphics.drawRect(-x, -y, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		graphics.endFill();
	}
	
	private function onClick(e:Event):Void 
	{
		if (_nodeListShown) {
			Main.uiRoot.removeChild(_nodeList, false);
			_nodeListShown = false;
		}
	}
	
	private function onListClicked(e:UIEvent):Void 
	{
		Main.uiRoot.removeChild(_nodeList, false);
		_nodeListShown = false;
		var nodeClass : Class<Node> = _nodeList.selectedItems[0].data.data;
		var node : Node = Type.createInstance(nodeClass, []);
		add(node);
		node.x = e.stageX - node.width / 2 - x;
		node.y = e.stageY - node.height / 2 - y;
	}
	
	private function onRightClick(e:MouseEvent):Void 
	{
		_nodeListShown = true;
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
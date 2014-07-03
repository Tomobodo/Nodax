package ;
import haxe.macro.Compiler;
import haxe.macro.Context;
import nodes.Add;
import nodes.Substract;
import openfl.display.Sprite;

/**
 * ...
 * @author TBaudon
 */
class NodeList extends Sprite
{
	
	var _nodeType : Array<Class>;

	public function new() 
	{
		super();
		
		_nodeType = new Array<Class>();
		
		_nodeType.push(Add);
		_nodeType.push(Substract);
	}
	
}
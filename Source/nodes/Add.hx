package nodes;

/**
 * ...
 * @author Thomas B
 */
class Add extends Node
{

	public function new() 
	{
		super();
	}
	
	override function create() {
		addInput("a", TFloat);
		addInput("b", TFloat);
		
		addOutput("result", TFloat);
	}
	
	override public function process() {
		var a : Input = _inputs["a"];
		var b : Input = _inputs["b"];
		
		var result : Output = _outputs["result"];
		
		var aVal = a.output.value;
		var bVal = b.output.value;
		
		var resultVal = aVal + bVal;
		result.set(resultVal);
	}
	
}
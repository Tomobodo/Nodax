package nodes;

/**
 * ...
 * @author Thomas B
 */
class Add extends Node
{

	var I_a : Float;
	var I_b : Float;
	
	var O_result : Float;
	
	public function new() 
	{
		super();
	}
	
	override public function process() {
		var a : Input = getInput("a");
		var b : Input = getInput("b");
		
		var result : Output = _outputs["result"];
		
		var aVal = a.getValue();
		var bVal = b.getValue();
		
		var resultVal = aVal + bVal;
		result.set(resultVal);
	}
	
}
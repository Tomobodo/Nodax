package nodes;

/**
 * ...
 * @author Thomas B
 */
class Modulo extends Node
{
	
	var I_a : Int;
	var I_b : Int;
	
	var O_result : Int;
	var O_rest : Int;

	public function new() 
	{
		super();
		
	}
	
	override public function process() {
		var a : Input = getInput("a");
		var b : Input = getInput("b");
		
		var result : Output = _outputs["result"];
		var rest : Output = _outputs['rest'];
		
		var aVal = a.getValue();
		var bVal = b.getValue();
		
		var resultVal = Std.int(aVal / bVal);
		result.set(resultVal);
		
		var restVal = aVal % bVal;
		rest.set(restVal);
	}
	
}
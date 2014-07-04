package nodes;

/**
 * ...
 * @author Thomas B
 */
class Cosinus extends Node
{

	var I_input : Float;
	
	var O_result : Float;
	
	public function new() 
	{
		super();
	}
	
	override public function process() {
		var input : Input = getInput("input");
		
		var result : Output = _outputs["result"];
		
		var inputVal = input.getValue();
		
		var resultVal = Math.cos(inputVal);
		result.set(resultVal);
	}
	
}
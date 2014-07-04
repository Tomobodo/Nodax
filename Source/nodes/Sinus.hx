package nodes;

/**
 * ...
 * @author Thomas B
 */
class Sinus extends Node
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
		
		var resultVal = Math.sin(inputVal);
		result.set(resultVal);
	}
	
}
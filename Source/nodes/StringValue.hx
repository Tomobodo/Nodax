package nodes;

/**
 * ...
 * @author Thomas B
 */
class StringValue extends Node
{
	
	var I_input : String;
	var O_value : String;

	public function new() 
	{
		super();
		
	}
	
	override public function process() {
		var value = _outputs['value'];
		value.set(getInput('input').getValue());
	}
	
}
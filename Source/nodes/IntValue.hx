package nodes;
import openfl.text.TextField;
import openfl.text.TextFieldType;

/**
 * ...
 * @author Thomas B
 */
class IntValue extends Node
{
	
	var O_value : Int;
	
	var I_input : Int;

	public function new() 
	{	
		super();
	}
	
	override public function process() {
		var value = _outputs['value'];
		value.set(getInput('input').getValue());
	}
	
}
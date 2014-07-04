package nodes;

/**
 * ...
 * @author Thomas B
 */
class IntToFloat extends Node
{

	var I_int : Int;
	var O_float : Float;
	
	public function new() 
	{
		super();
	}
	
	override public function process() {
		var int : Input = getInput("int");
		
		var float : Output = _outputs["float"];
		
		var intVal : Int = int.getValue();
		
		var flaottVal : Float = cast intVal;
		float.set(flaottVal);
	}
}
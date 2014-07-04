package nodes;
import openfl.Lib;

/**
 * ...
 * @author Thomas B
 */
class GetTimer extends Node
{
	
	var O_time : Int;

	public function new() 
	{
		super();
		
	}
	
	override public function process() {
		var time : Output = _outputs['time'];
		time.set(Lib.getTimer());
	}
	
}
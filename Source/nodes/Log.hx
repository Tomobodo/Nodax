package nodes;
import flash.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Thomas B
 */
class Log extends Node
{
	
	var I_input : Dynamic;

	public function new() 
	{
		super();
		
		addEventListener(Event.ENTER_FRAME, onClick);
	}
	
	private function onClick(e:Event):Void 
	{
		process();
	}
	
	override public function process() {
		
		var input = getInput('input');
		if(input.output != null)
			trace(input.getValue());
	}
	
}
package nodes;
import openfl.events.Event;

/**
 * ...
 * @author Thomas B
 */
class SetProperty extends Node
{
	
	var I_property : String;
	var I_value : Dynamic;

	public function new() 
	{
		super();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		process();
	}
	
	override public function process() {
		var target : Dynamic = graph.targetObject;
		
		var property : Input = getInput('property');
		var value : Input = getInput('value');
		
		var valA : String = property.getValue();
		var valB : Dynamic = value.getValue();
		
		if (valA != null && valB != null) {
			if(Reflect.hasField(target, property.getValue()))
			Reflect.setProperty(target, property.getValue(), value.getValue());
		}
	}
	
}
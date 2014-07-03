package ;
import openfl.display.Sprite;
import Type;
/**
 * ...
 * @author Thomas B
 */
class Input extends Sprite
{
	
	public var type : ValueType;
	public var output : Output;

	public function new(name : String, type : ValueType) 
	{
		super();
		this.name = name;
		this.type = type;
		
		graphics.beginFill(0x6666ff);
		graphics.drawCircle(0, 0, 5);
		graphics.endFill();
		
		buttonMode = true;
		useHandCursor = true;
	}
	
	public function connect(output : Output) : Void {
		this.output = output;
	}
	
	public function setOutput(output : Output) {
		this.output = output;
		trace("output set, value : " + output.value);
	}
}
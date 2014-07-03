package;


import nodes.Add;
import nodes.Substract;
import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var a = new Add();
		addChild(a);
		
		addChild(new Substract());
	}
	
	
}
package;


import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import nodes.Add;
import nodes.Substract;
import openfl.display.Sprite;


class Main extends Sprite {
	
	public static var uiRoot : Root;
	
	public function new () {
		
		super ();
		
		var graph = new Graph();
		
		
		addChild(graph);
		
		Toolkit.init();
		Toolkit.openFullscreen(onToolkitInited);
	}
	
	function onToolkitInited(root : Root) {
		Main.uiRoot = root;
	}
	
}
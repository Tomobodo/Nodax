package;


import haxe.ui.toolkit.containers.MenuBar;
import haxe.ui.toolkit.controls.Menu;
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
		
		var ball : Sprite = new Sprite();
		ball.graphics.beginFill(0xffff00);
		ball.graphics.drawCircle(0, 0, 25);
		ball.graphics.endFill();
		
		addChild(ball);
		ball.x = 300;
		ball.y = 300;
		
		graph.targetObject = ball;
		
		Toolkit.init();
		Toolkit.openFullscreen(onToolkitInited);
	}
	
	function onToolkitInited(root : Root) {
		Main.uiRoot = root;
		root.addChild(new MenuBar());
	}
	
}
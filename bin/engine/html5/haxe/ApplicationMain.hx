package;


import openfl.Assets;


#if (!macro && !display)


import haxe.io.Path;
import js.html.HtmlElement;
import js.html.Image;
import openfl.display.Loader;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.Lib;


@:access(openfl.Lib) class ApplicationMain {
	
	
	public static var images (default, null) = new Map <String, Image> ();
	public static var urlLoaders = new Map <String, URLLoader> ();
	
	private static var assetsLoaded = 0;
	private static var preloader:NMEPreloader;
	private static var total = 0;
	
	
	@:keep @:expose("openfl.embed")
	public static function embed (elementName:String, width:Null<Int> = null, height:Null<Int> = null, background:String = null) {
		
		var element:HtmlElement = null;
		
		if (elementName != null) {
			
			element = cast js.Browser.document.getElementById (elementName);
			
		}
		
		var color = null;
		
		if (background != null) {
			
			background = StringTools.replace (background, "#", "");
			
			if (background.indexOf ("0x") > -1) {
				
				color = Std.parseInt (background);
				
			} else {
				
				color = Std.parseInt ("0x" + background);
				
			}
			
		}
		
		flash.Lib.create (element, width, height, color);
		
		preloader = new NMEPreloader ();
		Lib.current.addChild (preloader);
		preloader.onInit ();
		
		var sounds = [];
		var id;
		
		
		if (total == 0) {
			
			start ();
			
		} else {
			
			for (path in urlLoaders.keys ()) {
				
				var urlLoader = urlLoaders.get (path);
				urlLoader.addEventListener ("complete", loader_onComplete);
				urlLoader.load (new URLRequest (path));
				
			}
			
			for (soundName in sounds) {
				
				var sound = new Sound ();
				sound.addEventListener (Event.COMPLETE, sound_onComplete);
				sound.addEventListener (IOErrorEvent.IO_ERROR, sound_onIOError);
				sound.load (new URLRequest (soundName + ".ogg"));
				
			}
			
		}
		
	}
	
	
	public static function main () {
		
		#if munit
		embed (null, 0, 0, "FFFFFF");
		#end
		
	}
	
	
	private static function start ():Void {
		
		preloader.addEventListener (Event.COMPLETE, preloader_onComplete);
		preloader.onLoaded ();
		
	}
	
	
	private static function image_onLoad (_):Void {
		
		assetsLoaded++;
		
		preloader.onUpdate (assetsLoaded, total);
		
		if (assetsLoaded == total) {
			
			start ();
			
		}
		
	}
	
	
	private static function loader_onComplete (event:Event):Void {
		
		assetsLoaded++;
		
		preloader.onUpdate (assetsLoaded, total);
		
		if (assetsLoaded == total) {
			
			start ();
			
		}
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		preloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		Lib.current.removeChild (preloader);
		preloader = null;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (engine.Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (engine.Main, Reflect.field (engine.Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance(DocumentClass, []);
			
			if (Std.is (instance, flash.display.DisplayObject)) {
				
				flash.Lib.current.addChild (cast instance);
				
			} else {
				
				trace ("Error: No entry point found");
				trace ("If you are using DCE with a static main, you may need to @:keep the function");
				
			}
			
		}
		
	}
	
	
	private static function sound_onComplete (event:Event):Void {
		
		assetsLoaded++;
		
		preloader.onUpdate (assetsLoaded, total);
		
		if (assetsLoaded == total) {
			
			start ();
			
		}
		
	}
	
	
	private static function sound_onIOError (event:IOErrorEvent):Void {
		
		// if it is actually valid, it will load later when requested
		
		assetsLoaded++;
		
		preloader.onUpdate (assetsLoaded, total);
		
		if (assetsLoaded == total) {
			
			start ();
			
		}
		
	}
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends engine.Main {}


#elseif macro


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new Event (Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#else


import engine.Main;

class ApplicationMain {
	
	
	public static function main () {
		
		
		
	}
	
	
}


#end
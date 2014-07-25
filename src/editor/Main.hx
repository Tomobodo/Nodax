package editor;
import js.Browser;
import nodejs.webkit.Window;

/**
 * ...
 * @author TBaudon
 */
class Main
{
	
	var mWin : Window;
	var mMaximized : Bool;
	
	public static function main() {
		new Main();
	}

	public function new() 
	{
		mWin = Window.get();
		
		Browser.document.getElementById('windowControlMinimize').onclick = minimize;
		Browser.document.getElementById('windowControlMaximize').onclick = maximize;
		Browser.document.getElementById('windowControlClose').onclick = close;
		Browser.document.getElementById('windowControlDebug').onclick = debug;
		
		mWin.on('maximize', function() {
			mMaximized = true;
		});
		
		mWin.on('unmaximize', function() {
			mMaximized = false;
		});
	}
	
	function minimize(Dynamic) {
		mWin.minimize();
	}
	
	function maximize(target : Dynamic) {
		if (mMaximized)
			mWin.unmaximize();
		else 
			mWin.maximize();
	}
	
	function close(Dynamic) {
		mWin.close();
	}
	
	function debug(Dynamic) {
		mWin.showDevTools();
	}
	
}
(function () { "use strict";
var editor = {};
editor.Main = function() {
	var _g = this;
	this.mWin = nodejs.webkit.Window.get();
	window.document.getElementById("windowControlMinimize").onclick = $bind(this,this.minimize);
	window.document.getElementById("windowControlMaximize").onclick = $bind(this,this.maximize);
	window.document.getElementById("windowControlClose").onclick = $bind(this,this.close);
	window.document.getElementById("windowControlDebug").onclick = $bind(this,this.debug);
	this.mWin.on("maximize",function() {
		_g.mMaximized = true;
	});
	this.mWin.on("unmaximize",function() {
		_g.mMaximized = false;
	});
};
editor.Main.main = function() {
	new editor.Main();
};
editor.Main.prototype = {
	minimize: function(Dynamic) {
		this.mWin.minimize();
	}
	,maximize: function(target) {
		if(this.mMaximized) this.mWin.unmaximize(); else this.mWin.maximize();
	}
	,close: function(Dynamic) {
		this.mWin.close();
	}
	,debug: function(Dynamic) {
		this.mWin.showDevTools();
	}
};
var nodejs = {};
nodejs.webkit = {};
nodejs.webkit.$ui = function() { };
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
nodejs.webkit.$ui = require('nw.gui');
nodejs.webkit.Menu = nodejs.webkit.$ui.Menu;
nodejs.webkit.MenuItem = nodejs.webkit.$ui.MenuItem;
nodejs.webkit.Window = nodejs.webkit.$ui.Window;
editor.Main.main();
})();

package api;

/**
 * ...
 * @author Thomas B
 */
class API_Value
{
	
	public static function int(x:Dynamic) : Int {
		if (Type.getClass(x) == String)
			return Std.parseInt(x);
		return Std.int(x);
	}
	
	public static function float(x:Dynamic) : Float {
		if (Type.getClass(x) == String)
			return Std.parseFloat(x);
		return cast x;
	}
	
	public static function string(x:Dynamic) : String {
		return x;
	}
	
}
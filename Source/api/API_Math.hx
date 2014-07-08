package api;

/**
 * ...
 * @author TBaudon
 */
class API_Math
{

	public static function add(a : Float, b : Float) : Float {
		return a + b;
	}
	
	public static function sub(a : Float, b : Float) : Float {
		return a - b;
	}
	
	public static function mult(a : Float, b : Float) : Float {
		return a * b;
	}
	
	public static function div(a : Float, b : Float) : Float {
		return a / b;
	}
	
	public static function modulus(a : Int, b : Int) : { result : Int, rest:Int } {
		return { result:Std.int(a / b), rest:a % b };
	}
	
	public static function sin(x:Float) : Float {
		return Math.sin(x);
	}
	
	public static function cos(x:Float) : Float {
		return Math.cos(x);
	}
	
	public static function tan(x:Float) : Float {
		return Math.tan(x);
	}
}
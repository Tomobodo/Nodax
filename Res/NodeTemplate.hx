package ::node_package::;

/**
 * ...
 * @author Thomas B
 */
class ::nodeName:: extends Node
{

	public function new() 
	{
		super();	
		::foreach inputs::addInput(::__current__::);
		::end::
		::foreach outputs::addOutput(::__current__::);
		::end::
	}
	
}
package ::npackage::;
import api.::api::;
/**
 * ...
 * @author Thomas B
 */
class ::nodeName:: extends Node
{
	
	::foreach inputs::
	var I_::__current__.name:: : ::__current__.type::;
	::end::
	
	::foreach outputs::
	var O_::__current__.name:: : ::__current__.type::;
	::end::

	public function new() 
	{
		super();
	}
	
	override public function process() {
		::foreach inputs::
		var ::__current__.name:: = getInput("::__current__.name::").getValue();
		::end::
		
		::foreach outputs::
		var ::__current__.name:: : Output = _outputs["::__current__.name::"];
		::end::
		
		var temp = ::api::.::func::(::params::);
		
		::if (multiplout)::
		::foreach outputs::
		::__current__.name::.set(temp.::__current__.name::);
		::end::
		::else::
		::foreach outputs::
		::__current__.name::.set(temp);
		::end::
		::end::
	}
	
}
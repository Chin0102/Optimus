package cn.chinuy.optimus.interfaces {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface IWorkflow extends IEventDispatcher {
		
		function get name() : String;
		function get currentProcessor() : IProcessor;
		function init( facade : IFacade ) : void;
		function destroy() : void;
		
		function presetProcessor( processor : IProcessor ) : void;
		function cancelPresetProcessor( name : String ) : void;
		function gotoProcessor( name : String ) : void;
		function setProcessor( processor : IProcessor ) : void;
		function endProcessor() : void;
		
		function registerService( service : IService ) : IService;
		function removeService( serviceName : String ) : IService;
		function hasService( serviceName : String ) : Boolean;
		function service( serviceName : String ) : IService;
	}
}

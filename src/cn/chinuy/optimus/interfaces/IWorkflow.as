package cn.chinuy.optimus.interfaces {
	
	/**
	 * @author chin
	 */
	public interface IWorkflow {
		
		function get name() : String;
		function get currentProcessor() : IProcessor;
		function init( facade : IFacade ) : void;
		function destroy() : void;
		
		function setProcessor( processor : IProcessor ) : void;
		function endProcessor() : void;
		
		function registerService( service : IService ) : void;
		function registerMultitonService( serviceName : String, serviceClass : Class ) : void;
		function removeService( serviceName : String ) : void;
		function hasService( serviceName : String ) : Boolean;
		function service( serviceName : String ) : IService;
	}
}
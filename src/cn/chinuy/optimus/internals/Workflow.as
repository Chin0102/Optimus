package cn.chinuy.optimus.internals {
	import cn.chinuy.optimus.interfaces.IFacade;
	import cn.chinuy.optimus.interfaces.IProcessor;
	import cn.chinuy.optimus.interfaces.IService;
	import cn.chinuy.optimus.interfaces.IWorkflow;
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class Workflow extends EventDispatcher implements IWorkflow {
		
		private var _facade : IFacade;
		private var _name : String;
		private var _processor : IProcessor;
		
		private var processorMap : Object = {};
		private var serviceMap : Object = {};
		
		public function Workflow( name : String ) {
			super();
			_name = name;
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function get currentProcessor() : IProcessor {
			return _processor;
		}
		
		public function init( facade : IFacade ) : void {
			_facade = facade;
		}
		
		public function destroy() : void {
			endProcessor();
			for( var i : String in serviceMap ) {
				removeService( i );
			}
		}
		
		public function registerService( service : IService ) : IService {
			var serviceName : String = service.name;
			removeService( serviceName );
			serviceMap[ serviceName ] = service;
			service.onRegister( _facade, this );
			_facade.dispatchEvent( new ServiceEvent( ServiceEvent.Registered + serviceName, serviceName ));
			return service;
		}
		
		public function removeService( serviceName : String ) : IService {
			var service : IService = service( serviceName );
			if( service ) {
				service.onRemove();
				delete serviceMap[ serviceName ];
				_facade.dispatchEvent( new ServiceEvent( ServiceEvent.Removed + serviceName, serviceName ));
			}
			return service;
		}
		
		public function hasService( serviceName : String ) : Boolean {
			return service( serviceName ) != null;
		}
		
		public function service( serviceName : String ) : IService {
			return serviceMap[ serviceName ];
		}
		
		public function presetProcessor( processor : IProcessor ) : void {
			processorMap[ processor.name ] = processor;
		}
		
		public function cancelPresetProcessor( name : String ) : void {
			delete processorMap[ name ];
		}
		
		public function gotoProcessor( name : String ) : void {
			setProcessor( processorMap[ name ]);
		}
		
		public function setProcessor( processor : IProcessor ) : void {
			endProcessor();
			_processor = processor;
			if( currentProcessor ) {
				currentProcessor.onStart( _facade, this );
			}
		}
		
		public function endProcessor() : void {
			if( currentProcessor ) {
				currentProcessor.onFinish();
			}
		}
	}
}

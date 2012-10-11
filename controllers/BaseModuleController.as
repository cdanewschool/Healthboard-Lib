package controllers
{
	import events.ApplicationDataEvent;
	
	import flash.events.EventDispatcher;
	
	import models.modules.ModuleModel;
	
	import mx.rpc.events.ResultEvent;
	
	[Bindable]
	public class BaseModuleController extends EventDispatcher
	{
		public var model:ModuleModel;
		
		public function BaseModuleController()
		{
			super();
		}
		
		public function dataResultHandler(event:ResultEvent):void 
		{
			model.dataLoaded = true;
			
			var evt:ApplicationDataEvent = new ApplicationDataEvent( ApplicationDataEvent.LOADED, true );
			model.dispatchEvent( evt );
		}
	}
}
package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.events.ApplicationDataEvent;
	
	import flash.events.EventDispatcher;
	
	import edu.newschool.piim.healthboard.model.module.ModuleModel;
	
	import mx.rpc.events.ResultEvent;
	
	[Bindable]
	public class BaseModuleController extends EventDispatcher
	{
		public var model:ModuleModel;
		
		public function BaseModuleController()
		{
			super();
		}
		
		public function init():void{}
		
		public function dataResultHandler(event:ResultEvent):void 
		{
			model.dataLoaded = true;
			
			var evt:ApplicationDataEvent = new ApplicationDataEvent( ApplicationDataEvent.LOADED, true );
			model.dispatchEvent( evt );
		}
	}
}
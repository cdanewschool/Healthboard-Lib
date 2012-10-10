package models.modules
{
	import flash.events.EventDispatcher;
	import mx.rpc.http.mxml.HTTPService;
	
	public class ModuleModel extends EventDispatcher
	{
		public var dataLoaded:Boolean;
		public var dataService:HTTPService;
		public var openTabs:Array = new Array();
		
		public var moduleCreated:Boolean = false
		
		public function ModuleModel()
		{
			dataService = new HTTPService();
		}
	}
}
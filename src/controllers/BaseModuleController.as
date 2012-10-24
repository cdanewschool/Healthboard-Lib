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
		
		public function init():void{}
		
		public function dataResultHandler(event:ResultEvent):void 
		{
			model.dataLoaded = true;
			
			var evt:ApplicationDataEvent = new ApplicationDataEvent( ApplicationDataEvent.LOADED, true );
			model.dispatchEvent( evt );
		}
		
		protected function modernizeDate( value:String ):String
		{
			var today:Date = AppProperties.getInstance().controller.model.today;
			
			var year:int = today.fullYear;
			var month:int = today.month + 1;
			
			value = value.replace( "{{MONTH}}", month );
			
			for(var i:int=1;i<=12;i++)
			{
				month = today.month + 1 - i;
				
				value = value.replace( "{{MONTH-" + i + "}}", month );
			}
			
			value = value.replace( /{{YEAR}}/, year );
			
			return value;
		}
	}
}
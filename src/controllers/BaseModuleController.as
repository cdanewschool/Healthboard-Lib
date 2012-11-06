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
			var date:int = today.date;
			
			value = value.replace( "{{DAY}}", date );
			value = value.replace( "{{MONTH}}", month );
			value = value.replace( /{{YEAR}}/, year );
			
			for(var i:int=0;i<today.date;i++) value = value.replace( "{{DAY-" + i + "}}", today.date - i );
			for(var i:int=today.date;i>0;i--) value = value.replace( "{{DAY+" + i + "}}", today.date + i );
			for(var i:int=1;i<=today.month;i++) value = value.replace( "{{MONTH-" + i + "}}", today.month + 1 - i );
			for(var i:int=0;i<5;i++) value = value.replace( "{{YEAR-" + i + "}}", today.fullYear - i );
			
			return value;
		}
	}
}
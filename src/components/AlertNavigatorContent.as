package components
{
	import spark.components.NavigatorContent;
	
	public class AlertNavigatorContent extends NavigatorContent
	{
		[Bindable] public var showAlert:Boolean = false;
		
		public function AlertNavigatorContent()
		{
			super();
		}
	}
}
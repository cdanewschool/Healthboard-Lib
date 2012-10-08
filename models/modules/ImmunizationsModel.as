package models.modules
{
	import models.modules.ModuleModel;
	import mx.collections.ArrayCollection;
	
	public class ImmunizationsModel extends ModuleModel
	{
		public static const ID:String = "immunizations";
		
		//	data provider for the Plot Chart
		[Bindable] public var immunizationsData:ArrayCollection = new ArrayCollection();
		//	data provider for the Data Grid
		[Bindable] public var immunizationsDataFiltered:ArrayCollection;
		
		[Bindable] public var immunizationsCategories:Array;
		[Bindable] public var immunizationsDueNumber:uint = 0;
		
		[Bindable] public var minDate:Date = new Date( "Dec 14 2011 01:03:54 AM");
		[Bindable] public var maxDate:Date = new Date( "Dec 14 2012 01:03:54 AM");
		
		public function ImmunizationsModel()
		{
			super();
		}
	}
}
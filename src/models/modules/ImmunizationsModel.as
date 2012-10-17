package models.modules
{
	import enum.DateRanges;
	
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class ImmunizationsModel extends ModuleModel
	{
		public static const ID:String = "immunizations";
		
		//	data provider for the Plot Chart
		public var immunizationsData:ArrayCollection = new ArrayCollection();
		//	data provider for the Data Grid
		public var immunizationsDataFiltered:ArrayCollection;
		
		public var immunizationsCategories:Array;
		public var immunizationsDueNumber:uint = 0;
		
		public var minDate:Date = new Date( "Dec 14 2011 01:03:54 AM");
		public var maxDate:Date = new Date( "Dec 14 2012 01:03:54 AM");
		
		public var dateRange:String = DateRanges.YEAR;
		
		public function ImmunizationsModel()
		{
			super();
		}
	}
}
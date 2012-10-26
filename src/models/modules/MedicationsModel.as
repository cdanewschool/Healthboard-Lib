package models.modules
{
	import mx.collections.ArrayCollection;
	
	import enum.DateRanges;
	
	[Bindable] 
	public class MedicationsModel extends ModuleModel
	{
		public static const ID:String = "medications";
		
		public static const TYPE_ALL:String = "All Meds";
		public static const TYPE_ACTIVE:String = "Current Meds";
		public static const TYPE_DISCONTINUED:String = "Discontinued Meds";
		
		public static const TYPES:ArrayCollection = new ArrayCollection( [ TYPE_ALL, TYPE_ACTIVE, TYPE_DISCONTINUED ] );
	
		public var medicationsData:ArrayCollection;
		public var medicationsDataList:ArrayCollection;
		public var medicationsDataWidget:ArrayCollection;
		
		public var medicationsCategories:ArrayCollection;
		public var medicationsCategoriesWidget:Array;
		public var medicationsCategoriesTree:ArrayCollection;
		
		public var openLeaves:Array;
		
		public var type:String = TYPE_ACTIVE;
		
		[Bindable] public var minDate:Date = new Date( "Jun 13 2012 12:00:00 AM");
		[Bindable] public var maxDate:Date = new Date( "Jun 19 2012 12:00:00 PM");
		[Bindable] public var maxDateWidget:Date = new Date( "Jun 19 2012 12:20:00 AM");
		
		public var dateRange:String = DateRanges.WEEK;
		
		public function MedicationsModel()
		{
			super();
		}
	}
}

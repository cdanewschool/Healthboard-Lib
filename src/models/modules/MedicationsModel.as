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
	
		public var medicationNames:Array;
		
		public var medicationsData:ArrayCollection;
		public var medicationsDataList:ArrayCollection;
		public var medicationsDataWidget:ArrayCollection;
		
		public var medicationsCategories:ArrayCollection;
		public var medicationsCategoriesWidget:ArrayCollection;
		public var medicationsCategoriesTree:ArrayCollection;
		
		public var openLeaves:Array;
		
		public var type:String = TYPE_ACTIVE;
		
		[Bindable] public var minDate:Date;
		[Bindable] public var maxDate:Date;
		[Bindable] public var maxDateWidget:Date;
		
		public var dateRange:String = DateRanges.WEEK;
		
		public function MedicationsModel()
		{
			super();
		}
	}
}

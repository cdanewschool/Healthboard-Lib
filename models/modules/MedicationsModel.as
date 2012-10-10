package models.modules
{
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class MedicationsModel extends ModuleModel
	{
		public static const TYPE_ALL:String = "All";
		public static const TYPE_ACTIVE:String = "Active";
		
		public static const TYPES:ArrayCollection = new ArrayCollection( [ TYPE_ALL, TYPE_ACTIVE ] );
	
		public var medicationsData:ArrayCollection;
		public var medicationsDataFiltered:ArrayCollection;
		public var medicationsCategories:Array;
		public var medicationsDataWidget:ArrayCollection;
		public var medicationsCategoriesWidget:Array;
		public var medicationsCategoriesTree:ArrayCollection;
		
		public var myHorizontalAlternateFill:uint = 0x303030;
		public var myHorizontalFill:uint = 0x4A4A49;
		
		public var type:String = TYPE_ALL;
		
		[Bindable] public var minDate:Date = new Date( "Jun 13 2012 12:00:00 AM");
		[Bindable] public var maxDate:Date = new Date( "Jun 19 2012 12:00:00 PM");
		[Bindable] public var maxDateWidget:Date = new Date( "Jun 19 2012 12:20:00 AM");
		
		public function MedicationsModel()
		{
			super();
		}
	}
}
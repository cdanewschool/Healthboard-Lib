package models.modules
{
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class MedicationsModel extends ModuleModel
	{
		public var medicationsData:ArrayCollection;
		public var medicationsDataFiltered:ArrayCollection;
		public var medicationsCategories:Array;
		public var medicationsDataWidget:ArrayCollection;
		public var medicationsCategoriesWidget:Array;
		
		public function MedicationsModel()
		{
			super();
		}
	}
}
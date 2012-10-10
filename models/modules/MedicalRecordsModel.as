package models.modules
{
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class MedicalRecordsModel extends ModuleModel
	{
		public var medicalRecordsData:ArrayCollection = new ArrayCollection();
		public var medicalRecordsDataGrid:ArrayCollection = new ArrayCollection();
		public var medicalRecordsCategories:Array;
		public var medicalRecordsNextSteps:ArrayCollection;
		public var medicalRecordsCategoriesTree:ArrayCollection = new ArrayCollection
			(
				[
					{category: "Visits", children: []},
					{category: "Diagnostic Studies", children: []},
					{category: "Surgeries"},
					{category: "Procedures"}
				]
			);
		
		public var pendingIndex:int = -1;
		
		public function MedicalRecordsModel()
		{
			super();
		}
	}
}
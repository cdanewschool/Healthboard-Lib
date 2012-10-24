package models.modules
{
	import enum.DateRanges;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class MedicalRecordsModel extends ModuleModel
	{
		public static const ID:String = "medicalrecords";
		
		public var medicalRecordsData:ArrayCollection = new ArrayCollection();
		public var medicalRecordsDataGrid:ArrayCollection = new ArrayCollection();
		public var medicalRecordsCategories:ArrayCollection;
		public var medicalRecordsNextSteps:ArrayCollection;
		public var medicalRecordsProblemList:ArrayCollection;
		
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
		
		public var dateRange:String = DateRanges.YEAR;
		
		public function MedicalRecordsModel()
		{
			super();
		}
	}
}
package edu.newschool.piim.healthboard.model.module
{
	import edu.newschool.piim.healthboard.enum.DateRanges;
	
	import edu.newschool.piim.healthboard.model.module.medicalrecords.MedicalRecord;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class MedicalRecordsModel extends ModuleModel
	{
		public static const ID:String = "medicalrecords";
		
		public var medicalRecords:ArrayCollection = new ArrayCollection();
		
		public var problemList:ArrayCollection = new ArrayCollection();
		
		public var categories:ArrayCollection = new ArrayCollection();	//	multi-dimensional
		
		public var pendingRecord:MedicalRecord;
		
		public var dateRange:String = DateRanges.YEAR;
		
		public var nextSteps:ArrayCollection;
		
		public function MedicalRecordsModel()
		{
			super();
		}
	}
}

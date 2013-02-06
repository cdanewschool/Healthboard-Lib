package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.model.NextStep;
	import edu.newschool.piim.healthboard.model.module.MedicalRecordsModel;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;

	public class MedicalRecordsController extends BaseModuleController
	{
		public function MedicalRecordsController()
		{
			super();
			
			model = new MedicalRecordsModel();
		}
		
		override public function init():void
		{
			super.init();
			
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			model.problemList = new ArrayCollection
				(
					[
						{ problem: "The patient is experiencing high levels of stress in the past few months.", dateEntered: new Date( 2011, 2, 11 ), provider: "Dr. Berg" }
					]
				);
		}
		
		public function getMedicalRecordByNextStep( nextStep:NextStep ):Object
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			for each(var medicalRecord:Object in model.medicalRecords)
			{
				if( !medicalRecord.nextSteps ) continue;
				
				if( medicalRecord.nextSteps.getItemIndex( nextStep ) > -1 )
				{
					return medicalRecord;
				}
			}
			
			return null;
		}
	}
}

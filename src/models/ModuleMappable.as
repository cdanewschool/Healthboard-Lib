package models
{
	import ASclasses.Constants;
	
	import models.modules.AppointmentsModel;
	import models.modules.ExerciseModel;
	import models.modules.MedicalRecordsModel;
	import models.modules.MedicationsModel;
	import models.modules.MessagesModel;
	import models.modules.NutritionModel;
	import models.modules.VitalSignsModel;

	public class ModuleMappable
	{
		public var area:String;
		public var type:String;
		
		public function ModuleMappable()
		{
		}
		
		public function get moduleID():String
		{
			if( area == AppointmentsModel.ID )
				return Constants.MODULE_APPOINTMENTS;
			
			else if( area == ExerciseModel.ID )
				return Constants.MODULE_EXERCISE;
			
			else if( area == MedicationsModel.ID )
				return Constants.MODULE_MEDICATIONS;
			
			else if( area == MedicalRecordsModel.ID )
				return Constants.MODULE_MEDICAL_RECORDS;
			
			else if( area == MessagesModel.ID )
				return Constants.MODULE_MESSAGES;
			
			else if( area == NutritionModel.ID )
				return Constants.MODULE_NUTRITION;
			
			else if( area == VitalSignsModel.ID )
				return Constants.MODULE_VITAL_SIGNS;
			
			return null;
		}
	}
}
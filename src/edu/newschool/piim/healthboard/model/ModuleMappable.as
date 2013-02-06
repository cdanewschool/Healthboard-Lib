package edu.newschool.piim.healthboard.model
{
	import edu.newschool.piim.healthboard.Constants;
	
	import edu.newschool.piim.healthboard.model.module.AppointmentsModel;
	import edu.newschool.piim.healthboard.model.module.ExerciseModel;
	import edu.newschool.piim.healthboard.model.module.MedicalRecordsModel;
	import edu.newschool.piim.healthboard.model.module.MedicationsModel;
	import edu.newschool.piim.healthboard.model.module.MessagesModel;
	import edu.newschool.piim.healthboard.model.module.NutritionModel;
	import edu.newschool.piim.healthboard.model.module.VitalSignsModel;

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
package controllers
{
	import models.ApplicationModel;
	
	public class Controller
	{
		[Bindable] public var medicalRecordsController:MedicalRecordsController;
		[Bindable] public var medicationsController:MedicationsController;
		[Bindable] public var model:ApplicationModel;
		
		public function Controller()
		{
			medicalRecordsController = new MedicalRecordsController();
			medicationsController = new MedicationsController();
		}
	}
}
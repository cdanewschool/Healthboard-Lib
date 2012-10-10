package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.VitalSignsModel;
	
	public class VitalSignsController extends BaseModuleController
	{
		public function VitalSignsController()
		{
			super();
			
			model = new VitalSignsModel();
		}
	}
}
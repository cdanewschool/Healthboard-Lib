package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.NutritionModel;
	
	public class NutritionController extends BaseModuleController
	{
		public function NutritionController()
		{
			super();
			
			model = new NutritionModel();
		}
	}
}
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
		
		public function updateVitalIndices():void 
		{
			var model:VitalSignsModel = model as VitalSignsModel;
			
			var vitalIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.vitalSigns.length; i++) 
			{
				vitalIndicesTemp.push( model.vitalSigns.getItemAt(i).vital );
			}
			
			model.vitalIndices = vitalIndicesTemp;
		}
	}
}
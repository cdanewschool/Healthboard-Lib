package controllers
{
	import models.PatientsModel;
	import models.UserModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class PatientsController extends BaseModuleController
	{
		public function PatientsController()
		{
			super();
			
			model = new PatientsModel();
			
			model.dataService.url = "data/patients.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:PatientsModel = model as PatientsModel;
			
			var results:ArrayCollection = event.result.patients.patient is ArrayCollection ? event.result.patients.patient : new ArrayCollection( [event.result.patients.patient] );
			
			var patients:ArrayCollection = new ArrayCollection();
			
			for each(var result:Object in results)
			{
				var patient:UserModel = parsePatient(result);
				patients.addItem( patient );
			}
			
			model.patients = patients;
			
			super.dataResultHandler(event);
		}
		
		protected function parsePatient( data:Object):UserModel
		{
			return UserModel.fromObj(data);
		}
	}
}
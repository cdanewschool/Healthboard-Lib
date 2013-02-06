package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.model.ProviderModel;
	import edu.newschool.piim.healthboard.model.ProvidersModel;
	import edu.newschool.piim.healthboard.model.UserModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class ProvidersController extends BaseModuleController
	{
		public function ProvidersController()
		{
			super();
			
			model = new ProvidersModel();
			
			model.dataService.url = "data/providers.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:ProvidersModel = model as ProvidersModel;
			
			var results:ArrayCollection = event.result.providers.provider is ArrayCollection ? event.result.providers.provider : new ArrayCollection( [event.result.providers.provider] );
			
			var providers:ArrayCollection = new ArrayCollection();
			
			var teams:Array = [ {label:"All",value:-1} ];
			
			for each(var result:Object in results)
			{
				var provider:ProviderModel = ProviderModel.fromObj(result);
				providers.addItem( provider );
				
				var team:Object = {label:"Team " + provider.team, value: provider.team};
				if( teams[provider.team] == null ) teams[provider.team] = team;
			}
			
			model.providers = providers;
			model.providerTeams = new ArrayCollection( teams );
			
			super.dataResultHandler(event);
		}
		
		protected function parsePatient( data:Object):UserModel
		{
			return UserModel.fromObj(data);
		}
	}
}
package edu.newschool.piim.healthboard.model
{
	import flash.utils.Dictionary;
	
	import edu.newschool.piim.healthboard.model.module.ModuleModel;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import spark.collections.SortField;
	import spark.events.IndexChangeEvent;

	[Bindable] 
	public class ProvidersModel extends ModuleModel
	{
		private var _providers:ArrayCollection = new ArrayCollection();
		public var providerTeams:ArrayCollection = new ArrayCollection();
		public var providerGroups:Dictionary = new Dictionary();
		
		private var _selectedProviderTeam:int;
		private var _searchText:String;
		private var _sortField:String;
		
		public function ProvidersModel()
		{
			super();
			
			reset();
		}
		
		public function reset():void
		{
			selectedProviderTeam = -1;
			
			searchText = "";
			sortField = null;
		}
		
		private function filter():void 
		{
			providers.filterFunction = filterTeamMembersSearch;
			providers.refresh();
			
			//	rebuild array of groups in team
			providerGroups = new Dictionary();
			for(var i:int=0;i<providers.length;i++)
			{
				if( !providerGroups[providers[i].role] ) providerGroups[providers[i].role] = {group:providers[i].role,members:new Array()};
				providerGroups[providers[i].role].members.push( providers[i] );
			}
		}
		
		private function filterTeamMembersSearch(item:Object):Boolean 
		{
			var valid:Boolean = true;
			
			var search:String = searchText ? searchText.toLowerCase() : "";
			if( valid && search != "" && search != "search" ) valid = item.firstName.toLowerCase().indexOf( search ) > -1 || item.lastName.toLowerCase().indexOf( search ) > -1;
			
			if( valid && selectedProviderTeam > 0 ) valid = valid && item.team == selectedProviderTeam;
			
			return valid;
		}
		
		private function sort():void
		{
			var sort:Sort = new Sort();
			
			if( sortField )
			{
				sort.fields = [ new SortField(sortField, false) ];
			}
			
			providers.sort = sort;
			providers.refresh();
		}
		
		public function get sortField():String
		{
			return _sortField;
		}
		
		public function set sortField(value:String):void
		{
			_sortField = value;
			sort();
		}

		public function get selectedProviderTeam():int
		{
			return _selectedProviderTeam;
		}

		public function set selectedProviderTeam(value:int):void
		{
			_selectedProviderTeam = value;
			filter();
		}

		public function get searchText():String
		{
			return _searchText;
		}

		public function set searchText(value:String):void
		{
			_searchText = value;
			filter();
		}

		public function get providers():ArrayCollection
		{
			return _providers;
		}

		public function set providers(value:ArrayCollection):void
		{
			_providers = value;
			
			filter();
		}


	}
}
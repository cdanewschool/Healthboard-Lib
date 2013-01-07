package models
{
	import enum.UrgencyType;
	
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class PatientsModel extends ModuleModel
	{
		public var patients:ArrayCollection;
		
		public var urgentPatientCount:int;
		public var searchParameters:ArrayCollection;
		
		public var optionsBloodType:ArrayCollection;
		public var optionsMaritalStatus:ArrayCollection;
		public var optionsModules:ArrayCollection;
		public var optionsRace:ArrayCollection;
		public var optionsServiceBranch:ArrayCollection;
		public var optionsServiceStatus:ArrayCollection;
		public var optionsSex:ArrayCollection;
		public var optionsTeams:ArrayCollection;
		public var optionsUrgencies:ArrayCollection;
		public var optionsFamilyPrefixes:ArrayCollection;
		
		public var displayedFields:ArrayCollection;
		
		public var showAdvancedSearch:Boolean = false;
		
		public function PatientsModel()
		{
			super();
		}
	}
}
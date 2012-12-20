package models.modules.exercise
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ExerciseActivityGroup
	{
		public var activities:ArrayCollection;
		public var name:String;
		public var purpose:String;
		
		public var dirty:Boolean;
		
		public function ExerciseActivityGroup( name:String, purpose:String = null, activities:ArrayCollection = null )
		{
			this.name = name;
			this.purpose = purpose;
			this.activities = activities;
		}
	}
}
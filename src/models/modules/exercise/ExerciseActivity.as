package models.modules.exercise
{
	[Bindable]
	public class ExerciseActivity
	{
		public var acheiveByDate:Date;
		public var directions:String;
		public var distance:int;
		public var distanceUnit:String;
		public var duration:int;
		public var durationUnit:String;
		public var icon:*;
		public var intensity:String;
		public var frequency:int;
		public var frequencyUnit:String;
		public var name:String;
		public var startDate:Date;
		public var urgency:int;
		
		public function ExerciseActivity(	name:String, icon:* = null, 
										 	startDate:Date = null, acheiveByDate:Date = null, 
										  	frequency:int = 0, frequencyUnit:String = null, 
										  	duration:int = 0, durationUnit:String = null,
											distance:int = 0, distanceUnit:String = null, 
											intensity:String = null, directions:String = null, urgency:int = 0 )
		{
			this.name = name;
			this.icon = icon;
			
			this.startDate = startDate ? startDate : new Date();
			this.acheiveByDate = acheiveByDate;
			this.frequency = frequency;
			this.frequencyUnit = frequencyUnit;
			this.duration = duration;
			this.durationUnit = durationUnit;
			this.distance = distance;
			this.distanceUnit = distanceUnit;
			this.intensity = intensity;
			this.directions = directions;
			this.urgency = urgency;
		}
	}
}
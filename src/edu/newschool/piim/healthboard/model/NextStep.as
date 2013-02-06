package edu.newschool.piim.healthboard.model
{
	[Bindable]
	public class NextStep extends ModuleMappable
	{
		public var actionId:String;
		public var assignee:String;
		public var completed:Boolean;
		public var dateAssigned:Date;
		public var recommendation:String;
		public var removed:Boolean;
		public var status:String;
		public var task:String;
		public var urgency:int;
		
		public function NextStep()
		{
			urgency = 0;
			dateAssigned = new Date();
		}
		
		public static function fromObj( data:Object ):NextStep
		{
			var val:NextStep = new NextStep();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					val[prop] = data[prop];
				}
			}
			
			val.status = val.completed ? "inactive" : "active";
			
			return val;
		}
	}
}
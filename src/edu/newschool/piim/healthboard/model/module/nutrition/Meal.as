package edu.newschool.piim.healthboard.model.module.nutrition
{
	[Bindable]
	public class Meal
	{
		public var description:String;
		public var link:String;
		
		public function Meal( description:String = null, link:String = null )
		{
			this.description = description;
			this.link = link;
		}
		
		public function clone():Meal
		{
			var meal:Meal = new Meal;
			meal.description = description;
			meal.link = link;
			return meal;
		}
	}
}
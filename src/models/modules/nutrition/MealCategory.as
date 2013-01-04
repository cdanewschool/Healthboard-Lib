package models.modules.nutrition
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MealCategory
	{
		public static const BREAKFAST:MealCategory = new MealCategory( 'Breakfast' );
		public static const LUNCH:MealCategory = new MealCategory( 'Lunch' );
		public static const DINNER:MealCategory = new MealCategory( 'Dinner' );
		
		public var name:String;
		public var meals:ArrayCollection;
		
		public function MealCategory( name:String, meals:ArrayCollection = null )
		{
			this.name = name;
			this.meals = meals ? meals : new ArrayCollection();
		}
	}
}
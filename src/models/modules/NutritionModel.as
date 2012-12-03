package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class NutritionModel extends ModuleModel
	{
		public static const ID:String = "nutrition";
		
		//	images shared by module and widget
		[Embed("/images/nutritionAlcoholEmpty.png")] public var alcoholEmpty:Class;
		[Embed("/images/nutritionAlcoholFull.png")] public var alcoholFull:Class;
		[Embed("/images/nutritionFatsOilsEmpty.png")] public var fatsOilsEmpty:Class;
		[Embed("/images/nutritionFatsOilsPartial.png")] public var fatsOilsPartial:Class;
		[Embed("/images/nutritionSodiumFull.png")] public var sodiumFull:Class;
		[Embed("/images/nutritionSodiumEmpty.png")] public var sodiumEmpty:Class;
		[Embed("/images/nutritionSodiumPartial.png")] public var sodiumPartial:Class;
		[Embed("/images/nutritionSugarsEmpty.png")] public var sugarsEmpty:Class;
		[Embed("/images/nutritionSugarsFull.png")] public var sugarsFull:Class;
		[Embed("/images/nutritionSugarsPartial.png")] public var sugarsPartial:Class;
		
		public var mealType:String;
		
		public var meals:ArrayCollection;
		
		public var savedMeals:ArrayCollection;
		
		public var summaryCalories:ArrayCollection;
		
		public var dailyCaloriesAlt1:ArrayCollection;
		
		public var dailyCaloriesAlt2:ArrayCollection;
		
		public var weeklyCalories:ArrayCollection;
		
		public var weeklyCaloriesAlt1:ArrayCollection
		
		public var weeklyCaloriesAlt2:ArrayCollection;
		
		public var dailyCaloriesCurrent:ArrayCollection;
		
		public var weeklyCaloriesCurrent:ArrayCollection;
		
		public var monthlyCalories:ArrayCollection;
		
		public var foodJournal:ArrayCollection;
		
		public var notes:ArrayCollection;
		
		public var dateRange:String;
		
		public var hasMealBeenSubmitted:Boolean = false;
		
		public var foodJournalAlt1:ArrayCollection
		public var foodJournalAlt2:ArrayCollection;
		
		public function NutritionModel()
		{
			super();
		}
	}
}
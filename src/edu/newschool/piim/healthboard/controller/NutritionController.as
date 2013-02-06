package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.controller.BaseModuleController;
	
	import edu.newschool.piim.healthboard.enum.DateRanges;
	
	import edu.newschool.piim.healthboard.model.module.NutritionModel;
	
	import mx.collections.ArrayCollection;
	
	import edu.newschool.piim.healthboard.util.DateUtil;
	
	public class NutritionController extends BaseModuleController
	{
		public function NutritionController()
		{
			super();
			
			model = new NutritionModel();
		}
		
		override public function init():void
		{
			super.init();
			
			var today:Date = AppProperties.getInstance().controller.model.today;
			
			var model:NutritionModel = model as NutritionModel;
			
			model.dateRange = DateRanges.DAY;
			
			model.meals = new ArrayCollection
				(
					[
						{meal: "1) 3/4 cub bran flakes cereal:\n     1 medium banana; and\n     1 cup low-fat milk."},
						{meal: "2) 1 slice whole wheat bread;\n     1tsp soft (tub) margarine; and\n     1 cup orange juice"},
						{meal: "3) 1 slice French toast; whole grain:\n     1 medium egg (for French toast);\n     1 teaspoon oil."}
					]
				);
			
			model.savedMeals = new ArrayCollection
				(
					[
						new ArrayCollection(['Cereal','Yogurt with cereal bar','Orange juice']),
						new ArrayCollection(['Gnocchi with sausage','Tuna Salad','Turkey Sandwich']),
						new ArrayCollection(['Cereal Bar','Ham and cheese sandwich','Nuts','Peanut butter and jelly']),
						new ArrayCollection(['Spinach Lasagna','Fajitas (Chicken with Onions, Green Pepper)','Chipotle Veggie Burrito','Tuna Noodle Casserole'])
					]
				);
			
			model.summaryCalories = new ArrayCollection
				(
					[
						{type: "calories", calories: 0, goal: 1600, caloriesFromExtras: 0, extrasFats: 0, extrasSugar: 0, extrasAlcohol: 0}
					]
				);
			
			model.dailyCaloriesAlt1 = new ArrayCollection
				(
					[
						{type: "calories", calories: 1550, goal: 1600, caloriesFromExtras: 450, extrasFats: 160, extrasSugar: 150, extrasAlcohol: 140}
					]
				);
			
			model.dailyCaloriesAlt2 = new ArrayCollection
				(
					[
						{type: "calories", calories: 1700, goal: 1600, caloriesFromExtras: 515, extrasFats: 165, extrasSugar: 150, extrasAlcohol: 200}
					]
				);
			
			model.weeklyCalories = new ArrayCollection
				(
					[
						{day: 'Sat', calories: 0, limit: 2000},
						{day: 'Fri', calories: 490, limit: 2000},
						{day: 'Thu', calories: 1970, limit: 2000},
						{day: 'Wed', calories: 1900, limit: 2000},
						{day: 'Tue', calories: 2150, limit: 2000},
						{day: 'Mon', calories: 1900, limit: 2000},
						{day: 'Sun', calories: 2000, limit: 2000}
					]
				);
			
			model.weeklyCaloriesAlt1 = new ArrayCollection
				(
					[
						{day: 'Sat', calories: 1900, limit: 2000},
						{day: 'Fri', calories: 1600, limit: 2000},
						{day: 'Thu', calories: 2150, limit: 2000},
						{day: 'Wed', calories: 1900, limit: 2000},
						{day: 'Tue', calories: 1800, limit: 2000},
						{day: 'Mon', calories: 1800, limit: 2000},
						{day: 'Sun', calories: 1900, limit: 2000}
					]
				);
			
			model.weeklyCaloriesAlt2 = new ArrayCollection
				(
					[
						{day: 'Sat', calories: 1700, limit: 2000},
						{day: 'Fri', calories: 2000, limit: 2000},
						{day: 'Thu', calories: 2100, limit: 2000},
						{day: 'Wed', calories: 1800, limit: 2000},
						{day: 'Tue', calories: 1750, limit: 2000},
						{day: 'Mon', calories: 1900, limit: 2000},
						{day: 'Sun', calories: 2200, limit: 2000}
					]
				);
			
			model.dailyCaloriesCurrent = NutritionModel(model).summaryCalories;
			
			model.weeklyCaloriesCurrent = NutritionModel(model).weeklyCalories;
			
			model.monthlyCalories = new ArrayCollection();
			
			model.foodJournal = new ArrayCollection
				(
					[
						{meal:'Breakfast', portion:'1 piece', ingredients:'Spinach quiche', calories:342, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:''},
						{meal:'Dinner', portion:'1 plate', ingredients:'Spaghetti and meatballs', calories:450, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:'I ate too much. Felt like I was having a heart attack!'}
					]
				);
			
			model.foodJournalAlt1 = new ArrayCollection
				(
					[
						{meal:'Breakfast', portion:'1 plate', ingredients:'Eggs and bacon', calories:380, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:''},
						{meal:'Dinner', portion:'1 bowl', ingredients:'Mac and cheese', calories:600, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:''}
					]
				);
			
			model.foodJournalAlt2 = new ArrayCollection
				(
					[
						{meal:'Lunch', portion:'1 plate', ingredients:'Caesar Salad', calories:150, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:''},
						{meal:'Dinner', portion:'1 plate', ingredients:'Fish with mashed potatoes', calories:500, date: DateUtil.get10DigitDate((today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()), comments:'Delicious!'}
					]
				);
		}
	}
}
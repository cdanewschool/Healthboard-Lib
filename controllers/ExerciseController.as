package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.ExerciseModel;
	
	public class ExerciseController extends BaseModuleController
	{
		public function ExerciseController()
		{
			super();
			
			model = new ExerciseModel();
			
			updateExercisePAIndices();
			filterProvidersForWidget();
		}
		
		//	this function removes "Comments" and "Hiking" (untrackable exercise) for the WIDGET
		public function filterProvidersForWidget():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			model.PAproviderCopy.source.splice(-1);
			model.PERproviderCopy.source.splice(-2);
		}
		
		public function updateExercisePAIndices():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePAIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePhysicianAssigned.length; i++) 
			{
				exercisePAIndicesTemp.push( model.exerciseDataByMeasurePhysicianAssigned.getItemAt(i).measure );
			}
			
			model.exercisePAIndices = exercisePAIndicesTemp;
		}
	}
}
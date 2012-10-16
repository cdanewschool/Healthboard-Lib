package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.ExerciseModel;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.LineSeriesItem;
	import mx.graphics.IFill;
	
	import styles.ChartStyles;
	
	public class ExerciseController extends BaseModuleController
	{
		public function ExerciseController()
		{
			super();
			
			model = new ExerciseModel();
			
			updatePAIndices();
			filterProvidersForWidget();
		}
		
		//	this function removes "Comments" and "Hiking" (untrackable exercise) for the WIDGET
		public function filterProvidersForWidget():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			model.PAproviderCopy.source.splice(-1);
			model.PERproviderCopy.source.splice(-2);
		}
		
		public function updateExerciseIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exerciseIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasure.length; i++) {
				exerciseIndicesTemp.push( model.exerciseDataByMeasure.getItemAt(i).measure );
			}
			
			model.exerciseIndices = exerciseIndicesTemp;
		}
		
		public function updatePAIndices():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePAIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePhysicianAssigned.length; i++) 
			{
				exercisePAIndicesTemp.push( model.exerciseDataByMeasurePhysicianAssigned.getItemAt(i).measure );
			}
			
			model.exercisePAIndices = exercisePAIndicesTemp;
		}
		
		public function updateExercisePERIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePERIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePersonal.length; i++) 
			{
				exercisePERIndicesTemp.push( model.exerciseDataByMeasurePersonal.getItemAt(i).measure );
			}
			
			model.exercisePERIndices = exercisePERIndicesTemp;
		}
		
		public function fillFunction(element:ChartItem, index:Number):IFill 
		{
			var item:LineSeriesItem = LineSeriesItem(element);
			var chartStyles:ChartStyles = AppProperties.getInstance().controller.model.chartStyles;
			
			return (item.item.type == 'provider') ? chartStyles.colorVitalSignsProvider : chartStyles.colorVitalSignsPatient;
		}
	}
}
package components.chart
{
	import mx.charts.series.PlotSeries;

	/**
	 * Fixes the bug outlined here:
	 * http://bugs.adobe.com/jira/browse/FLEXDMV-1586
	*/
	public class CustomPlotSeries extends PlotSeries
	{
		override public function findDataPoints(x:Number, y:Number,
												sensitivity:Number):Array /* of HitData */
		{
			var renderData:Object = super.renderData;
			
			if( !renderData || !renderData.filteredCache || !renderData.filteredCache.length ) return [];
			
			return super.findDataPoints(x,y,sensitivity);
		}
	}
}
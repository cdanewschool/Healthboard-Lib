package edu.newschool.piim.healthboard.view.components.itemrenderers.chart
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.charts.renderers.BoxItemRenderer;
	import mx.charts.series.LineSeries;
	import mx.charts.series.items.LineSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.utils.ColorUtil;
	
	public class MyBoxItemRenderer extends BoxItemRenderer
	{
		private var _data:Object;
		
		public function MyBoxItemRenderer()
		{
			super();
		}
		
		override public function get data():Object
		{
			return _data;
		}
		
		/**
		 *  @private
		 */
		override public function set data(value:Object):void
		{
			if (_data == value)
				return;
			_data = value;
		}
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var fill:IFill;
			var state:String = "";
			
			if (_data is ChartItem && _data.hasOwnProperty('fill'))
			{
				state = _data.currentState;
				fill = _data.fill;
			}	 	
			else
				fill = GraphicsUtilities.fillFromStyle(getStyle('fill'));
			
			var color:uint;
			var adjustedRadius:Number = 0;
			
			switch (state)
			{
				case ChartItem.FOCUSED:
				case ChartItem.ROLLOVER:
					if (styleManager.isValidStyleValue(getStyle('itemRollOverColor')))
						color = getStyle('itemRollOverColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-20);
					fill = new SolidColor(color);		
					adjustedRadius = getStyle('adjustedRadius');
					if (!adjustedRadius)
						adjustedRadius = 0;
					break;
				case ChartItem.DISABLED:
					if (styleManager.isValidStyleValue(getStyle('itemDisabledColor')))
						color = getStyle('itemDisabledColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),20);
					fill = new SolidColor(GraphicsUtilities.colorFromFill(color));
					break;
				case ChartItem.FOCUSEDSELECTED:
				case ChartItem.SELECTED:
					if (styleManager.isValidStyleValue(getStyle('itemSelectionColor')))
						color = getStyle('itemSelectionColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-30);
					fill = new SolidColor(color);				
					adjustedRadius = getStyle('adjustedRadius');
					if (!adjustedRadius)
						adjustedRadius = 0;
					break;
			}
			
			var stroke:IStroke = getStyle("stroke");
			
			var w:Number = stroke ? stroke.weight / 2 : 0;
			
			var rc:Rectangle;
			
			if( data is LineSeriesItem && LineSeriesItem(data).element is LineSeries 
				&& LineSeries(LineSeriesItem(data).element).dataProvider is ArrayCollection 
				&& (LineSeries(LineSeriesItem(data).element).items[ LineSeries(LineSeriesItem(data).element).items.length - 1 ] as LineSeriesItem).item == LineSeriesItem(data).item ) 
			{
				rc = new Rectangle(w - adjustedRadius, w - adjustedRadius, width - 2 * w + adjustedRadius * 2, height - 2 * w + adjustedRadius * 2);
			}
			else 
			{
				rc = new Rectangle(w - adjustedRadius + 8, w - adjustedRadius + 8, 0, 0);
			}
			
			var g:Graphics = graphics;
			g.clear();		
			g.moveTo(rc.left,rc.top);
			if (stroke)
				stroke.apply(g,null,null);
			if (fill)
				fill.begin(g,rc,null);
			g.lineTo(rc.right,rc.top);
			g.lineTo(rc.right,rc.bottom);
			g.lineTo(rc.left,rc.bottom);
			g.lineTo(rc.left,rc.top);
			if (fill)
				fill.end(g);
		}
	}
}
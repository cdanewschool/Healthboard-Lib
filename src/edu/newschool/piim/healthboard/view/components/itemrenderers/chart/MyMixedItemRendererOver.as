package edu.newschool.piim.healthboard.view.components.itemrenderers.chart
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.charts.renderers.CircleItemRenderer;
	import mx.charts.series.LineSeries;
	import mx.charts.series.items.LineSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.utils.ColorUtil;
	
	public class MyMixedItemRendererOver extends CircleItemRenderer
	{
		private static var rcFill:Rectangle = new Rectangle();
		
		private var _data:Object;

		public function MyMixedItemRendererOver()
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
				fill = _data.fill;
				state = _data.currentState;
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
					//adjustedRadius = 8;	//if(_data.item.date != "02/14/2012") adjustedRadius = 8;		//DB
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
			
			var g:Graphics = graphics;
			g.clear();		
			
			if (stroke)	stroke.apply(g,null,null);
			if (fill) fill.begin(g, rcFill, null);
			
			if( data.item.type == 'provider' )
			{
				var rc:Rectangle = new Rectangle(w - adjustedRadius + 8, w - adjustedRadius + 8, 0 - 2 * w + adjustedRadius * 2, 0 - 2 * w + adjustedRadius * 2);
				
				g.moveTo(rc.left,rc.top);
				g.lineTo(rc.right,rc.top);
				g.lineTo(rc.right,rc.bottom);
				g.lineTo(rc.left,rc.bottom);
				g.lineTo(rc.left,rc.top);
			}
			else
			{
				rcFill.right = unscaledWidth;
				rcFill.bottom = unscaledHeight;
				
				adjustedRadius += radiusOffset;
				
				g.drawEllipse(w - adjustedRadius + 8,w - adjustedRadius + 8, 0 - 2 * w + adjustedRadius * 2, 0 - 2 * w + adjustedRadius * 2);
			}
			
			if (fill)
				fill.end(g);
		}
		
		protected function get radiusOffset():int
		{
			return 0;
		}
	}
}
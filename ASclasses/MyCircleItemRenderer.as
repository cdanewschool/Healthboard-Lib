package ASclasses
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import models.modules.VitalSignsModel;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.charts.renderers.CircleItemRenderer;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IDataRenderer;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.skins.ProgrammaticSkin;
	import mx.utils.ColorUtil;
	
	public class MyCircleItemRenderer extends CircleItemRenderer
	{
		private static var rcFill:Rectangle = new Rectangle();
		private var _data:Object;

		public function MyCircleItemRenderer()
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
			
			rcFill.right = unscaledWidth;
			rcFill.bottom = unscaledHeight;
			
			var g:Graphics = graphics;
			g.clear();		
			
			if (stroke)	stroke.apply(g,null,null);
			if (fill) fill.begin(g, rcFill, null);
			
			var maxDate:String;
			var model:VitalSignsModel = VitalSignsModel(AppProperties.getInstance().controller.vitalSignsController.model);
			
			if(_data.item.vital == 'weight') maxDate = model.weightMax;
			else if(_data.item.vital == 'bloodPressure') maxDate = model.bloodPressureMax;
			else if(_data.item.vital == 'heartRate') maxDate = model.heartRateMax;
			else if(_data.item.vital == 'respiratory') maxDate = model.respiratoryMax;
			else if(_data.item.vital == 'temperature') maxDate = model.temperatureMax;
			else if(_data.item.vital == 'height') maxDate = model.heightMax;
			else if(_data.item.vital == 'comments') maxDate = model.commentsMax;
			
			if(_data.item.date != maxDate) {
				g.drawEllipse(w - adjustedRadius + 8,w - adjustedRadius + 8,0,0);
			}
			else {
				g.drawEllipse(w - adjustedRadius,w - adjustedRadius,unscaledWidth - 2 * w + adjustedRadius * 2, unscaledHeight - 2 * w + adjustedRadius * 2);
			}
			
			if (fill)
				fill.end(g);
		}
	}
}
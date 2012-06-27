package net.tw.web.weatherBug.loaders {
	import flash.events.Event;
	
	import net.tw.web.weatherBug.helpers.EndpointHelper;
	import net.tw.web.weatherBug.signals.ForecastLoaded;
	import net.tw.web.weatherBug.vo.Forecast;
	import net.tw.web.weatherBug.vo.ForecastDay;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class ForecastLoader extends WeatherBugLoader {
		
		public const loaded:ForecastLoaded=new ForecastLoaded();
		
		protected var _sourceLocationType:String;
		protected var _sourceLocation:*;
		
		public function ForecastLoader(settings:WeatherBugServiceSettings, locationType:String, location:*) {
			super();
			_sourceLocationType=locationType;
			_sourceLocation=location;
			_loader.load(EndpointHelper.getAPIRequest(settings, 'getForecastRSS.aspx', getLocationParameters(settings, locationType, location)));
		}
		
		override protected function onComplete(e:Event):XML {
			var xml:XML=super.onComplete(e);
			if (!xml) return null;
			
			var forecast:Forecast=new Forecast();
			
			forecast.sourceLocationType=_sourceLocationType;
			forecast.sourceLocation=_sourceLocation;
			
			forecast.location=new Location();
			forecast.location.cityName=xml..aws::city.text();
			
			forecast.unitType=getUnitTypeFromURL(xml..aws::WebURL.text());
			
			var sDate:String=xml..aws::forecasts.@date;
			forecast.date=new Date(sDate.split(' ')[0]);
			
			
			var curDay:ForecastDay;
			for each (var forecastNode:XML in xml..aws::forecast) {
				curDay=new ForecastDay();
				
				curDay.description=			forecastNode.aws::description.text();
				curDay.high=				handleTemperature(forecastNode.aws::high.text());
				curDay.low=					handleTemperature(forecastNode.aws::low.text());
				curDay.image=				forecastNode.aws::image.text();
				curDay.icon=				forecastNode.aws::image.@icon;
				curDay.prediction=			forecastNode.aws::prediction.text();
				curDay.shortPrediction=		forecastNode.aws::['short-prediction'].text();
				curDay.title=				forecastNode.aws::title.text();
				curDay.altTitle=			forecastNode.aws::title.@alttitle;
				
				forecast.forecastDays.push(curDay);
			}
			
			loaded.dispatch(forecast);
			
			return xml;
		}
		
		protected function handleTemperature(value:String):Number {
			return value=='---' ? undefined : Number(value);
		}
	}
}
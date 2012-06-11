package net.tw.web.weatherBug.loaders {
	import flash.events.Event;
	
	import net.tw.web.weatherBug.helpers.EndpointHelper;
	import net.tw.web.weatherBug.vo.LocationType;
	import net.tw.web.weatherBug.signals.ForecastLoaded;
	import net.tw.web.weatherBug.vo.Forecast;
	import net.tw.web.weatherBug.vo.ForecastDay;
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class ForecastLoader extends WeatherBugLoader {
		
		public const loaded:ForecastLoaded=new ForecastLoaded();
		
		public function ForecastLoader(settings:WeatherBugServiceSettings, locationType:String, location:*) {
			super();
			_loader.load(EndpointHelper.getAPIRequest(settings, 'getForecastRSS.aspx', getLocationParameters(settings, locationType, location)));
		}
		
		override protected function onComplete(e:Event):void {
			super.onComplete(e);
			
			var res:String=_loader.data as String;
			if (res=='Access Denied') {
				failed.dispatch();
				return;
			}
			
			try {
				var xml:XML=new XML(res);
			} catch (er:Error) {
				failed.dispatch();
				return;
			}
			
			var forecast:Forecast=new Forecast();
			
			forecast.unitType=getUnitTypeFromURL(xml..aws::WebURL.text());
			
			var sDate:String=xml..aws::forecasts.@date;
			forecast.date=new Date(sDate.split(' ')[0]);
			
			forecast.location=new Location();
			forecast.location.cityName=xml..aws::city.text();
			
			var curDay:ForecastDay;
			for each (var forecastNode:XML in xml..aws::forecast) {
				curDay=new ForecastDay();
				
				curDay.description=			forecastNode.aws::description.text();
				curDay.high=				handleTemperature(forecastNode.aws::high.text());
				curDay.low=					handleTemperature(forecastNode.aws::low.text());
				curDay.image=				forecastNode.aws::image.text();
				curDay.prediction=			forecastNode.aws::prediction.text();
				curDay.shortPrediction=		forecastNode.aws::['short-prediction'].text();
				curDay.title=				forecastNode.aws::title.text();
				
				forecast.forecastDays.push(curDay);
			}
			
			loaded.dispatch(forecast);
		}
		
		protected function handleTemperature(value:String):Number {
			return value=='---' ? undefined : Number(value);
		}
	}
}
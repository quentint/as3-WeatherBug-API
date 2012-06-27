package net.tw.web.weatherBug.loaders {
	import flash.events.Event;
	
	import net.tw.web.weatherBug.helpers.EndpointHelper;
	import net.tw.web.weatherBug.signals.LiveWeatherLoaded;
	import net.tw.web.weatherBug.vo.LiveWeather;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class LiveWeatherLoader extends WeatherBugLoader {
		
		public const loaded:LiveWeatherLoaded=new LiveWeatherLoaded();
		
		protected var _sourceLocationType:String;
		protected var _sourceLocation:*;
		
		public function LiveWeatherLoader(settings:WeatherBugServiceSettings, locationType:String, location:*) {
			super();
			_sourceLocationType=locationType;
			_sourceLocation=location;
			_loader.load(EndpointHelper.getAPIRequest(settings, 'getLiveWeatherRSS.aspx', getLocationParameters(settings, locationType, location)));
		}
		
		override protected function onComplete(e:Event):XML {
			var xml:XML=super.onComplete(e);
			if (!xml) return null;
			
			//trace(xml.toXMLString());
			
			var liveWeather:LiveWeather=new LiveWeather();
			
			liveWeather.sourceLocationType=_sourceLocationType;
			liveWeather.sourceLocation=_sourceLocation;
			
			liveWeather.unitType=getUnitTypeFromURL(xml..aws::WebURL.text());
			
			liveWeather.condition=xml..aws::['current-condition'].text();
			liveWeather.icon=String(xml..aws::['current-condition'].@icon).split('/').pop();
			
			var dateNode:XMLList=xml..aws::['ob-date'];
			liveWeather.date=new Date(
				dateNode.aws::year.@number,
				dateNode.aws::month.@number-1,
				dateNode.aws::day.@number,
				dateNode.aws::hour.attribute('hour-24'),
				dateNode.aws::minute.@number,
				dateNode.aws::second.@number
			);

			liveWeather.humidity=				xml..aws::humidity.text();
			liveWeather.humidityHigh=			xml..aws::['humidity-high'].text();
			liveWeather.humidityLow=			xml..aws::['humidity-low'].text();
			liveWeather.humidityRate=			xml..aws::['humidity-rate'].text();
				
			liveWeather.moonPhase=				xml..aws::['moon-phase'].text();
			
			liveWeather.pressure=				xml..aws::pressure.text();
			liveWeather.pressureHigh=			xml..aws::['pressure-high'].text();
			liveWeather.pressureLow=			xml..aws::['pressure-low'].text();
			liveWeather.pressureRate=			xml..aws::['pressure-rate'].text();
			
			liveWeather.temperature=			xml..aws::temp.text();
			liveWeather.temperatureHigh=		xml..aws::['temp-high'].text();
			liveWeather.temperatureLow=			xml..aws::['temp-low'].text();
			liveWeather.temperatureRate=		xml..aws::['temp-rate'].text();
			
			liveWeather.location=new Location();
			liveWeather.location.countryName=	xml..aws::country.text();
			liveWeather.location.cityName=		String(xml..aws::['city-state'].text()).split(',')[0];
			
			loaded.dispatch(liveWeather);
			
			return xml;
		}
	}
}
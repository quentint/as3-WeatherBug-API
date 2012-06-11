package flexUnitTests.utils {
	import net.tw.web.weatherBug.WeatherBugService;
	import net.tw.web.weatherBug.signals.ForecastLoaded;
	import net.tw.web.weatherBug.signals.LiveWeatherLoaded;
	import net.tw.web.weatherBug.signals.LoadFailed;
	import net.tw.web.weatherBug.signals.LocationsLoaded;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class SuiteUtils {
		
		public static const ASYNC_TIMEOUT:uint=2500;
		
		public static function createWeatherBugService():WeatherBugService {
			// Get you key here: http://weather.weatherbug.com/desktop-weather/api.html
			var service:WeatherBugService=new WeatherBugService(new WeatherBugServiceSettings('XXX'));
			
			service.locationsLoaded=new LocationsLoaded();
			service.locationsLoadFailed=new LoadFailed();
			
			service.liveWeatherLoaded=new LiveWeatherLoaded();
			service.liveWeatherLoadFailed=new LoadFailed();
			
			service.forecastLoaded=new ForecastLoaded();
			service.forecastLoadFailed=new LoadFailed();
			
			return service;
		}
	}
}
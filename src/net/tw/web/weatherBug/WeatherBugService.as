/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 16:45
 */
package net.tw.web.weatherBug {
	import net.tw.web.weatherBug.loaders.ForecastLoader;
	import net.tw.web.weatherBug.loaders.LiveWeatherLoader;
	import net.tw.web.weatherBug.loaders.LocationLoader;
	import net.tw.web.weatherBug.loaders.vo.LocationType;
	import net.tw.web.weatherBug.signals.ForecastLoaded;
	import net.tw.web.weatherBug.signals.LiveWeatherLoaded;
	import net.tw.web.weatherBug.signals.LoadFailed;
	import net.tw.web.weatherBug.signals.LocationsLoaded;
	import net.tw.web.weatherBug.vo.Forecast;
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.LiveWeather;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class WeatherBugService {

		protected var _settings:WeatherBugServiceSettings;

		public var locationsLoaded:LocationsLoaded;
		public var locationsLoadFailed:LoadFailed;
		
		public var liveWeatherLoaded:LiveWeatherLoaded;
		public var liveWeatherLoadFailed:LoadFailed;
		
		public var forecastLoaded:ForecastLoaded;
		public var forecastLoadFailed:LoadFailed;

		public function WeatherBugService($settings:WeatherBugServiceSettings) {
			_settings=$settings;
		}

		public function get settings():WeatherBugServiceSettings {
			return _settings;
		}
		public function set settings(value:WeatherBugServiceSettings):void {
			_settings=value;
		}

		/**
		 * LOCATION
		 */
		
		protected var _locationLoader:LocationLoader;
		public function searchLocations(zipCodeOrLocationName:String):LocationLoader {
			_locationLoader=new LocationLoader(settings, zipCodeOrLocationName);
			_locationLoader.failed.addOnce(onLocationLoaderFailed);
			_locationLoader.loaded.addOnce(onLocationLoaded);
			return _locationLoader;
		}
		protected function cleanLocationLoader():void {
			_locationLoader.failed.remove(onLocationLoaderFailed);
			_locationLoader.loaded.remove(onLocationLoaded);
			_locationLoader=null;
		}
		protected function onLocationLoaderFailed():void {
			cleanLocationLoader();
			locationsLoadFailed.dispatch();
		}
		protected function onLocationLoaded(locations:Array):void {
			cleanLocationLoader();
			locationsLoaded.dispatch(locations);
		}
		
		/**
		 * LIVE WEATHER
		 */

		protected var _liveWeatherLoader:LiveWeatherLoader;
		protected function loadLiveWeather(type:String, location:*):LiveWeatherLoader {
			_liveWeatherLoader=new LiveWeatherLoader(settings, type, location);
			_liveWeatherLoader.failed.addOnce(onLiveWeatherLoaderFailed);
			_liveWeatherLoader.loaded.addOnce(onLiveWeatherLoaded);
			return _liveWeatherLoader;
		}
		protected function cleanLiveWeatherLoader():void {
			_liveWeatherLoader.failed.remove(onLiveWeatherLoaderFailed);
			_liveWeatherLoader.loaded.remove(onLiveWeatherLoaded);
			_liveWeatherLoader=null;
		}
		protected function onLiveWeatherLoaderFailed():void {
			cleanLiveWeatherLoader();
			liveWeatherLoadFailed.dispatch();
		}
		protected function onLiveWeatherLoaded(liveWeather:LiveWeather):void {
			cleanLiveWeatherLoader();
			liveWeatherLoaded.dispatch(liveWeather);
		}
		public function loadLiveWeatherForZipCode(zipCode:String):LiveWeatherLoader {
			return loadLiveWeather(LocationType.ZIP_CODE, zipCode);
		}
		public function loadLiveWeatherForCityCode(cityCode:String):LiveWeatherLoader {
			return loadLiveWeather(LocationType.CITY_CODE, cityCode);
		}
		public function loadLiveWeatherForGeolocation(geolocation:LatLng):LiveWeatherLoader {
			return loadLiveWeather(LocationType.GEOLOCATION, geolocation);
		}
		
		/**
		 * FORECAST
		 */

		protected var _forecastLoader:ForecastLoader;
		protected function loadForecast(type:String, location:*):ForecastLoader {
			_forecastLoader=new ForecastLoader(settings, type, location);
			_forecastLoader.failed.addOnce(onForecastLoaderFailed);
			_forecastLoader.loaded.addOnce(onForecastLoaded);
			return _forecastLoader;
		}
		protected function cleanForecastLoader():void {
			_forecastLoader.failed.remove(onForecastLoaderFailed);
			_forecastLoader.loaded.remove(onForecastLoaded);
			_forecastLoader=null;
		}
		protected function onForecastLoaderFailed():void {
			cleanForecastLoader();
			forecastLoadFailed.dispatch();
		}
		protected function onForecastLoaded(forecast:Forecast):void {
			cleanForecastLoader();
			forecastLoaded.dispatch(forecast);
		}
		public function loadForecastForZipCode(zipCode:String):ForecastLoader {
			return loadForecast(LocationType.ZIP_CODE, zipCode);
		}
		public function loadForecastForCityCode(cityCode:String):ForecastLoader {
			return loadForecast(LocationType.CITY_CODE, cityCode);
		}
		public function loadForecastForGeolocation(geolocation:LatLng):ForecastLoader {
			return loadForecast(LocationType.GEOLOCATION, geolocation);
		}

	}
}
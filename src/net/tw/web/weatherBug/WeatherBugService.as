/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 16:45
 */
package net.tw.web.weatherBug {
	import net.tw.web.weatherBug.loaders.ForecastLoader;
	import net.tw.web.weatherBug.loaders.LiveWeatherLoader;
	import net.tw.web.weatherBug.loaders.LocationLoader;
	import net.tw.web.weatherBug.signals.ForecastLoadFailed;
	import net.tw.web.weatherBug.signals.ForecastLoaded;
	import net.tw.web.weatherBug.signals.LiveWeatherLoadFailed;
	import net.tw.web.weatherBug.signals.LiveWeatherLoaded;
	import net.tw.web.weatherBug.signals.LocationsLoadFailed;
	import net.tw.web.weatherBug.signals.LocationsLoaded;
	import net.tw.web.weatherBug.vo.CityType;
	import net.tw.web.weatherBug.vo.Forecast;
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.LiveWeather;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.LocationType;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;
	
	// http://weather.weatherbug.com/corporate/products/API/help.aspx#xml

	public class WeatherBugService {

		protected var _settings:WeatherBugServiceSettings;

		[Inject]
		public var locationsLoaded:LocationsLoaded;
		[Inject]
		public var locationsLoadFailed:LocationsLoadFailed;
		
		[Inject]
		public var liveWeatherLoaded:LiveWeatherLoaded;
		[Inject]
		public var liveWeatherLoadFailed:LiveWeatherLoadFailed;
		
		[Inject]
		public var forecastLoaded:ForecastLoaded;
		[Inject]
		public var forecastLoadFailed:ForecastLoadFailed;

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
			if (!_locationLoader) return;
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
		protected function _loadLiveWeather(type:String, location:*):LiveWeatherLoader {
			_liveWeatherLoader=new LiveWeatherLoader(settings, type, location);
			_liveWeatherLoader.failed.addOnce(onLiveWeatherLoaderFailed);
			_liveWeatherLoader.loaded.addOnce(onLiveWeatherLoaded);
			return _liveWeatherLoader;
		}
		protected function cleanLiveWeatherLoader():void {
			if (!_liveWeatherLoader) return;
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
			return _loadLiveWeather(LocationType.ZIP_CODE, zipCode);
		}
		public function loadLiveWeatherForCityCode(cityCode:String):LiveWeatherLoader {
			return _loadLiveWeather(LocationType.CITY_CODE, cityCode);
		}
		public function loadLiveWeatherForGeolocation(geolocation:LatLng):LiveWeatherLoader {
			return _loadLiveWeather(LocationType.GEOLOCATION, geolocation);
		}
		public function loadLiveWeather(location:*):LiveWeatherLoader {
			if (!(location is Location) && !(location is LatLng)) {
				throw new ArgumentError('location parameter has to be of Location or LatLng type!');
			}
			
			if (location is LatLng) return loadLiveWeatherForGeolocation(location as LatLng);
			
			var l:Location=location as Location;
			
			if (l.cityType==CityType.INSIDE_US) return loadLiveWeatherForZipCode(l.zipCode);
			return loadLiveWeatherForCityCode(l.cityCode);
		}
		
		/**
		 * FORECAST
		 */

		protected var _forecastLoader:ForecastLoader;
		protected function _loadForecast(type:String, location:*):ForecastLoader {
			_forecastLoader=new ForecastLoader(settings, type, location);
			_forecastLoader.failed.addOnce(onForecastLoaderFailed);
			_forecastLoader.loaded.addOnce(onForecastLoaded);
			return _forecastLoader;
		}
		protected function cleanForecastLoader():void {
			if (!_forecastLoader) return;
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
			return _loadForecast(LocationType.ZIP_CODE, zipCode);
		}
		public function loadForecastForCityCode(cityCode:String):ForecastLoader {
			return _loadForecast(LocationType.CITY_CODE, cityCode);
		}
		public function loadForecastForGeolocation(geolocation:LatLng):ForecastLoader {
			return _loadForecast(LocationType.GEOLOCATION, geolocation);
		}
		public function loadForecast(location:*):ForecastLoader {
			if (!(location is Location) && !(location is LatLng)) {
				throw new ArgumentError('location parameter has to be of Location or LatLng type!');
			}
			
			if (location is LatLng) return loadForecastForGeolocation(location as LatLng);
			
			var l:Location=location as Location;
			
			if (l.cityType==CityType.INSIDE_US) return loadForecastForZipCode(l.zipCode);
			return loadForecastForCityCode(l.cityCode);
		}
	}
}
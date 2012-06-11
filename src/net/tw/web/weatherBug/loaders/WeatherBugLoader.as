package net.tw.web.weatherBug.loaders {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	import net.tw.web.weatherBug.vo.LocationType;
	import net.tw.web.weatherBug.signals.LoadFailed;
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.UnitType;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class WeatherBugLoader {
		protected const aws:Namespace=new Namespace('http://www.aws.com/aws');
		public const failed:LoadFailed=new LoadFailed();
		protected var _loader:URLLoader;
		
		public function WeatherBugLoader():void {
			_loader=new URLLoader();
			
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		protected function removeListeners():void {
			_loader.removeEventListener(Event.COMPLETE, onComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		protected function onComplete(e:Event):void {
			// TODO: Handle Access denied error globally!
			removeListeners();
		}
		
		protected function onError(e:Event):void {
			removeListeners();
			trace(e);
			failed.dispatch();
		}
		
		protected function getLocationParameters(settings:WeatherBugServiceSettings, locationType:String, location:*):Object {
			var params:Object={UnitType:settings.unitType, OutputType:1};
			
			if (locationType==LocationType.ZIP_CODE) params.zipCode=location;
			else if (locationType==LocationType.CITY_CODE) params.cityCode=location;
			else if (locationType==LocationType.GEOLOCATION) {
				params.lat=LatLng(location).lat;
				params.lng=LatLng(location).lng;
			}
			
			return params;
		}
		
		protected function getUnitTypeFromURL(url:String):int {
			return String(url).indexOf('Units=0')>-1 ? UnitType.US_CUSTOMARY : UnitType.METRIC_SYSTEM;
		}
		
	}
}
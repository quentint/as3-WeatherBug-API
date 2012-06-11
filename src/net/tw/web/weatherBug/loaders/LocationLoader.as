package net.tw.web.weatherBug.loaders {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.tw.web.weatherBug.helpers.EndpointHelper;
	import net.tw.web.weatherBug.signals.LoadFailed;
	import net.tw.web.weatherBug.signals.LocationsLoaded;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class LocationLoader extends WeatherBugLoader {
		
		public const loaded:LocationsLoaded=new LocationsLoaded();
		
		public function LocationLoader(settings:WeatherBugServiceSettings, zipCodeOrLocationName:String) {
			super();
			_loader.load(EndpointHelper.getAPIRequest(settings, 'getLocationsXML.aspx', {SearchString:zipCodeOrLocationName}));
		}
		
		override protected function onComplete(e:Event):XML {
			
			var xml:XML=super.onComplete(e);
			if (!xml) return null;
			
			var ar:Array=[];
			var curLocation:Location;
			
			for each (var xmlLocation:XML in xml..aws::location) {
				curLocation=new Location();
				
				curLocation.cityName=		xmlLocation.@cityname;
				curLocation.stateName=		xmlLocation.@statename;
				curLocation.countryName=	xmlLocation.@countryname;
				curLocation.zipCode=		xmlLocation.@zipcode;
				curLocation.cityCode=		xmlLocation.@citycode;
				curLocation.cityType=		xmlLocation.@citytype;
				
				ar.push(curLocation);
			}
			loaded.dispatch(ar);
			
			return xml;
		}
	}
}
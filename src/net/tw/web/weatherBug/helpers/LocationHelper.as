package net.tw.web.weatherBug.helpers {
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.LocationType;

	public class LocationHelper {
		/**
		 *
		 * @param location: Can be of type LatLng or Location
		 * @param sourceLocationType: Has to be one of LocationType's constants
		 * @param sourceLocation: has to be of type String (cityCode or zipCode) or LatLng
		 * 
		 */
		public static function locationMatchesSource(location:*, sourceLocationType:String, sourceLocation:*):Boolean {
			if (sourceLocationType==LocationType.GEOLOCATION) {
				if (!(location is LatLng)) return false;
				if (!(sourceLocation is LatLng)) return false;
				var ll:LatLng=location as LatLng;
				var sourceLL:LatLng=sourceLocation as LatLng;
				if (ll.lat!=sourceLL.lat) return false;
				if (ll.lng!=sourceLL.lng) return false;
				return true;
			}
			
			if (!(location is Location)) return false;
			var l:Location=location as Location;
			
			if (sourceLocationType==LocationType.CITY_CODE) return l.cityCode==sourceLocation;
			if (sourceLocationType==LocationType.ZIP_CODE) return l.zipCode==sourceLocation;
			
			return false;
		}
	}
}
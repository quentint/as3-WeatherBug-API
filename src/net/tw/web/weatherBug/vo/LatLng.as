/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:00
 */
package net.tw.web.weatherBug.vo {
	public class LatLng {

		public var lat:Number;
		public var lng:Number;

		public function LatLng($lat:Number, $lng:Number) {
			lat = $lat;
			lng = $lng;
		}
		
		public function toString():String {
			return '[LatLng lat='+lat+' lng='+lng+']';
		}
	}
}
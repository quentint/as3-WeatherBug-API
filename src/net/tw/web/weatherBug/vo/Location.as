/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 16:54
 */
package net.tw.web.weatherBug.vo {
	public class Location {
		
		public function Location($zipCode:String=null, $cityCode:String=null) {
			zipCode=$zipCode;
			cityCode=$cityCode;
		}

		public var cityName:String;
		public var stateName:String;
		public var countryName:String;
		public var zipCode:String;
		public var cityCode:String;
		public var cityType:int;
		
		public function toString():String {
			return '[Location zipCode='+zipCode+' cityCode='+cityCode+' cityName='+cityName+' countryName='+countryName+']';
		}

	}
}
/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 16:47
 */
package net.tw.web.weatherBug.vo {
	public class WeatherBugServiceSettings {

		public var licenceKey:String;
		public var unitType:int;

		public function WeatherBugServiceSettings($licenceKey:String, $unitType:int=0) {
			licenceKey=$licenceKey;
			unitType=$unitType;
		}
	}
}
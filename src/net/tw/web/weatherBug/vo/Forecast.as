/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:15
 */
package net.tw.web.weatherBug.vo {
	public class Forecast {

		public var date:Date;
		public var location:Location;
		public var unitType:int;
		public var forecastDays:Array;

		public function Forecast() {
			forecastDays=[];
		}
	}
}
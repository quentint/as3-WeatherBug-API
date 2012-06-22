/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:09
 */
package net.tw.web.weatherBug.vo {
	import net.tw.web.weatherBug.helpers.ConditionCodeHelper;

	public class LiveWeather {
		
		public var sourceLocationType:String;
		public var sourceLocation:*;

		public var date:Date;
		public var unitType:int;

		public var condition:String;
		public var icon:String;
		public function get conditionCode():int {
			return ConditionCodeHelper.getCodeFromIcon(icon);
		}

		public var temperature:Number;
		public var temperatureHigh:Number;
		public var temperatureLow:Number;
		public var temperatureRate:Number;

		public var pressure:Number;
		public var pressureHigh:Number;
		public var pressureLow:Number;
		public var pressureRate:Number;

		public var humidity:Number;
		public var humidityHigh:Number;
		public var humidityLow:Number;
		public var humidityRate:Number;

		public var moonPhase:Number;
		
		public var location:Location;
		
	}
}

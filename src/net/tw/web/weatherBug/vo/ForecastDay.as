/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:16
 */
package net.tw.web.weatherBug.vo {
	public class ForecastDay {

		public var title:String;
		public var shortPrediction:String;
		public var image:String;
		public var description:String;
		public var prediction:String;
		public var high:Number;
		public var low:Number;
		
		public function get chance():Boolean	{return shortPrediction.indexOf('Chance')>-1;}
		public function get heavy():Boolean		{return shortPrediction.indexOf('Heavy')>-1;}
		public function get mostly():Boolean	{return shortPrediction.indexOf('Mostly')>-1;}
		public function get partly():Boolean	{return shortPrediction.indexOf('Partly')>-1;}
		
		public function get changePercent():Number {
			if (!chance) return 100;
			return Number(shortPrediction.split('%')[0]);
		}
		
		public function get cloudy():Boolean			{return shortPrediction.indexOf('Cloudy')>-1;}
		public function get drizzle():Boolean			{return shortPrediction.indexOf('Drizzle')>-1;}
		public function get rain():Boolean				{return shortPrediction.indexOf('Rain')>-1;}
		public function get thunderstorms():Boolean		{return shortPrediction.indexOf('Thunderstorms')>-1;}
		public function get shower():Boolean			{return shortPrediction.indexOf('Shower')>-1;}
		public function get storms():Boolean			{return shortPrediction.indexOf('Storms')>-1;}
		public function get sunny():Boolean				{return shortPrediction.indexOf('Sunny')>-1;}
		public function get windy():Boolean				{return shortPrediction.indexOf('Windy')>-1;}

	}
}

/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:16
 */
package net.tw.web.weatherBug.vo {
	import net.tw.web.weatherBug.helpers.ConditionCodeHelper;

	public class ForecastDay {

		public var title:String;
		public var altTitle:String;
		public var shortPrediction:String;
		public var image:String;
		public var icon:String;
		public var description:String;
		public var prediction:String;
		public var high:Number;
		public var low:Number;
		
		protected function has(s:String):Boolean {
			return shortPrediction && shortPrediction.indexOf(s)>-1;
		}
		
		public function get chance():Boolean	{return has('Chance')}
		public function get heavy():Boolean		{return has('Heavy')}
		public function get mostly():Boolean	{return has('Mostly')}
		public function get partly():Boolean	{return has('Partly')}
		
		public function get changePercent():Number {
			if (!chance) return 100;
			return Number(shortPrediction.split('%')[0]);
		}
		
		public function get cloudy():Boolean			{return has('Cloudy')}
		public function get drizzle():Boolean			{return has('Drizzle')}
		public function get rain():Boolean				{return has('Rain')}
		public function get thunderstorms():Boolean		{return has('Thunderstorms')}
		public function get shower():Boolean			{return has('Shower')}
		public function get storms():Boolean			{return has('Storms')}
		public function get sunny():Boolean				{return has('Sunny')}
		public function get windy():Boolean				{return has('Windy')}
		
		public function get conditionCode():int {
			return ConditionCodeHelper.getCodeFromIcon(icon);
		}

	}
}

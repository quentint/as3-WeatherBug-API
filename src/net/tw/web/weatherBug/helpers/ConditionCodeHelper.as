package net.tw.web.weatherBug.helpers {
	public class ConditionCodeHelper {

		public static function getCodeFromIcon(icon:String):int {
			return icon ? int(icon.substr(4, 3)) : -1;
		}
		
	}
}
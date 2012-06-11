package net.tw.web.weatherBug.helpers {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;

	public class EndpointHelper {
		
		public static const API_BASE_URL:String='http://<apicode>.api.wxbug.net/';
		
		public static function getAPIRequest(settings:WeatherBugServiceSettings, pageName:String, parameters:Object):URLRequest {
			var r:URLRequest=new URLRequest(API_BASE_URL.replace('<apicode>', settings.licenceKey)+pageName);
			r.method=URLRequestMethod.GET;
			
			var variables:URLVariables=new URLVariables();
			for (var key:String in parameters) {
				variables[key]=parameters[key];
			}
			variables.ACode=settings.licenceKey;
			r.data=variables;
			
			return r;
		}
	}
}
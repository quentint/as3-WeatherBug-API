package flexUnitTests {
	import flexUnitTests.utils.SuiteUtils;
	
	import flexunit.framework.Assert;
	
	import net.tw.web.weatherBug.WeatherBugService;
	import net.tw.web.weatherBug.vo.Forecast;
	import net.tw.web.weatherBug.vo.ForecastDay;
	import net.tw.web.weatherBug.vo.LatLng;
	import net.tw.web.weatherBug.vo.Location;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.core.isA;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.number.isNumber;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	public class WeatherBugLoadForecastTest {
		
		protected var service:WeatherBugService;
		
		[Before]
		public function setUp():void {
			service=SuiteUtils.createWeatherBugService();
		}
		
		[After]
		public function tearDown():void {
			service=null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void {}
		
		[AfterClass]
		public static function tearDownAfterClass():void {}
		
		[Test(async)]
		public function testLoadForecastForCityCode():void {
			proceedOnSignal(this, service.forecastLoaded, SuiteUtils.ASYNC_TIMEOUT);
			service.loadForecastForCityCode('62285');
		}
		
		[Test(async)]
		public function testLoadForecastForGeolocation():void {
			proceedOnSignal(this, service.forecastLoaded, SuiteUtils.ASYNC_TIMEOUT);
			service.loadForecastForGeolocation(new LatLng(44.8377890, -0.5791800));
		}
		
		[Test(async)]
		public function testLoadForecastForZipCode():void {
			proceedOnSignal(this, service.forecastLoaded, SuiteUtils.ASYNC_TIMEOUT);
			service.loadForecastForZipCode('64732');
		}
		
		[Test(async)]
		public function testLoadForecastForZipCode_values_are_correct():void {
			handleSignal(this, service.forecastLoaded, on_testLoadForecastForZipCode_values_are_correct, SuiteUtils.ASYNC_TIMEOUT);
			service.loadForecastForZipCode('64732');
		}
		protected function on_testLoadForecastForZipCode_values_are_correct(e:SignalAsyncEvent, data:Object):void {
			var forecast:Forecast=e.args[0];
			
			assertThat(forecast.forecastDays.length, greaterThan(0));
			assertTrue(forecast.date<new Date());
			assertThat(forecast.location, isA(Location));
			
			var day:ForecastDay;
			
			for (var i:int=0; i<forecast.forecastDays.length; i++) {
				day=forecast.forecastDays[i];
				assertThat(day.description.length, greaterThan(0));
				//assertThat(day.high, isNumber());
				assertThat(day.image.length, greaterThan(0));
				//assertThat(day.low, isNumber());
				assertThat(day.prediction.length, greaterThan(0));
				assertThat(day.shortPrediction.length, greaterThan(0));
				assertThat(day.title.length, greaterThan(0));
			}
		}
	}
}
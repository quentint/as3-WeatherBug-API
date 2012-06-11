package flexUnitTests {
	import flexUnitTests.utils.SuiteUtils;
	
	import flexunit.framework.Assert;
	
	import net.tw.web.weatherBug.WeatherBugService;
	import net.tw.web.weatherBug.loaders.LocationLoader;
	import net.tw.web.weatherBug.signals.LocationsLoaded;
	import net.tw.web.weatherBug.vo.CityType;
	import net.tw.web.weatherBug.vo.Location;
	import net.tw.web.weatherBug.vo.WeatherBugServiceSettings;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;

	public class WeatherBugServiceTest {	
		
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
		public function test_searchLocation_fails_with_fake_key():void {
			service.settings.licenceKey='abc';
			var ll:LocationLoader=service.searchLocations('Bordeaux, France');
			proceedOnSignal(this, ll.failed, SuiteUtils.ASYNC_TIMEOUT);
		}
		
		[Test(async)]
		public function test_searchLocation_fails_with_fake_key2():void {
			service.settings.licenceKey='abc';
			proceedOnSignal(this, service.locationsLoadFailed, SuiteUtils.ASYNC_TIMEOUT);
			service.searchLocations('Bordeaux, France');
		}
		
		[Test(async)]
		public function test_searchLocations_succeeds_with_good_key():void {
			var ll:LocationLoader=service.searchLocations('Bordeaux, France');
			proceedOnSignal(this, ll.loaded, SuiteUtils.ASYNC_TIMEOUT);
		}
		
		[Test(async)]
		public function test_searchLocations_succeeds_with_good_key2():void {
			proceedOnSignal(this, service.locationsLoaded, SuiteUtils.ASYNC_TIMEOUT);
			service.searchLocations('Bordeaux, France');
		}
		
	}
}
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

	public class WeatherBugSearchLocationsTest {	
		
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
		public function test_searchLocations_dispatches_proper_locations():void {
			var ll:LocationLoader=service.searchLocations('Bordeaux, France');
			handleSignal(this, ll.loaded, onLocationsLoaded, SuiteUtils.ASYNC_TIMEOUT);
		}
		protected function onLocationsLoaded(e:SignalAsyncEvent, data:Object):void {
			var locations:Array=e.args[0];
			assertThat(locations.length, equalTo(4));
			for (var i:int=0; i<locations.length; i++) {
				assertThat(locations[i], instanceOf(Location));
				assertThat(Location(locations[i]).cityType, equalTo(CityType.OUTSIDE_US));
			}
		}
		
		[Test(async)]
		public function test_searchLocations_succeeds_with_good_zip_key():void {
			var ll:LocationLoader=service.searchLocations('64732');
			proceedOnSignal(this, ll.loaded, SuiteUtils.ASYNC_TIMEOUT);
		}
		
		[Test(async)]
		public function test_searchLocations_succeeds_with_good_zip_key_and_has_proper_location():void {
			var ll:LocationLoader=service.searchLocations('64732');
			handleSignal(this, ll.loaded, onZIPLocationLoaded, SuiteUtils.ASYNC_TIMEOUT);
		}
		protected function onZIPLocationLoaded(e:SignalAsyncEvent, data:Object):void {
			var locations:Array=e.args[0];
			assertThat(locations.length, equalTo(1));
			var firstLocation:Location=locations[0];
			assertThat(firstLocation.cityName, equalTo('Chilhowee'));
			assertThat(firstLocation.stateName, equalTo('MO'));
			assertThat(firstLocation.countryName, equalTo('USA'));
			assertThat(firstLocation.zipCode, equalTo('64732'));
			assertThat(firstLocation.cityType, equalTo(CityType.INSIDE_US));
		}
		
	}
}
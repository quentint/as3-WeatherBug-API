package flexUnitTests {
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class WeatherBugTestSuite {
		public var serviceTest:WeatherBugServiceTest;
		public var searchLocationsTest:WeatherBugSearchLocationsTest;
		public var loadLiveWeatherTest:WeatherBugLoadLiveWeatherTest;
		public var loadForecastTest:WeatherBugLoadForecastTest;
	}
}
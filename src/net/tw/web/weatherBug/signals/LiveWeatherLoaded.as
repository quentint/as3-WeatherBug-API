/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:09
 */
package net.tw.web.weatherBug.signals {

	import net.tw.web.weatherBug.vo.LiveWeather;

	import org.osflash.signals.Signal;

	public class LiveWeatherLoaded extends Signal {

		public function LiveWeatherLoaded():void {
			super(LiveWeather);
		}
	}
}
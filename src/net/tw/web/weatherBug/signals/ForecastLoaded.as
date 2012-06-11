/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:14
 */
package net.tw.web.weatherBug.signals {

	import net.tw.web.weatherBug.vo.Forecast;

	import org.osflash.signals.Signal;

	public class ForecastLoaded extends Signal {

		public function ForecastLoaded():void {
			super(Forecast);
		}
	}
}
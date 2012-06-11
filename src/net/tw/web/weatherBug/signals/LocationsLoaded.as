/**
 * User: Quentin
 * Date: 08/06/12
 * Time: 17:02
 */
package net.tw.web.weatherBug.signals {

	import org.osflash.signals.Signal;

	public class LocationsLoaded extends Signal {

		public function LocationsLoaded():void {
			super(Array);
		}
	}
}
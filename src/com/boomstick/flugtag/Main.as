import 'babel-runtime/core-js/array/from'

package {
	import openfl.display.Stage;

	public class Main {	
		
		public function Main () {
			
			var stage:Stage = new Stage (550, 400, 0xFFFFFF, Flugtag);
			document.body.appendChild (stage.element);
			
		}
		
	}

}
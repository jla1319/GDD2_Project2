package code {
	
	import flash.display.MovieClip;
	
	
	public class PressurePlatform extends Platform {
		
		private static var raiseHeight: Number = 0;
		
		private static var pressureList: Array = new Array();
		
		private var direction: String;
		
		public function PressurePlatform(direction:String) {
			// constructor code
			pressureList.push(this);
			this.direction = direction;
		}
		
		public function MoveDown(){
			if(this.direction == "up"){
				for(var i:int = 0;i<pressureList.length;i++){
				this.y += .1;
				}
			}
			if(this.direction == "down"){
				for(var j:int = 0;j<pressureList.length;j++){
				this.y -= .1;
				}
			}
		}
		
		public function LiftGate(){
			if(this.direction == "up"){
				for(var i:int = 0;i<pressureList.length;i++){
				this.y -=100;
				}
			}
			if(this.direction == "down"){
				for(var j:int = 0;j<pressureList.length;j++){
				this.y += 100;
				}
			}
		}
	}
	
}

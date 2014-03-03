package code {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.net.URLLoader;
	
	public class Document extends MovieClip {
		
		// Variables
		private var box: Box;
		private var platforms:Array;
		private var isRightPressed: Boolean = false;
		private var isLeftPressed: Boolean = false;
		private var isUpPressed: Boolean = false;
		private var upKeyHeld: Boolean = false;
		private var isDownPressed: Boolean = false;
		private var ldr = new URLLoader();
		
		public function Document() {
			// constructor code
			
			platforms = new Array();
			
			//comment or delete once we get xml file
			for(var i:uint = 0; i < 30; i++)
			{
				var platform:Platform = new Platform();
				platform.x = Math.random() * stage.stageWidth;
				platform.y = Math.random() * stage.stageHeight;
				addChild(platform);
				platforms.push(platform);
			}
			
			box = new Box(this);
			addChild(box);
			box.x = 250;
			box.y = 100;
			
			//uncomment to set up loading xml file
			
			//var xmlPath = "xml/level.xml";
			//var xmlReq = new URLRequest(xmlPath);
			//ldr.addEventListener(Event.COMPLETE, xmlComplete);
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			
			//uncomment to load xml file
			
			//ldr.load(xmlReq);
		}
		//think this is all set for when we test an xml file
		private function xmlComplete(e:Event):void {
			ldr.removeEventListener(Event.COMPLETE, xmlComplete);
			var myXML:XML = new XML( e.target.data );
			// myXML is effectively references the <gallery> tag
			for each (var platform:XML in myXML.platforms) 
			{
				var _platform:Platform = new Platform;
				_platform.x = platform.x;
				_platform.y = platform.y;
				_platform.height = platform.height;
				_platform.width = platform.width;
				platforms.push(_platform);
			}
		}
		
					//determines what keys are pressed
		public function onKeyPressed(ke: KeyboardEvent) {
			if(ke.keyCode == Keyboard.RIGHT){
				isRightPressed = true;
			}
			if(ke.keyCode == Keyboard.LEFT){
				isLeftPressed = true;
			}
			if(ke.keyCode == Keyboard.UP){
				isUpPressed = true;
			}
			if(ke.keyCode == Keyboard.DOWN){
				isDownPressed = true;
			}
		}
			
		public function onKeyRelease(ke: KeyboardEvent){
			//determines if keys are not pressed or stopped being pressed
			if(ke.keyCode == Keyboard.RIGHT){
				isRightPressed = false;
			}
			if(ke.keyCode == Keyboard.LEFT){
				isLeftPressed = false;
			}
			if(ke.keyCode == Keyboard.UP){
				isUpPressed = false;
				upKeyHeld = false;
			}
			if(ke.keyCode == Keyboard.DOWN){
				isDownPressed = false;
			}
		}
			
		public function onFrame(e: Event){
			//if the key is pressed, move object
			if(isRightPressed) {
				box.moveRight();
			}
			if(isLeftPressed) {
				box.moveLeft();
			}
			if(isUpPressed){
				if(!upKeyHeld)
				{
					box.moveUp();
					upKeyHeld = true;
				}
			}
			if(isDownPressed){
				box.moveDown();
			}
			box.movement();	
			for(var i:uint = 0; i < platforms.length; i++)
			{
				checkCollision(platforms[i]);
			}
		}
		private function checkCollision(platform:Platform):void {
			//distance from the center of the box (character) to the center of the platform
			var dx:Number = (box.x + (box.width / 2)) - (platform.x + (platform.width / 2));
			var dy:Number = (box.y + (box.height / 2)) - (platform.y + (platform.height / 2));
			
			//is the box running into a platform?
			if(box.hitTestObject(platform))
			{
				//add in the previous position to avoid shifting through platforms
				dx += box.prevX - box.x;
				dy += box.prevY - box.y;
				//are you close to one of the sides, or to the top or bottom? (p.height / p.width) is a ratio for platform size
				//Horizontal
				if (Math.abs(dx) * (platform.height / platform.width) > Math.abs(dy)) {
					
					//left side
					if (dx < 0) {
						box.x = platform.x - box.width - .5;
					}
					//right side
					else {
						box.x = platform.x + platform.width;
					}
					box.xAccel = 0;
				}
				//Vertical
				else {
					//top
					if (dy < 0) {
						box.y = platform.y - box.height;
						box.inAir = false;
						box.doubleJump = false;
					}
					//bottom
					else {
						box.y = platform.y + platform.height + .5;
					}
					box.yAccel = 0;
				}
			}
		}
	}	
}
	
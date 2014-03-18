﻿package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	
	public class Box extends MovieClip {
		var xAccel:Number = 0;
		var yAccel:Number = 0;
		var prevX:Number = 0;
		var prevY:Number = 0;
		var inAir:Boolean = false;
		var doubleJump:Boolean = false;
		var main:Document;
			public function Box(d:Document) {
				// constructor code
				main = d;
		}
		
			public function moveRight(): void {
				xAccel += .5;
				if(xAccel < 0){
					xAccel += .25;
				}
			}
			public function moveLeft(): void {
				xAccel -= .5;
				if(xAccel > 0){
					xAccel -= .25;
				}
			}
		
			public function moveUp(): void {
				//Second jump coded first so it won't activate first time around
				if(inAir && !doubleJump)
				{
					yAccel = -5;
					doubleJump = true;
				}
				//Primary jump
				if(!inAir)
				{
					yAccel = -5;
				}
				yAccel = -4;
			}
			
			public function moveDown(): void {
				
			}
			public function movement(): void {
				//trace(x, y);
				var xMove:Number = xAccel * (60/main.stage.frameRate);
				var yMove:Number = yAccel * (60/main.stage.frameRate);
				//absolute max movement x
				if (Math.abs(xMove) > 14)
				{
					if(xMove > 14)
					{
						xMove = 14;
					}
					else
					{
						xMove = -14;
					}
				}
				//absolute max movement y
				if (Math.abs(yMove) > 20)
				{
					if(yMove > 20)
					{
						yMove = 20;
					}
					else
					{
						yMove = -20;
					}
				}
				//air resistance for moving along x too quickly
				if (xAccel > 7)
				{
					xAccel -= .75;
				}
				if (xAccel < -7)
				{
					xAccel += .75;
				}
				//previous is used to stop box from flying through platforms
				prevX = this.x;
				prevY = this.y;
				
				//move the box
				this.x += xMove;
				this.y += yMove;
				
				//wonderful magical friction
				xAccel = xAccel * 0.85;
				
				//come to a stop if acceleration is too low
				if(Math.abs(xAccel) < .2)
				{
					xAccel = 0;
				}
				
				//falling
				yAccel += .85;
				
				//used if box walks off platform to avoid getting getting a free air jump (even if we use trapoline someday)
				if(Math.abs(yAccel) > 0)
				{
					inAir = true;
				}
				
				//terminal velocity
				if(yAccel > 14)
				{
					yAccel = 14;
				}
				//top of screen
				if(this.y < 0)
				{
					this.y = 0;
					yAccel = 0;
				}
				if(this.x < 0)
				{
					this.x = 0;
					xAccel = 0;
				}
				if(this.x > 626)
				{
					this.x = 626;
					xAccel = 0;
				}
			}
	}
	
}

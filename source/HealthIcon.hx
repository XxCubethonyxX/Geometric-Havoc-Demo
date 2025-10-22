package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxMath;
import meta.data.*;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	public var isPlayer:Bool = false;
	public var char:String = '';
	public var icontype:String = '';
	public var animoveride:Bool = false;
	public var autoUpdate:Bool = true;
	public var iconOffset:Int = 26;

	

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
		
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);

		if ( autoUpdate){
			if( PlayState.instance != null){
				var mult:Float = FlxMath.lerp(1, scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * PlayState.instance.playbackRate), 0, 1));
				scale.set(mult, mult);
				updateHitbox();
				switch (isPlayer){
					case(true):
						updateAnim(PlayState.instance.hp);
						
					case(false):
						updateAnim(4 - PlayState.instance.hp);
					
				
				}				
		}
			}
		}
		
	

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); //Load stupidly first for getting the file size

			switch(width){

				default:
					loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr
					icontype = 'default';

				case(450):
					loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //starting the winning icon stuffs
					icontype = 'win';
					trace('win');
				case (618):
					loadGraphic(file, true, Math.floor(width / 4), Math.floor(height)); //starting the winning icon stuffs
					icontype = 'jsab';

				

			}
			
			

			switch (icontype){ //initiate the icon animation shit 

				case ('default'):
					iconOffsets[0] = (width - 150) / 2; 
					iconOffsets[1] = (width - 150) / 2;
					animation.add(char, [0, 1], 0, false, isPlayer);
				case ('win'):
					iconOffsets[0] = (width - 150) / 3;
					iconOffsets[1] = (width - 150) / 3;
					iconOffsets[2] = (width - 150) / 3;
					animation.add(char, [0, 1, 2], 0, false, isPlayer);
				case ('jsab'):
					iconOffsets[0] = (width - 150) / 4;
					iconOffsets[1] = (width - 150) / 4;
					iconOffsets[2] = (width - 150) / 4;
					iconOffsets[3] = (width - 150) / 4;
					animation.add(char, [0, 1, 2, 3], 0, false, isPlayer);
			}
			updateHitbox();

			
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.data.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}

	public function bop(){
			if ( autoUpdate){
				scale.set(1.2, 1.2);

			}
	}
	public dynamic function updateAnim(health:Float){

		
		var num:Int = Math.floor(Math.max(Math.min(Math.floor(health / 20), 4), 0));

		if(animoveride !=true){
			
			switch (icontype){
				case('default'):
					if (health < 20)
						animation.curAnim.curFrame = 1;
					else
						animation.curAnim.curFrame = 0;

				case('win'):
					if (health < 20)
						animation.curAnim.curFrame = 1;

					else if (health > 80 )
						animation.curAnim.curFrame = 2;
					else
						animation.curAnim.curFrame = 0;
				case('supperpiss'):
					animation.curAnim.curFrame = 4 - num;
				case('jsab'):
				
					switch(health){
						case(1):
							animation.curAnim.curFrame = 3;
							
						case(2):
							animation.curAnim.curFrame = 2;
							
						case(3):
							animation.curAnim.curFrame = 1;
						
						case(4):
							animation.curAnim.curFrame = 0;
						
					}
				
			}

		}
	}
}
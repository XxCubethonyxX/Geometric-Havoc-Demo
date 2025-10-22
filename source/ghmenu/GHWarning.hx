package ghmenu;

import flixel.util.FlxTimer;
import ghmenu.ui.GHButton;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import objects.Cursor;
import flixel.text.FlxText;

/**
 * Warning state that always shows up.
 * 
 * Will also play the splash screen.
 */
class GHWarning extends MusicBeatState
{
	var emitter:FlxEmitter;

	var disable:GHButton;
	var enable:GHButton;

	var black:FlxSprite;

	override function create()
	{
	
		if (FlxG.save.data.weekCompleted != null)
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;

		FlxG.mouse.visible = false;

		Cursor.show();
		emitter = new FlxEmitter(0, FlxG.height * 1.1);
		emitter.velocity.set(-50, -500, 100, -50, -100, -500, 100, -1000);
		emitter.loadParticles(Paths.image('ghui/triangle', 'preload'), 100);
		emitter.start(false, 0.1);
		emitter.alpha.set(0.25);
		emitter.angularVelocity.set(-40, 40);
		emitter.lifespan.set(5);
		emitter.width = FlxG.width;
		emitter.scale.set(0.4, 0.4, 0.4, 0.4);
		add(emitter);

		var title = new FlxText(0, 0, FlxG.width, 'Warning!');
		title.setFormat(Paths.font('nexa_bold.otf'), 32, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		title.antialiasing = ClientPrefs.data.globalAntialiasing;
		title.alpha = 0;
		title.borderSize = 3;

		var text = new FlxText(0, 0, FlxG.width);
		text.setFormat(Paths.font('nexa_regular.otf'), 32, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		text.borderSize = 3;
		text.text = "\nThis mod contains flashing lights.\nIf you're photosensitive or epileptic,\nplease disable below!";
		text.antialiasing = ClientPrefs.data.globalAntialiasing;
		text.alpha = 0;
		text.screenCenter();
		title.y = text.y - title.height;

		add(title);
		add(text);

		FlxTween.tween(title, {alpha: 1}, 0.5, {startDelay: 0.5});
		FlxTween.tween(text, {alpha: 1}, 0.5, {startDelay: 0.5});

		enable = new GHButton(0, 500, 'Enable', 1.0, () ->
		{
			ClientPrefs.data.flashing = true;
			enable.canClick = false;
			enable.disappear();
			disable.disappear();
			goIntro();
		});
		enable.x = FlxG.width / 2 - enable.width;
		add(enable);

		disable = new GHButton(0, 500, 'Disable', 1.0, () ->
		{
			ClientPrefs.data.flashing = false;
			enable.canClick = false;
			enable.disappear();
			disable.disappear();
			goIntro();
		});
		disable.x = FlxG.width / 2 + 16;
		add(disable);

		
		

		black = new FlxSprite().makeGraphic(Std.int(FlxG.width * 1.1), Std.int(FlxG.height * 1.1), FlxColor.BLACK);
		black.screenCenter();
		black.alpha = 0;
		add(black);

		super.create();
	}

	var introed:Bool = false;

	function goIntro():Void
	{
		if (!introed)
		{
			introed = true;
	
			new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
				FlxTween.tween(black, {alpha: 1}, 0.5, {
					onComplete: (_) ->
					{
						new FlxTimer().start(3, function(tmr:FlxTimer)
						{
							var filepath:String = Paths.video(ClientPrefs.data.flashing ? 'splash_flash' : 'splash_noflash');
							var video = new objects.VideoSprite(filepath, true, false, false);
							video.finishCallback = function()
							{
								MusicBeatState.switchState(new GHTitle());
							}
							add(video);
							video.play();
						});
					}
				});
			});
		}
	}

	function getOut():Void
	{
		MusicBeatState.switchState(new GHTitle());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(disable)|| FlxG.mouse.overlaps(enable)){
			Cursor.set_cursorMode(Pointer);
		}
		else{
			Cursor.set_cursorMode(Default);
		}

		for (i in emitter.members)
		{
			i.alpha = 0.25 * (1 - i.percent);
		}
	}
}

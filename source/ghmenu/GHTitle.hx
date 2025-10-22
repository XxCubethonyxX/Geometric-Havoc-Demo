package ghmenu;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import ghmenu.ui.Wisp;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxAngle;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxGradient;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class GHTitle extends MusicBeatState
{
	static var init:Bool = false;

	var introDone:Bool = false;
	var introStarted:Bool = false;

	var camGame:FlxCamera;
	var camHUD:FlxCamera;

	override function create()
	{
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);
	
		CustomFadeTransition.nextCamera = camHUD;

		super.create();

		if (!init)
		{
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
                Conductor.changeBPM(130);
                FlxG.sound.playMusic(Paths.music('title'), 0);
                FlxG.sound.music.fadeIn(1);

				doIntro();
				init = true;
			});
		}
		else
		{
			skipIntro();
		}
	}

	var t1:FlxSprite;
	var t2:FlxSprite;
	var t3:FlxSprite;

	var whiteFlash:FlxSprite;

	var wisp:Wisp;
	var bgSquares:FlxEmitter;

	// also funny text
	var n1:FlxText; // a mod by
	var n2:FlxText; // cubickrasher studios

	var n3:FlxText; // inspired by
	var n4:FlxText; // just shapes n beats

	var logo:FlxSprite;
	var press:FlxText;

	var bullshit:FlxGroup;

	function skipIntro()
	{
		introSkipped = true;
		introDone = true;
		goBeatTri = true;
		doIntro();
		forEach((e) ->
		{
			FlxTween.completeTweensOf(e); // give up
		}, true);

		FlxTween.completeTweensOf(FlxG.camera);
		FlxG.camera.zoom = 1;
	}

	function doIntro()
	{
		var bg = new FlxSprite().makeGraphic(FlxG.width * Std.int(1.5), FlxG.height * Std.int(1.5), 0xff000d13);
		bg.screenCenter();
		add(bg);

		// var bgGrid = new FlxBackdrop(Paths.image("ghui/ui_grid", "preload"));
		// bgGrid.setPosition(0, 0);
		// bgGrid.velocity.y = -64;
		// bgGrid.alpha = 0.1;
		// add(bgGrid);

		bgSquares = new FlxEmitter(0, FlxG.height * 1.1);
		bgSquares.velocity.set(-10, -10, 10, 10);
		bgSquares.makeParticles(16, 16, FlxColor.WHITE, 25);
		bgSquares.start(false, 2);
		bgSquares.alpha.set(0.15);
		bgSquares.angularVelocity.set(10, 20);
		bgSquares.lifespan.set(10);
		bgSquares.width = FlxG.width - 128 * 2;
		bgSquares.height = FlxG.height - 128 * 2;
		bgSquares.x = (FlxG.width - bgSquares.width) / 2;
		bgSquares.y = (FlxG.height - bgSquares.height) / 2;
		bgSquares.scale.set(20, 20);
		add(bgSquares);

		bullshit = new FlxGroup();
		add(bullshit);

		whiteFlash = new FlxSprite().makeGraphic(Std.int(FlxG.width * 1.1), Std.int(FlxG.height * 1.1));
		whiteFlash.screenCenter();
		whiteFlash.alpha = 0;
		add(whiteFlash);

		wisp = new Wisp();
		wisp.screenCenter();
		wisp.allAlpha = 0;
		add(wisp.glow);
		add(wisp.glow2);
		add(wisp);

		logo = new FlxSprite().loadGraphic(Paths.image("ghui/logo"));
		logo.scale.set(0.3, 0.3);
		logo.updateHitbox();
		logo.scale.set(0, 0);
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(logo);

		t1 = new FlxSprite().loadGraphic(Paths.image("ghui/triangleglow"));
		t1.angularVelocity = 20;
		t1.scale.set(0, 0);
		t1.origin.set(157.5, 175.5);
		t1.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(t1);

		t2 = new FlxSprite().loadGraphic(Paths.image("ghui/triangleglow"));
		t2.angularVelocity = 20;
		t2.scale.set(0, 0);
		t2.origin.set(157.5, 175.5);
		t2.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(t2);

		t3 = new FlxSprite().loadGraphic(Paths.image("ghui/triangleglow"));
		t3.angularVelocity = 20;
		t3.scale.set(0, 0);
		t3.origin.set(157.5, 175.5);
		t3.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(t3);

		n1 = new FlxText(0, 0, 0, 'a mod by');
		n1.setFormat(Paths.font('nexa_regular.otf'), 32, FlxColor.WHITE, CENTER, NONE);
		n2 = new FlxText(0, 0, 0, 'cubickrasher studios');
		n2.setFormat(Paths.font('nexa_bold.otf'), 48, FlxColor.WHITE, CENTER, NONE);
		n2.setPosition(64, FlxG.height - n2.height - 64);
		n1.setPosition(n2.x, n2.y - n1.height + 8);
		n1.alpha = n2.alpha = 0;
		n1.antialiasing = ClientPrefs.data.globalAntialiasing;
		n2.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(n1);
		add(n2);

		n3 = new FlxText(0, 0, 0, 'INSPIRED BY');
		n3.setFormat(Paths.font('nexa_regular.otf'), 32, FlxColor.WHITE, CENTER, NONE);
		n4 = new FlxText(0, 0, 0, 'just shapes and beats');
		n4.setFormat(Paths.font('nexa_bold.otf'), 48, FlxColor.WHITE, CENTER, NONE);
		n4.setPosition(FlxG.width - n4.width - 64, FlxG.height - n4.height - 64);
		n3.setPosition(FlxG.width - n3.width - 64, n4.y - n3.height + 8);
		n3.alpha = n4.alpha = 0;
		n3.antialiasing = ClientPrefs.data.globalAntialiasing;
		n4.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(n3);
		add(n4);

		press = new FlxText("PRESS ANYTHING TO BEGIN");
		press.setFormat(Paths.font('nexa_light.otf'), 32);
		press.screenCenter(X);
		press.y = FlxG.height - press.height - 64;
		press.alpha = 0;
		press.antialiasing = ClientPrefs.data.globalAntialiasing;
		add(press);

		n1.cameras = n2.cameras = n3.cameras = n4.cameras = [camHUD];
		FlxG.camera.zoom = 2;
		FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.crochet / 1000 * 28, {ease: FlxEase.sineInOut});

		FlxG.camera.fade(0xff000000, 1, true);

		introStarted = true;
	}

	function completeIntro():Void
	{
		// introStarted = false;

		if (ClientPrefs.data.flashing)
		{
			FlxG.camera.flash();
			t1.alpha = 0;
			t2.alpha = 0;
			t3.alpha = 0;
		}
		else
		{
			FlxTween.num(triRadius, 1000, 1, {ease: FlxEase.circOut}, (n) ->
			{
				triRadius = n;
			});
		}

		introDone = true;
		goBeatTri = true;
	}

	var goBeatTri:Bool = false;

	override function beatHit()
	{
		super.beatHit();

		if (!introDone)
		{
			switch (curBeat)
			{
				// wisp fadeins
				case 1 | 9 | 17:
					wisp.screenCenter();
					//wisp.killMembers();
					FlxTween.tween(wisp, {allAlpha: 1}, Conductor.crochet / 1000);

				// wisp redirects
				case 2:
					FlxTween.num(0, 1, Conductor.crochet / 1000 * 2, {ease: FlxEase.linear, onComplete: (e) ->
					{
						wisp.allAlpha = 0;
						wisp.glowAlpha = 1;
					}}, (n) ->
						{
							var wx = wisp.x;
							var wy = wisp.y;

							wisp.x = wx + (t1.x - wx) * n + (t1.width - wisp.width) / 2 * n;
							wisp.y = wy + (t1.y - wy) * n + (t1.height - wisp.height) / 2 * n;
							wisp.glowAlpha = 1 - n;
						});

					FlxTween.tween(n1, {alpha: 1}, Conductor.crochet / 1500);
					FlxTween.tween(n2, {alpha: 1}, Conductor.crochet / 1500);
				case 10:
					FlxTween.num(0, 1, Conductor.crochet / 1000 * 2, {ease: FlxEase.linear, onComplete: (e) ->
					{
						wisp.allAlpha = 0;
						wisp.glowAlpha = 1;
					}}, (n) ->
						{
							var wx = wisp.x;
							var wy = wisp.y;

							wisp.x = wx + (t2.x - wx) * n + (t2.width - wisp.width) / 2 * n;
							wisp.y = wy + (t2.y - wy) * n + (t2.height - wisp.height) / 2 * n;
							wisp.glowAlpha = 1 - n;
						});

					FlxTween.tween(n3, {alpha: 1}, Conductor.crochet / 1500);
					FlxTween.tween(n4, {alpha: 1}, Conductor.crochet / 1500);
				case 18:
					FlxTween.num(0, 1, Conductor.crochet / 1000 * 2, {ease: FlxEase.linear, onComplete: (e) ->
					{
						wisp.allAlpha = 0;
						wisp.glowAlpha = 1;
					}}, (n) ->
						{
							var wx = wisp.x;
							var wy = wisp.y;

							wisp.x = wx + (t3.x - wx) * n + (t3.width - wisp.width) / 2 * n;
							wisp.y = wy + (t3.y - wy) * n + (t3.height - wisp.height) / 2 * n;
							wisp.glowAlpha = 1 - n;
						});

					n1.text = "FUNNY 1";
					n2.text = "FUNNY 2";
					FlxTween.tween(n1, {alpha: 1}, Conductor.crochet / 1500);
					FlxTween.tween(n2, {alpha: 1}, Conductor.crochet / 1500);

				// three triangles
				case 4:
					FlxTween.tween(t1.scale, {x: 0.5, y: 0.5}, Conductor.crochet / 1500, {ease: FlxEase.backOut});
					for (i in [t1, t2, t3])
					{
						i.angularAcceleration += 5;
					}

					if (ClientPrefs.data.flashing)
					{
						whiteFlash.alpha = 0.15;
						FlxTween.tween(whiteFlash, {alpha: 0}, Conductor.crochet / 1500);
					}

					FlxTween.tween(n1, {alpha: 0}, Conductor.crochet / 1500);
					FlxTween.tween(n2, {alpha: 0}, Conductor.crochet / 1500);
				case 12:
					FlxTween.tween(t2.scale, {x: 0.5, y: 0.5}, Conductor.crochet / 1500, {ease: FlxEase.backOut});
					for (i in [t1, t2, t3])
					{
						i.angularAcceleration += 5;
					}

					if (ClientPrefs.data.flashing)
					{
						whiteFlash.alpha = 0.15;
						FlxTween.tween(whiteFlash, {alpha: 0}, Conductor.crochet / 1500);
					}

					FlxTween.tween(n3, {alpha: 0}, Conductor.crochet / 1500);
					FlxTween.tween(n4, {alpha: 0}, Conductor.crochet / 1500);
				case 20:
					FlxTween.tween(t3.scale, {x: 0.5, y: 0.5}, Conductor.crochet / 1500, {ease: FlxEase.backOut});
					for (i in [t1, t2, t3])
					{
						i.angularAcceleration += 10;
					}

					if (ClientPrefs.data.flashing)
					{
						whiteFlash.alpha = 0.15;
						FlxTween.tween(whiteFlash, {alpha: 0}, Conductor.crochet / 1500);
					}

					FlxTween.tween(n1, {alpha: 0}, Conductor.crochet / 1500);
					FlxTween.tween(n2, {alpha: 0}, Conductor.crochet / 1500);

				// drop
				case 28:
					angleAdd = 100;
					for (i in [t1, t2, t3])
					{
						i.angularAcceleration = 50;
					}

					FlxTween.num(triRadius, 300, Conductor.crochet / 500, (n) ->
					{
						triRadius = n;
					});

					FlxTween.cancelTweensOf(FlxG.camera, ["zoom"]);
					FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.crochet / 1500, {ease: FlxEase.circOut});
				case 30:
					FlxTween.num(triRadius, 225, Conductor.crochet / 500, (n) ->
					{
						triRadius = n;
					});

					FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.crochet / 1500, {ease: FlxEase.circOut});
				case 31:
					FlxTween.tween(FlxG.camera, {zoom: 2}, Conductor.crochet / 1000, {ease: FlxEase.backIn});

					FlxTween.num(triRadius, 0, Conductor.crochet / 1000, {
						ease: FlxEase.backIn,
						onComplete: (_) ->
						{
							completeIntro();
							FlxTween.cancelTweensOf(FlxG.camera, ["zoom"]);
							FlxG.camera.zoom = 0.9;
							FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.crochet / 1500, {ease: FlxEase.backOut});
						}
					}, (n) ->
						{
							triRadius = n;
						});
			}
		}
		else
		{
			if (goBeatTri)
			{
				for (i in bgSquares.members)
				{
					FlxTween.cancelTweensOf(i);
					i.scale.set(21, 21);
					FlxTween.tween(i.scale, {x: 20, y: 20}, Conductor.crochet / 1500, {ease: FlxEase.circOut});
				}
			}

			if ((curBeat >= 33 || introDone) && !goingOut)
			{
				goUp = !goUp;

				FlxTween.cancelTweensOf(logo, ['scale.x', 'scale.y', 'y']);
				FlxTween.cancelTweensOf(press, ['scale.x', 'scale.y', 'y']);
				if (goUp)
				{
					logo.y = (FlxG.height - logo.height) / 2 - 8;
					press.y = FlxG.height - press.height - 64 + 4;
				}
				else
				{
					logo.scale.set(0.315, 0.315);
					press.y = FlxG.height - press.height - 64 - 4;
				}

				FlxTween.tween(logo, {"scale.x": 0.3, "scale.y": 0.3, y: (FlxG.height - logo.height) / 2}, Conductor.crochet / 1000, {ease: FlxEase.backOut});
				FlxTween.tween(press, {"scale.x": 1, "scale.y": 1, y: FlxG.height - press.height - 64}, Conductor.crochet / 1000, {ease: FlxEase.backOut});

				if (curBeat % 2 == 0)
				{
					spawnRandomVerticalBeam();
				}
			}
		}

		if ((curBeat == 32 && !shitShown) || (introSkipped && !shitShown))
		{
			shitShown = true;
			FlxTween.tween(logo.scale, {x: 0.3, y: 0.3}, Conductor.crochet / 1000, {ease: FlxEase.backOut});

			press.alpha = 1;
			FlxTween.tween(press, {alpha: 0.5}, Conductor.crochet / 1000 * 2, {type: PINGPONG, ease: FlxEase.sineInOut});
		}
	}

	var shitShown = false;
	var introSkipped = false;
    var goingOut = false;

	function spawnRandomVerticalBeam()
	{
		var rx = FlxG.random.float(64, FlxG.width - 64);
		var ry = FlxG.random.float(FlxG.height * 0.15, FlxG.height * 0.35);

		var square = new FlxSprite().loadGraphic(Paths.image("ghui/square", "preload"));
		square.color = 0xff999999;
		square.x = rx - square.width / 2;
		square.y = ry - square.height / 2;
		square.scale.set(0, 0);
		square.antialiasing = ClientPrefs.data.globalAntialiasing;
		bullshit.add(square);

		FlxTween.tween(square.scale, {x: 1, y: 1}, Conductor.crochet / 1000, {ease: FlxEase.backOut});
		FlxTween.tween(square, {angle: FlxG.random.bool() ? 360 : -360, y: FlxG.height}, Conductor.crochet / 1000 * 2, {
			ease: FlxEase.circIn,
			startDelay: Conductor.crochet / 1250,
			onComplete: (e) ->
			{
				square.angle = 0;
				square.setGraphicSize(0, FlxG.height * 2);
				square.scale.x = 0;
				square.screenCenter(Y);
				FlxTween.tween(square, {"scale.x": 1}, Conductor.crochet / 1500, {ease: FlxEase.backOut});
				FlxTween.tween(square, {alpha: 0, "scale.x": 0}, Conductor.crochet / 1500, {ease: FlxEase.backOut, startDelay: Conductor.crochet / 1000});
			}
		});
	}

	var goUp = false;
	var triRadius:Float = 250;
	var angleAdd:Float = 50;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music != null)
		{
			if (FlxG.sound.music.playing)
			{
				Conductor.songPosition = FlxG.sound.music.time;
			}
		}

		if (introStarted)
		{
			var s = 0;
			for (i in [t1, t2, t3])
			{
				i.angle += angleAdd * elapsed;
				i.x = FlxG.width / 2 + Math.cos(FlxAngle.asRadians((i.angle - angleAdd * elapsed) + 120 * s)) * triRadius - i.origin.x;
				i.y = FlxG.height / 2 + Math.sin(FlxAngle.asRadians((i.angle - angleAdd * elapsed) + 120 * s)) * triRadius - i.origin.y;
				s++;
			}

			bgSquares.forEach((e) ->
			{
				if (e.percent <= 0.25)
				{
					e.alpha = (e.percent / 0.25) * 0.05;
				}
				else if (e.percent >= 0.75)
				{
					e.alpha = (1 - ((e.percent - 0.75) / 0.25)) * 0.05;
				}
			});
		}

		if (FlxG.keys.justPressed.ANY)
		{
			if (!introDone)
			{
                FlxG.sound.music.pause();
                for (i in 0...32) {
                    curBeat = i;
                    beatHit();
                    forEach((e) ->
                    {
                        FlxTween.completeTweensOf(e); // give up
                    }, true);
                }
                Conductor.songPosition = FlxG.sound.music.time = Conductor.crochet * 31;
                FlxG.sound.music.play();

				skipIntro();
			}
			else
			{
                goingOut = true;
                logo.acceleration.y = 980;
                logo.angularVelocity = -360 * 3;
                logo.velocity.set(-450, -300);

                MusicBeatState.switchState(new MainMenuState());
			}
		}
	}
}

package ghmenu.ui;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;

class Wisp extends FlxEmitter {
    public var glow:FlxSprite;
    public var glow2:FlxSprite;

    public var allAlpha:Float = 1.0;
    public var glowAlpha:Float = 1.0;

    public function new(x:Float = 0, y:Float = 0, glowColor:FlxColor = 0xff00ffff) {
        glow = new FlxSprite().loadGraphic(Paths.image('ghui/wispGlow', 'preload'));
        glow.scale.set(0.5, 0.5);
        glow.antialiasing = ClientPrefs.data.globalAntialiasing;
        glow.updateHitbox();

        glow2 = glow.clone();
        glow2.scale.set(0.5, 0.5);
        glow2.antialiasing = ClientPrefs.data.globalAntialiasing;
        glow2.updateHitbox();

        glow.color = glow2.color = glowColor;

        super(x, y, 0);

        makeParticles(16, 16, FlxColor.WHITE, 100);
        lifespan.set(1);
        velocity.set(0);
        start(false, 0.05);
        setSize(16, 16);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        glow.setPosition(this.x + (width - glow.width) / 2, this.y + (height - glow.height) / 2);
        glow2.setPosition(glow.x, glow.y);

        glow.alpha = glow2.alpha = allAlpha * glowAlpha;

        if (ClientPrefs.data.flashing)
            glow2.alpha = FlxG.random.float() * allAlpha * glowAlpha;

        forEachAlive((e:FlxParticle) -> {
            e.scale.set(1 - e.percent, 1 - e.percent);
            e.velocity.set(0, 0);
            e.alpha = allAlpha;
        });
    }

    public function screenCenter(axis:FlxAxes = FlxAxes.XY) {
        if (axis.x)
			x = (FlxG.width - width) / 2;

		if (axis.y)
			y = (FlxG.height - height) / 2;
    }
}
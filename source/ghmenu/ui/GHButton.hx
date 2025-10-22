package ghmenu.ui;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import objects.Cursor;
import flixel.input.mouse.FlxMouseEvent;
import flixel.FlxSprite;

class GHButton extends FlxSprite
{
	public var onclick(default, set):Void->Void;

	public var text:FlxText;
	public var delay:Float = 0;
	public var played:Bool = false;

	public var canClick:Bool = false;

	public function new(x:Float = 0, y:Float = 0, label:String, delay:Float = 0, ?onclick:Void->Void)
	{
		super(x, y);

		this.delay = delay;

		frames = Paths.getSparrowAtlas('ghui/button');
		animation.addByPrefix('do', '', 24, false);

		text = new FlxText(x, y, this.width - 164, label, 32);
		text.setFormat(Paths.font('nexa_bold.otf'), 24, FlxColor.WHITE, CENTER, NONE);
		text.antialiasing = ClientPrefs.data.globalAntialiasing;
		text.setPosition(x + 100, (y + (height - text.height) / 2));
		text.alpha = 0;

		this.onclick = onclick;

		antialiasing = ClientPrefs.data.globalAntialiasing;
		visible = false;
	}

	var counter:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!played)
		{
			counter += elapsed;

			if (counter >= delay)
			{
				played = true;
				visible = true;
				animation.play('do');
				FlxTween.tween(text, {alpha: 1}, 0.5, {startDelay: 1, onComplete: (_) -> { canClick = true; }});
			}
		}
	}

	override function draw()
	{
		super.draw();

		if (text != null && visible)
		{
			text.setPosition(x + 100, (y + (height - text.height) / 2 - 8));
			text.cameras = cameras;
			text.draw();
		}
	}

	public function disappear():Void
	{
		FlxTween.tween(text, {alpha: 0}, 0.5, {onComplete: (_) -> {
            animation.play('do', true, true);
            new FlxTimer().start(1.5, (_) -> {
                visible = false;
            });
        }});
	}

	function setupMouse():Void
	{
		// I've wrote worse, don't worry
		FlxMouseEvent.add(this, (_) ->
		{
            if (played) {
				
                FlxTween.cancelTweensOf(this, ['scale.x', 'scale.y']);
                FlxTween.cancelTweensOf(text, ['scale.x', 'scale.y']);
                FlxTween.tween(this, {'scale.x': 0.9, 'scale.y': 0.9}, 0.3, {ease: FlxEase.circOut});
                FlxTween.tween(text, {'scale.x': 0.9, 'scale.y': 0.9}, 0.3, {ease: FlxEase.circOut});
				
            }
		}, (_) ->
        {
            if (played) {
				
                FlxTween.cancelTweensOf(this, ['scale.x', 'scale.y']);
                FlxTween.cancelTweensOf(text, ['scale.x', 'scale.y']);
                FlxTween.tween(this, {'scale.x': 1, 'scale.y': 1}, 0.3, {ease: FlxEase.backOut});
                FlxTween.tween(text, {'scale.x': 1, 'scale.y': 1}, 0.3, {ease: FlxEase.backOut});
				

                if (FlxG.mouse.overlaps(this) && onclick != null && canClick)
                    onclick();
            }
        }, (_) ->
        {
            color = 0xffcccccc;
			
        }, (_) ->
        {
            color = 0xffffffff;
			

            if (played) {
                FlxTween.cancelTweensOf(this, ['scale.x', 'scale.y']);
                FlxTween.cancelTweensOf(text, ['scale.x', 'scale.y']);
                FlxTween.tween(this, {'scale.x': 1, 'scale.y': 1}, 0.3, {ease: FlxEase.backOut});
                FlxTween.tween(text, {'scale.x': 1, 'scale.y': 1}, 0.3, {ease: FlxEase.backOut});
            }
        });
	}

	function set_onclick(value:Void->Void):Void->Void
	{
		FlxMouseEvent.remove(this);
		setupMouse();

		onclick = value;

		return value;
	}
}

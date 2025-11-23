import Character;
import Note;


var rim:DropShadowShader;

var shaderchar:Character;
function onCreatePost(){
    rim = new DropShadowShader();
    rim.angle = 0;
    rim.setAdjustColor(-46, -38, -25, -20);
    trace('rim angle is ' + rim.angle);
    rim.color = 0xFFFFFF;
    trace('rim color is ' + rim.color);
    shaderchar = new Character(PlayState.dadGroup.x, PlayState.dadGroup.y, "cube-shader");
    this.alpha = 0;
    
    addBehindDad(shaderchar);
    shaderchar.shader = rim;
    rim.attachedSprite =  shaderchar;
    trace('addedshaderchar');
    shaderchar.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int) {
            rim.updateFrameInfo(shaderchar.frame);
            }

}


function playSingAnim(note:Note,AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0 ){
    shaderchar.playSingAnim(note,AnimName,Force,Reversed,Frame);
}

function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0 ){
    shaderchar.playAnim(AnimName,Force,Reversed,Frame);
    
}

function dance(){
    shaderchar.playAnim('idle' + shaderchar.idleSuffix);
}


function onBeatHit(beat:Int){

    
}

function togletunnel(toggle:String){
    if (toggle == 'on'){
        this.alpha = 0;
        shaderchar.alpha = 1;
    }
    if (toggle == 'off'){
        this.alpha = 1;
        shaderchar.alpha = 0 ;

    }
}

function Charupdate(e:Float){
    shaderchar.y = this.y;
    
}
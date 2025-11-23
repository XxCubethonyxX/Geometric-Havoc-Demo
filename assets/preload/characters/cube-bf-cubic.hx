import Character;
import Note;


var rim:DropShadowShader;
var danced:Bool = false;

var shaderchar:Character;
function onCreatePost(){
    trace('balls');
    rim = new DropShadowShader();
    rim.angle = 180;
    rim.setAdjustColor(-46, -38, -25, -20);
    rim.color = 0xFFFFFF;
    shaderchar = new Character(PlayState.boyfriendGroup.x, PlayState.boyfriendGroup.y, "cube-bf-shader",'other',true);
    this.alpha = 0;
    shaderchar.alpha = 1;
    addBehindBF(shaderchar);
    shaderchar.shader = rim;

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
    danced = !danced;
    if (danced)
        
        shaderchar.playAnim('danceRight' + shaderchar.idleSuffix);
    else
        shaderchar.playAnim('danceLeft' + shaderchar.idleSuffix);
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
    danced = this.danced;
    
}
import h2d.Text;
import h2d.RenderContext;
import hxd.Timer;
import h2d.Scene.ScaleMode;
import js.html.FontFaceSetLoadEvent;
import hxd.fmt.grd.Data;

class Main extends hxd.App {
    override function init() {
      //  s2d.setFixedSize(512, 448); // SNES BAYBEE
        

        for(i in 0...32) {
            for(j in 0...28) {
                var tile = h2d.Tile.fromColor((i+j)%2==0 ? 0x232323 : 0x111111, 16, 16);
                var bmp = new h2d.Bitmap(tile, s2d);
                
                bmp.x = 0 + i * tile.width;
                bmp.y = 0 + j * tile.height;
            }
        }

        //tf.textAlign = Center;
        //tf.setPosition(s2d.width/2,s2d.height/2 - 16);
    }
    static function main() {
        new Main();
    }

    override function update(float) {
        DebugFPS.display(s2d);
    }
}

class JTile {

}

class JScene {

}

class Player {
}

class DebugFPS {
    static var fpsCounter : Text;
    static var time = 0.0;
    public static function display(s2d) {
        if (fpsCounter == null) {
            fpsCounter = new Text(hxd.res.DefaultFont.get(), s2d);
        }
        time += Timer.elapsedTime;
        fpsCounter.text = "\nFPS: " + Std.string(Timer.fps()).substr(0,5) + "\nTime Running: " + Std.string(Std.int(time)) + Std.string(time%1).substr(1,3);
    }
}
import haxe.Resource;
import h2d.Console;
import hxd.File;
import hxd.File.BrowseOptions;
import h2d.TileGroup.TileLayerContent;
import h2d.Text;
import h2d.RenderContext;
import hxd.Timer;
import h2d.Scene.ScaleMode;
import js.html.FontFaceSetLoadEvent;
import hxd.fmt.grd.Data;

using StringTools;

class Main extends hxd.App {
     var layer1:TileLayer;

     override function init() {

        var file = Resource.getString("map");
        var background = file.toString().trim();
        trace(background);
        trace("Hello");
        s2d.setFixedSize(512, 448); // SNES BAYBEE
        
        layer1 = new TileLayer(s2d, 32, 28);
        layer1.initMap(background);
        layer1.draw();
    }
    static function main() {
        new Main();
    }

    override function update(float) {



        DebugFPS.display(s2d);
    }
}

class TileLayer {
    var s2d:h2d.Scene;

    var width:Int;
    var height:Int;

    var grassColor = 0x232323;
    var plantHealthyColor = 0x08FF53;
    var plantWeedColor = 0xA07265;
    var plantDyingColor = 0xA09465;
    var plantDeadColor = 0x5D4A35;
    var blockColor = 0x009E3E;

    var tiles:Array<h2d.Tile>;

    public function new(scene, w, h) {
        s2d = scene;
        width = w;
        height = h;
        tiles = new Array();
        tiles.resize(width * height);
    }

    public function getWidth() { return width; }
    public function getHeight() { return height; }

    public function getTile(x, y) { return tiles[x + y * width]; }

    public function initMap(map:String) {
        var startClip = 0;
        for(j in 0...height) {
            var ma = map.substring(startClip, startClip + width);
            startClip += width + 1;
            var m = ma.split("");
            for(i in 0...width) {
                trace(m[1]);
                var color = 0;
                switch(m[i]) {
                    case "0": color = grassColor;
                    case "1": color = plantHealthyColor;
                    case "2": color = plantDyingColor;
                    case "3": color = plantDeadColor;
                    case "4": color = plantDeadColor;
                    case "5": color = plantDeadColor;
                    default: color = 0xFFFFFF;
                }
                tiles[i + j * width] = h2d.Tile.fromColor(color, 16, 16);
            }
        }
    }

    public function draw() {
        for(i in 0...this.getWidth()) {
            for(j in 0...this.getHeight()) {
                var bmp = new h2d.Bitmap(this.getTile(i, j), s2d);
                
                bmp.x = 0 + i * this.getTile(i, j).width;
                bmp.y = 0 + j * this.getTile(i, j).height;
            }
        }
    }
}

class JTile {

}

class JScene {

}

class Player {
}

class DebugFPS {
    static var fpsCounter:Text;
    static var time = 0.0;
    public static function display(s2d) {
        if (fpsCounter == null) {
            fpsCounter = new Text(hxd.res.DefaultFont.get(), s2d);
        }
        time += Timer.elapsedTime;
        fpsCounter.text = "\nFPS: " + Std.string(Timer.fps()).substr(0,5) + "\nTime Running: " + Std.string(Std.int(time)) + Std.string(time%1).substr(1,3);
    }
}
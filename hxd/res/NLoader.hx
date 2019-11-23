package hxd.res;

import h2d.Tile;
import h3d.mat.Texture;
import hxd.fs.FileSystem;

/**
 * A self-explanatory and probably somewhat superfluous class that makes resource management somewhat more intuitive.
 * A static instance of the NLoader is initialized by the `Game` object upon construction, and can be called on with `Game.loader`.
 */
class NLoader extends Loader
{
    public function new (fs:FileSystem) super(fs);

    public function loadImage (path:String) :Image return this.load(path).toImage();
    public function loadModel (path:String) :Model return this.load(path).toModel();
    public function loadPrefab (path:String) :Prefab return this.load(path).toPrefab();
    public function loadSound (path:String) :Sound return this.load(path).toSound();
    public function loadText (path:String) :String return this.load(path).toText();
    public function loadTexture (path:String) :Texture return this.load(path).toTexture();
    public function loadTile (path:String) :Tile return this.load(path).toTile();
}
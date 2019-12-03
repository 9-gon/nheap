package h2d;

import hxd.Stopwatch;
import hxd.Game;
import h2d.Object;

/**
 * The `GameScene` extends the `h2d.Scene` class in two major ways:
 * 1. It includes a reference both to the `Game` and also to the scene from which it was switched to.
 * 2. It monitors the amount of time that has been spent on itself specifically and keeps a list of `hxd.Stopwatch`s to handle timed events.
 */
class GameScene extends h2d.Scene
{
    var game:Game;
    var sceneFrom:GameScene;

    var layers:Map<String,GameSceneLayer>;

    var watches:Array<Stopwatch>;
    var elapsedTime:Float;

    public function new (?from:GameScene=null)
    {
        super();

        this.game = Game.instance;
        this.sceneFrom = from;

        this.layers = [];

        this.watches = new Array();

        this.elapsedTime = 0.;
    }

    /**
     * Changes the way the `GameScene` updates by forcing prioritization of input handling and data manipulation before drawing to screen. Should only be called in `hxd.Game.update()`.
     */
    public function frame (dt:Float) :Void
    {
        this._update(dt);
        this._render();
    }

    /**
     * The GameScene's drawing function. Should be overriden by every child.
     */
    public function _render () :Void
    {
        for (layer in 0...this.layerCount) if (this.getLayer(layer).hasNext()) cast(this.getLayer(layer).next(),GameSceneLayer).performGarbageCollection();
    }

    /**
     * The GameScene's updating function. Should be overriden by every child.
     * @param dt time since last frame
     */
    public function _update (dt:Float) :Void
    {
        this.elapsedTime += dt;

        var kill:Array<Stopwatch> = new Array();
        for (i in 0...this.watches.length)
        {
            var watch = this.watches[i];
            if (watch.isFulfilled()) kill.push(watch);
            else if (this.elapsedTime>=watch.getEndTime()) watch.fulfill();
        }
        for (k in kill) this.watches.remove(k);
    }

    /**
     * Adds a `GameSceneLayer` to the supplied index.
     */
    public function addLayerAt (name:String,index:Int) :Void
    {
        this.layers.set(name,new GameSceneLayer(index,this));
        this.add(this.layers[name],index);
    }

    public function getSceneLayer (name:String) :GameSceneLayer return this.layers[name];

    @:generic
    public function addToLayer <T> (obj:T,layerName:String) :T
    {
        if (Reflect.field(obj,"parent"))
        {
            cast(obj,Object).parent = this.layers[layerName];
            return obj;
        }
        return null;
    }

    /**
     * @return the total time, in seconds, that this GameScene has been active
     */
    public function getElapsedTime () :Float return this.elapsedTime;

    /**
     * Adds a new `hxd.Stopwatch` to the queue.
     * @param duration how long until the Stopwatch should perform its action
     * @param action the action to perform once the Stopwatch is ready
     */
    public function addStopwatch (duration:Float,action:Void->Void) :Void this.watches.push(new Stopwatch(this.elapsedTime,duration,action));

    /**
     * If this GameScene has reference to the scene it came from, returns to that GameScene.
     */
    public function previousScene () :Void if (null!=this.sceneFrom) this.game.setScene(this.sceneFrom,true);
}
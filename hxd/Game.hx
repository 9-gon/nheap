package hxd;

import hxd.evt.EventListener;
import h2d.GameScene;

/**
 * The `Game` class extends the `hxd.App` in two major ways:
 *  1. It provides support for a global list of `IEventListeners` for reference by any `EventDispatcher`.
 *  2. It allows independent GameScenes to inherently take on more of the frame-to-frame game logic.
 */
class Game extends hxd.App
{
    public static var instance:Game;

    var listeners:Map<String,IEventListener>;

    var currentScene:GameScene;

    public function new ()
    {
        super();
        instance = this;
    }

    override function init () :Void
    {
        super.init();
        this.listeners = new Map();
    }

    override function update (dt:Float) :Void
    {
        super.update(dt);

        this.currentScene.frame(dt);
    }

    /**
     * Adds a new key-value mapping to the global list of `IEventListener`s. If `key` already exists in this list, the function amends `key` until it is unique.
     * @return if key was amended, the amended key; else, null
     */
    public function addListener (key:String,listener:IEventListener) :Null<String>
    {
        var k = key;
        while (this.listeners.exists(k)) k += "_2";
        this.listeners.set(k,listener);
        return (k!=key) ? k : null;
    }
    
    /**
     * Returns the appropriate `IEventListener` if `key` has a mapping.  
     * Returns `null` if there is no such value mapped to `key`.
     */
    public function getListener (key:String) :IEventListener return (this.listeners.exists(key)) ? this.listeners.get(key) : null;

    /**
     * Returns a reference to all `IEventListener`s.
     */
    public function getListeners () :Map<String,IEventListener> return this.listeners;

    /**
     * Removes a listener for the global list of 'IEventListener`s.
     * @return `true` if listener is removed, `false` if there was some complication
     */
    public function removeListener (key:String) :Bool
    {
        if (this.listeners.exists(key))
        {
            this.listeners.remove(key);
            if (!this.listeners.exists(key)) return true;
        }
        return false;
    }

    /**
     * @param scene the `GameScene` to change to
     * @param dispose whether or not the previous state should be disposed of
     */
    public function changeScene (scene:GameScene,?dispose:Bool=true) :Void
    {
        if (0!=Reflect.compare(this.currentScene,scene))
        {
            this.currentScene = scene;
            this.setScene(this.currentScene,dispose);
        }
    }
}
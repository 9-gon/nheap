package h2d;

import hxd.evt.EventDispatcher;
import hxd.evt.EventListener;

class Entity
{
    var dispatcher:EventDispatcher;
    var drawObject:Object;

    function new ()
    {
        this.dispatcher = new EventDispatcher();
        this.drawObject = new Object();
    }

    public function addEventListener (listener:IEventListener,?priority:Int=0,?once:Bool=false) this.dispatcher.addListener(listener,priority,once);

    public function dispatch (event:String,?params:Dynamic) :Void this.dispatcher.dispatch(event,params);

    public function getDrawObject () :Object return this.drawObject;
}
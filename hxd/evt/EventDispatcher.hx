package hxd.evt;

import h2d.Entity;
import hxd.evt.EventListener;

typedef EventListener = { listener:IEventListener, once:Bool, priority:Int };

/**
 * The base dispatcher class. Most `Entities` in nheap should, by default, contain their own EventDispatcher.
 */
class EventDispatcher
{
    var listeners:Array<EventListener>;

    public function new () listeners = new Array();

    /**
     * Adds a listener to the list.
     * @param listener the event listener to add 
     * @param priority the priority of the listener, with 0 being the most urgent
     * @param once whether or not the listener should only be notified once
     */
    public function addListener (listener:IEventListener,?priority:Int=0,?once:Bool=false) :Void this.listeners.push({ listener: listener, priority: priority, once: once });
    
    /**
     * Removes the specified listener from the list.
     * @param listener the event listener to remove
     */
    public function removeListener (listener:IEventListener) :Void for (lis in this.listeners) { if (Reflect.compareMethods(lis.listener,listener)) this.listeners.remove(lis); return; }
    
    /**
     * Clears all listeners from the list.
     */
    public function clear () :Void this.listeners = new Array();

    /**
     * Dispatches an event across all listed listeners.
     * @param entity the relevant `Entity`
     * @param event the event to notify
     */
    public function dispatch (entity:Entity,event:EnumValue) :Void
    {
        this.sortListeners();
        var kill:Array<EventListener> = new Array();
        for (lis in this.listeners)
        {
            lis.listener.onNotify(entity,event);
            if (lis.once) kill.unshift(lis);
        }
        for (k in kill) this.listeners.remove(k);
    }

    function sortListeners () :Void
    {
        this.listeners.sort(
            function (a:EventListener,b:EventListener) :Int
            {
                if (a.priority>b.priority) return -1;
                else if (a.priority<b.priority) return 1;
                else return 0;
            }
        );
    }
}
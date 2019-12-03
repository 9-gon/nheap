package hxd.evt;

import h2d.Entity;

/**
 * The basic framework of an event listener.
 */
interface IEventListener
{
    /**
     * The function to call whenever an `EventDispatcher` polls this listener. It is recommended that the function body contain one switch-case statement which checks against the event.
     * @param event the kind of event to execute
     * @param params any and all pertinent parameters
     */
    public function onNotify (event:String,?params:Dynamic=null) :Void;   
}
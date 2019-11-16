package hxd.evt;

import h2d.Entity;

/**
 * The basic framework of an event listener.
 */
interface IEventListener
{
    /**
     * The function to call whenever an `EventDispatcher` polls this listener. It is recommended that the function body contain one switch-case statement which checks against the event.
     * @param entity the `Entity`, if any, to apply changes to
     * @param event the kind of event to execute
     */
    public function onNotify (entity:Null<Entity>,event:EnumValue) :Void;   
}
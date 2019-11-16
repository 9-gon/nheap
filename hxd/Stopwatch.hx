package hxd;

/**
 * A frame-by-frame timer object where, after the end time has been reached, the associated action is performed. Primarily applied in the `GameScene._update` function.
 */
class Stopwatch
{
    var end:Float;
    var fulfilled:Bool;

    var action:Void->Void;

    /**
     * Creates a new Stopwatch.
     * @param start the start time, in seconds
     * @param duration how long until the stopwatch goes off
     * @param action the action to perform
     */
    public function new (start:Float,duration:Float,action:Void->Void)
    {
        this.action = action;
        this.end = start + duration;
        this.fulfilled = false;
    }
    
    /**
     * Cancel the Stopwatch.
     */
    public function cancel () :Void this.fulfilled = true;

    /**
     * Performs the associated action, then confirms that it has been fulfilled.
     */
    public function fulfill () :Void
    {
        this.action();
        this.fulfilled = true;
    }

    public function getEndTime () :Float return this.end;
    public function isFulfilled () :Bool return this.fulfilled;
}
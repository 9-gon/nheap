package hxd;

class SDLPad extends Pad
{
    public function new () super();

    public function getInputName (input:Int) :String return Pad.CONFIG_SDL.names[input];
    public function getInputStatus (input:Int) :Float return this.values[input];
}
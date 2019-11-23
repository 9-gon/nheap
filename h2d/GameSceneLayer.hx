package h2d;

import h2d.Object;

class GameSceneLayer extends Object
{
    var layerIndex:Int;
    var scene:GameScene;

    var purge:Array<Class<Dynamic>>;

    public function new (index:Int,?parent:GameScene)
    {
        super(parent);

        this.layerIndex = index;
        this.scene = parent;

        this.purge =
        [
            h2d.Text,
            h2d.Graphics,
            h2d.Bitmap
        ];

        this.x = 0;
        this.y = 0;
    }

    /**
     * @return the index of this layer
     */
    public function getLayerIndex () :Int return this.layerIndex;

     /**
     * @return the `GameScene` this layer belongs to
     */
    public function getParentScene () :GameScene return this.scene;

    /**
     * Clears the layer of all children specified by `this.purge`.
     */
    public function performGarbageCollection () :Void
    {
        var i:Int = 0;
        while (i<this.numChildren)
        {
            var child = this.getChildAt(i);
            var childClass = Type.getClass(child);
            var purged = false;
            for (purgable in this.purge)
            {
                if (purgable==childClass)
                {
                    this.removeChild(child);
                    purged = true;
                    break;
                }
            }
            if (!purged) ++i;
        }
    }
}
/**
 * ##copyright##
 * See LICENSE.md
 *
 * @author    Maxime Damecour (http://nnvtn.ca)
 * @version   0.4
 * @since     2016-03-11
 */


 // ADD TRANSLATION LAYER

/**
 * Something that acts on a PGraphics.
 * Perhaps subclass features such as OSC, dedicated mouse device, slave mode...
 */


 class Layer {
   String name;
   PGraphics canvas;

   public Layer(){
     name = "basicLayer";
     canvas = null;
   }

   public void beginDrawing(){
     if(canvas != null){
       canvas.beginDraw();
       canvas.clear();
     }
   }

   public void endDrawing(){
     if(canvas != null) canvas.endDraw();
   }

   public PGraphics getCanvas(){
     return canvas;
   }

   public void setName(String _n){
     name = _n;
   }

   public String getName(){
     return name;
   }
 }

 class RenderLayer extends Layer{
   public RenderLayer(){
     canvas = createGraphics(width,height,P2D);
   }
 }
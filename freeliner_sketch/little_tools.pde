/**
 *
 * ##copyright##
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 *
 * @author              ##author##
 * @modified    ##date##
 * @version             ##version##
 */


int stringInt(String _str){
  try {
    return Integer.parseInt(_str);
  }
  catch (Exception e){
    //println("Bad number string");
    return -42;
  }
}

float stringFloat(String _str){
  try {
    return Float.parseFloat(_str);
  }
  catch (Exception e){
    //println("Bad number float");
    return -42.0;
  }
}

/**
 * Class to collect and average data
 */
class FloatSmoother {
  boolean firstValue;
  FloatList flts;
  int smoothSize;

  public FloatSmoother(int s, float f){
    firstValue = true;
    smoothSize = s;
    flts = new FloatList();
    fillArray(f);
  }

  public float addF(float s){
    if(firstValue){
      firstValue = false;
      fillArray(s);
    }
    flts.append(s);
    flts.remove(0);
    return arrayAverager();
  }

  private void fillArray(float f) {
    flts.clear();
    for(int i = 0; i < smoothSize; i++){
      flts.append(f);
    }
  }

  private float arrayAverager() {
    float sum = 0;
    for(int i = 0; i < smoothSize; i++){
      sum += flts.get(i);
    }
    return sum / smoothSize;
  }
}

/**
 * Method to manipulate values by increment or asbolute
 * if the new value is >= 0 it will simply return this.
 * otherwise if its -1 or -2 it will increment or decrement the original value
 * @param int new value
 * @param int value to modify
 * @return int modified value
 */
int numTweaker(int v, int n){
  if(v >= 0) return v;
  else if (v == -1) return n+1;
  else if (v == -2 && n-1>=0) return n-1;
  else return n;
}


/**
 * linear interpolation between two PVectors
 * @param PVector first vector
 * @param PVector second vector
 * @param float unit interval
 * @return PVector interpolated
 */
PVector vecLerp(PVector a, PVector b, float l){
  return new PVector(lerp(a.x, b.x, l), lerp(a.y, b.y, l), 0);
}

/**
 * linear interpolation between two PVectors
 * @param PGraphics to draw on
 * @param PVector first coordinate
 * @param PVector second coordinate
 */
void vecLine(PGraphics p, PVector a, PVector b){
  p.line(a.x,a.y,b.x,b.y);
}

/**
 * Polar to euclidean conversion
 * @param PVector center point
 * @param float angle
 * @param float distance
 * @return PVector euclidean of polar
 */
PVector angleMove(PVector p, float a, float s){
  PVector out = new PVector(cos(a)*s, sin(a)*s, 0);
  out.add(p);
  return out;
}

/**
 * Mirror PVector from the center
 * @param PVector position to mirror along the X axis
 * @return PVector mirrored position
 */
PVector vectorMirror(PVector p){
  float newX = 0;
  if(p.x < width/2) newX = width-p.x;
  else newX = -(p.x-width/2)+width/2;
  return new PVector(newX, p.y, p.z);
}


float fltMod(float f) {
  if (f>1) f-=1;
  else if (f<0) f+=1;
  return f;
}

//wrap around
static int wrap(int v, int n) {
  if (v<0) v = n;
  if (v>n) v = 0;
  return v;
}

boolean maybe(int _p){
  return random(100) < _p;
}

/**
 * PShape clone/resize/center, the centerPosition will translate everything making it 0,0
 * @param  source PShape
 * @param  scalar float
 * @param  centerPoint PVector
 * @return new PShape
 */

PShape cloneShape(PShape _source, float _scale, PVector _center){
  if(_source == null) return null;
  PShape shp = createShape();
  shp.beginShape(_source.getKind());
  shp.strokeJoin(FreelinerConfig.STROKE_JOIN);
  shp.strokeCap(FreelinerConfig.STROKE_CAP);
  PVector tmp = new PVector(0,0);
  PVector frst = new PVector(0,0);
  PVector last = new PVector(0,0);
  for(int i = 0; i < _source.getVertexCount(); i++){
    tmp = _source.getVertex(i);
    tmp.sub(_center);
    tmp.mult(_scale);
    if(i == 0) frst = tmp;
    else last = tmp;
    shp.vertex(tmp.x, tmp.y);
  }
  if(abs(frst.dist(last)) < 0.1) shp.endShape(CLOSE);
  else shp.endShape();
  //_source = null; // cleanup?
  return shp;
}

PShape cloneShape(PShape _source, float _scale){
  return cloneShape(_source, _scale, new PVector(0,0));
}

/**
 * PShape clone/resize/center, the centerPosition will translate everything making it 0,0
 * @param  String directory
 * @param String file extention
 * @return String[] fileNames
 */
// String[] parseDirectory(String _dir, String _ext){
//
// }

final int PALLETTE_COUNT = 12;
color[] userPallet = {
                 #ffff00,
                 #ffad10,
                 #ff0000,
                 #ff00ad,
                 #f700f7,
                 #ad00ff,
                 #0000ff,
                 #009cff,
                 #00c6ff,
                 #00deb5,
                 #a5ff00,
                 #f700f7,
               };

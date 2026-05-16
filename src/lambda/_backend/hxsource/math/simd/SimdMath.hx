package lambda._backend.hxsource.math.simd;

import lambda._backend.hxsource.ds.Vector;
import lambda._backend.hxsource.ds.SIMD4Float;
import lambda._backend.hxsource.ds.FourVectors;

class SimdMath {
    inline public static function setWZero(a:SIMD4Float):SIMD4Float return a.andBits(SimdConst.CLEAR_WMASK);
    inline public static function loadAligned3(v:Vector):SIMD4Float return setWZero(new SIMD4Float(v.x, v.y, v.z, 0));
    inline public static function isAllZero(a:SIMD4Float):Bool return a.subFloat(0) == 0 && a.subFloat(1) == 0 && a.subFloat(2) == 0 && a.subFloat(3) == 0;

    inline public static function cross3(a:FourVectors, b:FourVectors):FourVectors {
        var r:FourVectors = new FourVectors();
        r.x = a.y.mul(b.z).sub(a.z.mul(b.y));
        r.y = a.z.mul(b.x).sub(a.x.mul(b.z));
        r.z = a.x.mul(b.y).sub(a.y.mul(b.x));
        return r;
    }
}
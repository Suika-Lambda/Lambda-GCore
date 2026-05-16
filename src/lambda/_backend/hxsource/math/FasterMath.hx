package lambda._backend.hxsource.math;

import lambda._backend.hxsource.ds.SinCos;

class FasterMath {
    inline public static function sinCos(radians:Float):SinCos return {sine: CMath.sin(radians),cosine: CMath.cos(radians)};
    inline public static function fastRSqrt(x:Float):Float return CMath.rsqrt(x);
    inline public static function fastSqrt(x:Float):Float return CMath.sqrt(x);
    inline public static function fastCos(radians:Float):Float return CMath.cos(radians);

    // aka: sinCos
    inline public static function fastSinCos(radians:Float):SinCos return sinCos(radians);
    // aka: fastRSqrt
    inline public static function fastRSqrtFast(x:Float):Float return fastRSqrt(x);
}
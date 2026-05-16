package lambda._backend.hxsource.math;

import Math;

private typedef HalFloat = cpp.Float32;

@:cppFileCode('#include <cmath>')
class CMath {
    @:functionCode('return ::sin(x)')
    inline public static function sin(x:Float):Float return Math.sin(x);

    @:functionCode('return ::cos(x)')
    inline public static function cos(x:Float):Float return Math.cos(x);

    @:functionCode('return ::tan(x)')
    inline public static function tan(x:Float):Float return Math.tan(x);

    @:functionCode('return ::sqrt(x)')
    inline public static function sqrt(x:Float):Float return Math.sqrt(x);

    @:functionCode('return (1.0d / ::sqrt(x))')
    inline public static function rsqrt(x:Float):Float return 1/Math.sqrt(x);

    ///////// Float32 ///////////

    @:functionCode('return ::sinf(x)')
    inline public static function sinf(x:HalFloat):HalFloat return Math.sin(x);

    @:functionCode('return ::cosf(x)')
    inline public static function cosf(x:HalFloat):HalFloat return Math.cos(x);

    @:functionCode('return ::tanf(x)')
    inline public static function tanf(x:HalFloat):HalFloat return Math.tan(x);

    @:functionCode('return ::sqrtf(x)')
    inline public static function sqrtf(x:HalFloat):HalFloat return Math.sqrt(x);

    @:functionCode('return (1.0d / ::sqrtf(x))')
    inline public static function rsqrtf(x:HalFloat):HalFloat return 1/Math.sqrt(x);
}
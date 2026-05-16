package lambda._backend.hxsource.ds;

@:struct private class _CSIMD4Float {
    public var x:Float;
    public var y:Float;
    public var z:Float;
    public var w:Float;

    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 0.0) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }
}

@:forward(x,y,z,w) abstract SIMD4Float(_CSIMD4Float) from _CSIMD4Float to _CSIMD4Float {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 0.0) {
        this = new _CSIMD4Float(x, y, z, w);
    }

    public static var ZERO(default,never):SIMD4Float = new SIMD4Float(0,0,0,0);
    public static var ONE(default,never):SIMD4Float = new SIMD4Float(1,1,1,1);
    public static var EPSILON(default,never):SIMD4Float = new SIMD4Float(1e-10,1e-10,1e-10,1e-10);
    public static var CLEAR_WMASK(default,never):SIMD4Float = {var r:SIMD4Float = new SIMD4Float();r._setIntAt(0,-1);r._setIntAt(1,-1);r._setIntAt(2,-1);r._setIntAt(3,0);r;}
    public static var COMPONENT_MASK:Array<SIMD4Float> = [{var r:SIMD4Float = new SIMD4Float();r._setIntAt(0,-1);r._setIntAt(1,0);r._setIntAt(2,0);r._setIntAt(3,0);r;},{var r:SIMD4Float = new SIMD4Float();r._setIntAt(0,0);r._setIntAt(1,-1);r._setIntAt(2,0);r._setIntAt(3,0);r;},{var r:SIMD4Float = new SIMD4Float();r._setIntAt(0,0);r._setIntAt(1,0);r._setIntAt(2,-1);r._setIntAt(3,0);r;},{var r:SIMD4Float = new SIMD4Float();r._setIntAt(0,0);r._setIntAt(1,0);r._setIntAt(2,0);r._setIntAt(3,-1);r;}];

    @:from inline public static function fromFloats(arr:Array<Float>):SIMD4Float return new SIMD4Float(arr[0], arr[1], arr[2], arr[3]);
    @:from inline public static function fromFloat(f:Float):SIMD4Float return new SIMD4Float(f,f,f,f);

    @:arrayAccess inline public function getFloat(i:Int):Float {
        return switch(i) {
            case 0: this.x;
            case 1: this.y;
            case 2: this.z;
            case 3: this.w;
            default: throw "Index out of bounds";
        }
    }

    inline public function subFloat(i:Int):Float return getFloat(i);
    inline public function subInt(i:Int):Int return _intAt(i);

    @:op(A == B) inline public function cmpEq(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, (this.x == other.x) ? 0xFFFFFFFF : 0);
        r._setIntAt(1, (this.y == other.y) ? 0xFFFFFFFF : 0);
        r._setIntAt(2, (this.z == other.z) ? 0xFFFFFFFF : 0);
        r._setIntAt(3, (this.w == other.w) ? 0xFFFFFFFF : 0);
        return r;
    }
    @:op(A > B) inline public function cmpGt(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, (this.x > other.x) ? 0xFFFFFFFF : 0);
        r._setIntAt(1, (this.y > other.y) ? 0xFFFFFFFF : 0);
        r._setIntAt(2, (this.z > other.z) ? 0xFFFFFFFF : 0);
        r._setIntAt(3, (this.w > other.w) ? 0xFFFFFFFF : 0);
        return r;
    }
    @:op(A >= B) inline public function cmpGe(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, (this.x >= other.x) ? 0xFFFFFFFF : 0);
        r._setIntAt(1, (this.y >= other.y) ? 0xFFFFFFFF : 0);
        r._setIntAt(2, (this.z >= other.z) ? 0xFFFFFFFF : 0);
        r._setIntAt(3, (this.w >= other.w) ? 0xFFFFFFFF : 0);
        return r;
    }
    @:op(A < B) inline public function cmpLt(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, (this.x < other.x) ? 0xFFFFFFFF : 0);
        r._setIntAt(1, (this.y < other.y) ? 0xFFFFFFFF : 0);
        r._setIntAt(2, (this.z < other.z) ? 0xFFFFFFFF : 0);
        r._setIntAt(3, (this.w < other.w) ? 0xFFFFFFFF : 0);
        return r;
    }
    @:op(A <= B) inline public function cmpLe(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, (this.x <= other.x) ? 0xFFFFFFFF : 0);
        r._setIntAt(1, (this.y <= other.y) ? 0xFFFFFFFF : 0);
        r._setIntAt(2, (this.z <= other.z) ? 0xFFFFFFFF : 0);
        r._setIntAt(3, (this.w <= other.w) ? 0xFFFFFFFF : 0);
        return r;
    }

    @:op(A + B) inline public function add(other:SIMD4Float):SIMD4Float return new SIMD4Float(this.x + other.x, this.y + other.y, this.z + other.z, this.w + other.w);
    @:op(A - B) inline public function sub(other:SIMD4Float):SIMD4Float return new SIMD4Float(this.x - other.x, this.y - other.y, this.z - other.z, this.w - other.w);
    @:op(A * B) inline public function mul(other:SIMD4Float):SIMD4Float return new SIMD4Float(this.x * other.x, this.y * other.y, this.z * other.z, this.w * other.w);
    @:op(A / B) inline public function div(other:SIMD4Float):SIMD4Float return new SIMD4Float(this.x / other.x, this.y / other.y, this.z / other.z, this.w / other.w);
    @:op(-A) inline public function neg():SIMD4Float return new SIMD4Float(-this.x, -this.y, -this.z, -this.w);

    inline public function andBits(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, _intAt(0) & other._intAt(0));
        r._setIntAt(1, _intAt(1) & other._intAt(1));
        r._setIntAt(2, _intAt(2) & other._intAt(2));
        r._setIntAt(3, _intAt(3) & other._intAt(3));
        return r;
    }
    inline public function orBits(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, _intAt(0) | other._intAt(0));
        r._setIntAt(1, _intAt(1) | other._intAt(1));
        r._setIntAt(2, _intAt(2) | other._intAt(2));
        r._setIntAt(3, _intAt(3) | other._intAt(3));
        return r;
    }
    inline public function xorBits(other:SIMD4Float):SIMD4Float {
        var r = new SIMD4Float();
        r._setIntAt(0, _intAt(0) ^ other._intAt(0));
        r._setIntAt(1, _intAt(1) ^ other._intAt(1));
        r._setIntAt(2, _intAt(2) ^ other._intAt(2));
        r._setIntAt(3, _intAt(3) ^ other._intAt(3));
        return r;
    }
    inline public function andNotBits(other:SIMD4Float):SIMD4Float { // ~this & other
        var r = new SIMD4Float();
        r._setIntAt(0, (~_intAt(0)) & other._intAt(0));
        r._setIntAt(1, (~_intAt(1)) & other._intAt(1));
        r._setIntAt(2, (~_intAt(2)) & other._intAt(2));
        r._setIntAt(3, (~_intAt(3)) & other._intAt(3));
        return r;
    }

    inline public function select(mask:SIMD4Float, trueVal:SIMD4Float, falseVal:SIMD4Float):SIMD4Float return(mask.andBits(trueVal)).orBits(mask.andNotBits(falseVal));

    inline public function dot3(other:SIMD4Float):SIMD4Float {
        var dot:Float = this.x * other.x + this.y * other.y + this.z * other.z;
        return new SIMD4Float(dot, dot, dot, dot);
    }
    inline public function dot4(other:SIMD4Float):SIMD4Float {
        var dot:Float = this.x * other.x + this.y * other.y + this.z * other.z + this.w * other.w;
        return new SIMD4Float(dot, dot, dot, dot);
    }

    inline public function replicateX4():SIMD4Float return new SIMD4Float(this.x, this.x, this.x, this.x);

    inline function _intAt(i:Int):Int {
        #if cpp
        return untyped __cpp__('*(int32_t *)&{0}[{1}]', this, i);
        #else
        return Std.int(getFloat(i));
        #end
    }
    inline function _setIntAt(i:Int, v:Int):Void {
        #if cpp
        untyped __cpp__('*(int32_t *)&{0}[{1}] = {2}', this, i, v);
        #end
    }
}
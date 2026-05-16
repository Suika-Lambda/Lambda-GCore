package lambda._backend.hxsource.ds;

import Math; // Standrand math. Useful :D

@:struct private class _CVector {
    public var x:Float;
    public var y:Float;
    public var z:Float;

    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    inline public function _isFinite(f:Float):Bool return !Math.isNaN(f) && Math.isFinite(f);
    inline public function _floatAbs(f:Float):Float return f < 0 ? -f : f;
}

/**
 * From Source SDK 2013 MP Header File (src/public/mathlib/vector.h)
 * 
 * @see [Source header file (vector.h)](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/public/mathlib/vector.h)
 * @since HXSource-1.0.0a
 */
@:forward(x,y,z) abstract Vector(_CVector) from _CVector to _CVector {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0) {
        this = new _CVector(x, y, z);
    }

    @:arrayAccess inline public function get(i:Int):Float {
        return switch(i) {
            case 0: this.x;
            case 1: this.y;
            case 2: this.z;
            default: throw "Index out of bounds";
        }
    }

    @:arrayAccess inline public function set(i:Int, val:Float):Float {
        return switch(i) {
            case 0: this.x = val;
            case 1: this.y = val;
            case 2: this.z = val;
            default: throw "Index out of bounds";
        }
    }

    inline public function isValid():Bool return this._isFinite(this.x) && this._isFinite(this.y) && this._isFinite(this.z);
    inline public function zero():Void this.x = this.y = this.z = 0.0;

    inline public function random(minVal:Float, maxVal:Float):Void {
        this.x = minVal + Math.random() * (maxVal - minVal);
        this.y = minVal + Math.random() * (maxVal - minVal);
        this.z = minVal + Math.random() * (maxVal - minVal);
    }

    @:op(A + B) inline public function add(v:Vector):Vector return new Vector(this.x + v.x, this.y + v.y, this.z + v.z);
    @:op(A - B) inline public function subtract(v:Vector):Vector return new Vector(this.x - v.x, this.y - v.y, this.z - v.z);
    @:op(A * B) inline public function mul(v:Vector):Vector return new Vector(this.x * v.x, this.y * v.y, this.z * v.z);
    @:op(A / B) inline public function div(v:Vector):Vector return new Vector(this.x / v.x, this.y / v.y, this.z / v.z);
    @:op(A * B) @:commutative inline public function mulScalar(s:Float):Vector return new Vector(this.x * s, this.y * s, this.z * s);

    @:op(A / B) inline public function divScalar(s:Float):Vector {
        var inv:Float = 1.0 / s;
        return new Vector(this.x * inv, this.y * inv, this.z * inv);
    }

    @:op(A + B) inline public function addScalar(s:Float):Vector return new Vector(this.x + s, this.y + s, this.z + s);
	@:op(A - B) inline public function subScalar(s:Float):Vector return new Vector(this.x - s, this.y - s, this.z - s);
    @:op(-A) inline public function negate():Vector return new Vector(-this.x, -this.y, -this.z);

    inline public function addEq(v:Vector):Vector { this.x += v.x; this.y += v.y; this.z += v.z; return this; }
    inline public function subEq(v:Vector):Vector { this.x -= v.x; this.y -= v.y; this.z -= v.z; return this; }
    inline public function mulEq(v:Vector):Vector { this.x *= v.x; this.y *= v.y; this.z *= v.z; return this; }
    inline public function divEq(v:Vector):Vector { this.x /= v.x; this.y /= v.y; this.z /= v.z; return this; }
    inline public function mulScalarEq(s:Float):Vector { this.x *= s; this.y *= s; this.z *= s; return this; }
    inline public function divScalarEq(s:Float):Vector { var inv = 1.0 / s; this.x *= inv; this.y *= inv; this.z *= inv; return this; }
    inline public function addScalarEq(s:Float):Vector { this.x += s; this.y += s; this.z += s; return this; }
    inline public function subScalarEq(s:Float):Vector { this.x -= s; this.y -= s; this.z -= s; return this; }

    @:op(A == B) inline public function equals(v:Vector):Bool return this.x == v.x && this.y == v.y && this.z == v.z;
    @:op(A != B) inline public function notEquals(v:Vector):Bool return !equals(v);

    inline public function lengthSqr():Float return this.x * this.x + this.y * this.y + this.z * this.z;
    inline public function length():Float return Math.sqrt(lengthSqr());
    inline public function length2DSqr():Float return this.x * this.x + this.y * this.y;
    inline public function length2D():Float return Math.sqrt(length2DSqr());


    inline public function normalize():Float {
        var sqr = lengthSqr() + 1e-10;
        var inv = 1.0 / Math.sqrt(sqr);
        this.x *= inv;
        this.y *= inv;
        this.z *= inv;
        return sqr * inv;
    }
    inline public function normalized():Vector {
        var v = new Vector(this.x, this.y, this.z);
        v.normalize();
        return v;
    }

    inline public function distTo(v:Vector):Float return subtract(v).length();
    inline public function distToSqr(v:Vector):Float return subtract(v).lengthSqr();
    inline public function dot(v:Vector):Float return this.x * v.x + this.y * v.y + this.z * v.z;
    inline public function cross(v:Vector):Vector {
        return new Vector(
            this.y * v.z - this.z * v.y,
            this.z * v.x - this.x * v.z,
            this.x * v.y - this.y * v.x
        );
    }

    inline public function min(v:Vector):Vector return new Vector(Math.min(this.x, v.x), Math.min(this.y, v.y), Math.min(this.z, v.z));
    inline public function max(v:Vector):Vector return new Vector(Math.max(this.x, v.x), Math.max(this.y, v.y), Math.max(this.z, v.z));

    inline public function withinAABox(boxMin:Vector, boxMax:Vector):Bool {
        return this.x >= boxMin.x && this.x <= boxMax.x
            && this.y >= boxMin.y && this.y <= boxMax.y
            && this.z >= boxMin.z && this.z <= boxMax.z;
    }

    inline public function lerp(to:Vector, t:Float):Vector {
        return new Vector(
            this.x + (to.x - this.x) * t,
            this.y + (to.y - this.y) * t,
            this.z + (to.z - this.z) * t
        );
    }

    // MulAdd: this = a + b * scalar
    inline public function mulAdd(a:Vector, b:Vector, scalar:Float):Void {
        this.x = a.x + b.x * scalar;
        this.y = a.y + b.y * scalar;
        this.z = a.z + b.z * scalar;
    }

	@:from inline public static function fromFloat(f:Float):Vector return new Vector(f, f, f);
}
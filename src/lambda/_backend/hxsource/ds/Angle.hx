package lambda._backend.hxsource.ds;

import Math;

@:struct private class _CAngle {
    public var x:Float;
    public var y:Float;
    public var z:Float;

    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    inline public function _isFinite(f:Float):Bool return !Math.isNaN(f) && Math.isFinite(f);
}

@:forward(x, y, z) abstract Angle(_CAngle) from _CAngle to _CAngle {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0) {
        this = new _CAngle(x, y, z);
    }

    inline public function isValid():Bool return this._isFinite(this.x) && this._isFinite(this.y) && this._isFinite(this.z);
    inline public function zero():Void this.x = this.y = this.z = 0.0;

    @:op(A + B) inline public function add(v:Angle):Angle return new Angle(this.x + v.x, this.y + v.y, this.z + v.z);
    @:op(A - B) inline public function subtract(v:Angle):Angle return new Angle(this.x - v.x, this.y - v.y, this.z - v.z);
    @:op(A * B) @:commutative inline public function mulScalar(s:Float):Angle return new Angle(this.x * s, this.y * s, this.z * s);

    @:op(A / B) inline public function divScalar(s:Float):Angle {
        var inv:Float = 1/s;
        return new Angle(this.x * inv, this.y * inv, this.z * inv);
    }

    @:op(-A) inline public function negate():Angle return new Angle(-this.x,-this.y,-this.z);

    @:op(A == B) inline public function equals(v:Angle):Bool return this.x == v.x && this.y == v.y && this.z == v.z;
    @:op(A != B) inline public function notEquals(v:Angle):Bool return !equals(v);

    inline public function lengthSqr():Float return this.x * this.x + this.y * this.y + this.z * this.z;
    inline public function length():Float return Math.sqrt(lengthSqr());

    inline public function toAngularImpulse():Vector return new Vector(this.z, this.x, this.y);
    inline public static function fromAngularImpulse(imp:Vector):Angle return new Angle(imp.y,imp.z,imp.x);

    @:arrayAccess inline public function get(i:Int):Float {
        return switch(i) {
            case 0: this.x;
            case 1: this.y;
            case 2: this.z;
            default: throw "Index out of bounds";
        }
    }
}
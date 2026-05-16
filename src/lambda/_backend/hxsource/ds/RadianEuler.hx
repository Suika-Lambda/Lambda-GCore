package lambda._backend.hxsource.ds;

import Math;

@:struct private class _CRadianEuler {
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

@:forward(x, y, z) abstract RadianEuler(_CRadianEuler) from _CRadianEuler to _CRadianEuler {
    inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0) {
        this = new _CRadianEuler(x, y, z);
    }

    @:from inline public static function fromQAngle(q:Angle):RadianEuler {
        var d2r:Float = Math.PI/180.0;
        return new RadianEuler(q.z * d2r, q.x * d2r, q.y * d2r);
    }

    inline public function toQAngle():Angle {
        var r2d:Float = 180.0/Math.PI;
        return new Angle(this.y * r2d, this.z * r2d, this.x * r2d);
    }

    inline public function isValid():Bool return this._isFinite(this.x) && this._isFinite(this.y) && this._isFinite(this.z);
}
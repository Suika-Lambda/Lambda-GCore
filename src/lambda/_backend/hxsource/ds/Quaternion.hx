package lambda._backend.hxsource.ds;

import Math;

@:struct private class _CQuaternion {
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;

	inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 1.0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	inline public function _isFinite(f:Float):Bool return !Math.isNaN(f) && Math.isFinite(f);
}

@:forward(x, y, z, w) abstract Quaternion(_CQuaternion) from _CQuaternion to _CQuaternion {
	inline public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, w:Float = 1.0) {
		this = new _CQuaternion(x, y, z, w);
	}

	@:from inline public static function fromRadianEuler(angles:RadianEuler):Quaternion {
		var sx:Float = Math.sin(angles.x*0.5);
		var cx:Float = Math.cos(angles.x*0.5);
		var sy:Float = Math.sin(angles.y*0.5);
		var cy:Float = Math.cos(angles.y*0.5);
		var sz:Float = Math.sin(angles.z*0.5);
		var cz:Float = Math.cos(angles.z*0.5);
		return new Quaternion(
			sx * cy * cz - cx * sy * sz,
			cx * sy * cz + sx * cy * sz,
			cx * cy * sz - sx * sy * cz,
			cx * cy * cz + sx * sy * sz
		);
	}

	@:arrayAccess inline public function get(i:Int):Float {
		return switch(i) {
			case 0: this.x;
			case 1: this.y;
			case 2: this.z;
			case 3: this.w;
			default: throw "Index out of bounds";
		}
	}

	inline public function isValid():Bool {
		return this._isFinite(this.x) && this._isFinite(this.y)
			&& this._isFinite(this.z) && this._isFinite(this.w);
	}

	@:op(A == B) inline public function equals(q:Quaternion):Bool return this.x == q.x && this.y == q.y && this.z == q.z && this.w == q.w;
	@:op(A != B) inline public function notEquals(q:Quaternion):Bool return !equals(q);

	inline public function toRadianEuler():RadianEuler {
		var test:Float = this.x * this.y + this.z * this.w;
		var angles:RadianEuler = new RadianEuler();
		if(test > 0.499) {
			angles.x = 2 * Math.atan2(this.x, this.w);
			angles.y = Math.PI / 2;
			angles.z = 0;
		} else if(test < -0.499) {
			angles.x = -2 * Math.atan2(this.x, this.w);
			angles.y = -Math.PI / 2;
			angles.z = 0;
		} else {
			var sqx = this.x * this.x;
			var sqy = this.y * this.y;
			var sqz = this.z * this.z;
			angles.x = Math.atan2(2 * this.y * this.w - 2 * this.x * this.z, 1 - 2 * sqy - 2 * sqz);
			angles.y = Math.asin(2 * test);
			angles.z = Math.atan2(2 * this.x * this.w - 2 * this.y * this.z, 1 - 2 * sqx - 2 * sqz);
		}
		return angles;
	}

	inline public function toAngle():Angle return toRadianEuler().toQAngle();
	inline public static function fromAngle(qa:Angle):Quaternion return fromRadianEuler(qa);
}
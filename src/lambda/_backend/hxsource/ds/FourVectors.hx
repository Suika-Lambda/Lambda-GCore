package lambda._backend.hxsource.ds;

@:struct private class _CFourVectors {
    public var x:SIMD4Float;
    public var y:SIMD4Float;
    public var z:SIMD4Float;

    public function new(x:SIMD4Float = null,y:SIMD4Float = null,z:SIMD4Float = null) {
        this.x = (x == null) ? new SIMD4Float() : x;
        this.y = (y == null) ? new SIMD4Float() : y;
        this.z = (z == null) ? new SIMD4Float() : z;
    }
}

@:forward(x,y,z) abstract FourVectors(_CFourVectors) from _CFourVectors to _CFourVectors {
    inline public function new(x:SIMD4Float = null,y:SIMD4Float = null,z:SIMD4Float = null) {
        this = new _CFourVectors(x,y,z);
    }

    inline public static function fromVectors(a:Vector, b:Vector, c:Vector, d:Vector):FourVectors {
        var r = new FourVectors();
        r.x = new SIMD4Float(a.x, b.x, c.x, d.x);
        r.y = new SIMD4Float(a.y, b.y, c.y, d.y);
        r.z = new SIMD4Float(a.z, b.z, c.z, d.z);
        return r;
    }

    @:op(A + B) inline public function add(other:FourVectors):FourVectors return new FourVectors(this.x.add(other.x),this.y.add(other.y),this.z.add(other.z));
    @:op(A - B) inline public function sub(other:FourVectors):FourVectors return new FourVectors(this.x.sub(other.x),this.y.sub(other.y),this.z.sub(other.z));
    @:op(A * B) inline public function dot4(other:FourVectors):SIMD4Float return this.x.mul(other.x).add(this.y.mul(other.y)).add(this.z.mul(other.z));
    @:op(A * B) inline public function scale(scale:SIMD4Float):FourVectors return new FourVectors(this.x.mul(scale),this.y.mul(scale),this.z.mul(scale));

    inline public function vector(i:Int):Vector return new Vector(this.x.getFloat(i),this.y.getFloat(i),this.z.getFloat(i));
    inline public function lengthSqr():SIMD4Float return this.x.mul(this.x).add(this.y.mul(this.y)).add(this.z.mul(this.z));
    inline public function vProduct(other:FourVectors):Void {
        this.x = this.x.mul(other.x);
        this.y = this.y.mul(other.y);
        this.z = this.z.mul(other.z);
    }
}
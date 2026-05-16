package lambda._backend.hxsource.ds.light;

@:struct private class _CLightDesc {
    public var type:LightTypes;
    public var color:Vector;
    public var position:Vector;
    public var direction:Vector;
    public var range:Float;
    public var falloff:Float;
    public var attenuation0:Float;
    public var attenuation1:Float;
    public var attenuation2:Float;
    public var theta:Float;
    public var phi:Float;

    public var thetaDot:Float;
    public var phiDot:Float;
    public var flags:Int;

    // these should be "Protected" members, but....
    public var oneOverThetaDotMinusPhiDot:Float;
    public var rangeSquared:Float;

    inline public function new() {
        type = LightTypes.MATERIAL_LIGHT_DISABLE;
        color = new Vector();
        position = new Vector();
        direction = new Vector();
        range = 0.0;
        falloff = 0.0;
        attenuation0 = 1.0;
        attenuation1 = 0.0;
        attenuation2 = 0.0;
        theta = 0.0;
        phi = 0.0;
        thetaDot = 1.0;
        phiDot = 0.0;
        flags = 0;
        oneOverThetaDotMinusPhiDot = 1.0;
        rangeSquared = 0.0;
    }
}

abstract LightDescription(_CLightDesc) from _CLightDesc to _CLightDesc {
    inline public function new() this = new _CLightDesc();

    @:from inline public static function fromPoint(pos:Vector, color:Vector):LightDesc {
        var desc:LightDesc = new LightDesc();
        desc.initPoint(pos, color);
        return desc;
    }


    @:from inline public static function fromSpot(pos:Vector, color:Vector, pointAt:Vector, innerCone:Float, outerCone:Float):LightDesc {
        var desc:LightDesc = new LightDesc();
        desc.initSpot(pos, color, pointAt, innerCone, outerCone);
        return desc;
    }

    inline public function initPoint(pos:Vector, col:Vector):Void {
        this.type = LightTypes.MATERIAL_LIGHT_POINT;
        this.color = col;
        this.position = pos;
        this.direction = new Vector(0,0,1); // default direction
        this.range = 0.0; // unlimited
        this.falloff = 0.0;
        this.attenuation0 = 1.0;
        this.attenuation1 = 0.0;
        this.attenuation2 = 0.0;
        this.theta = 0.0;
        this.phi = 0.0;
        recalculateDerivedValues();
    }

    inline public function initDirectional(dir:Vector, col:Vector):Void {
        this.type = LightTypes.MATERIAL_LIGHT_DIRECTIONAL;
        this.color = col;
        this.direction = dir.normalized();
        this.position = new Vector(); // no position needed
        this.range = 0.0; // unlimited
        this.falloff = 0.0;
        this.attenuation0 = 1.0;
        this.attenuation1 = 0.0;
        this.attenuation2 = 0.0;
        this.theta = 0.0;
        this.phi = 0.0;
        recalculateDerivedValues();
    }

    inline public function initSpot(pos:Vector, col:Vector, pointAt:Vector, innerCone:Float, outerCone:Float):Void {
        this.type = LightTypes.MATERIAL_LIGHT_SPOT;
        this.color = col;
        this.position = pos;
        this.direction = (pointAt - pos).normalized();
        this.range = 0.0; // unlimited
        this.falloff = 0.0;
        this.attenuation0 = 1.0;
        this.attenuation1 = 0.0;
        this.attenuation2 = 0.0;
        this.theta = innerCone;
        this.phi = outerCone;
        recalculateDerivedValues();
    }

    inline public function recalculateDerivedValues():Void {
        if (this.type == Spot) {
            this.thetaDot = Math.cos(this.theta);
            this.phiDot = Math.cos(this.phi);
            var denom = this.thetaDot - this.phiDot;
            if (Math.abs(denom) > 1e-10) {
                this.oneOverThetaDotMinusPhiDot = 1.0 / denom;
            } else {
                this.oneOverThetaDotMinusPhiDot = 1.0; // Avoid zero
            }
        } else {
            this.thetaDot = 1.0;
            this.phiDot = 0.0;
            this.oneOverThetaDotMinusPhiDot = 1.0;
        }

        this.rangeSquared = this.range * this.range;
    }

    inline public function isDirectionWithinLightCone(rdir:Vector):Bool {
        if(this.type != Spot) return true;
        return rdir.dot(this.direction) >= this.phiDot;
    }

    inline public function setupOldStyleAttenuation(quadratic:Float, linear:Float, constant:Float):Void {
        this.attenuation2 = quadratic;
        this.attenuation1 = linear;
        this.attenuation0 = constant;
    }

    inline public function setupNewStyleAttenuation(fiftyPercentDist:Float,zeroPercentDist:Float):Void {
        if (fiftyPercentDist <= 0 || zeroPercentDist <= 0) {
            this.attenuation0 = 1.0;
            this.attenuation1 = 0.0;
            this.attenuation2 = 0.0;
            return;
        }

        var invDiff:Float = 1.0 / (zeroPercentDist - fiftyPercentDist);
        this.attenuation0 = 1.0;
        this.attenuation1 = 2.0 * fiftyPercentDist * invDiff;
        this.attenuation2 = invDiff;
    }
}
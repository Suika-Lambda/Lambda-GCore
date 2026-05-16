package lambda._backend.hxsource.ds.light;

enum abstract LightType_OptimizationFlags(cpp.Int8) from cpp.Int8 to cpp.Int8 {
    final LIGHTTYPE_OPTIMIZATIONFLAGS_HAS_ATTENUATION0      = 1;
    final LIGHTTYPE_OPTIMIZATIONFLAGS_HAS_ATTENUATION1      = 2;
    final LIGHTTYPE_OPTIMIZATIONFLAGS_HAS_ATTENUATION2      = 4;
    final LIGHTTYPE_OPTIMIZATIONFLAGS_DERIVED_VALUES_CALCED = 8;
}
package lambda._backend.hxsource.ds.light;

enum abstract LightTypes(cpp.Int8) from cpp.Int8 to cpp.Int8 {
	final MATERIAL_LIGHT_DISABLE 	 = 0;
	final MATERIAL_LIGHT_POINT 		 = 1;
	final MATERIAL_LIGHT_DIRECTIONAL = 2;
	final MATERIAL_LIGHT_SPOT 		 = 3;
}
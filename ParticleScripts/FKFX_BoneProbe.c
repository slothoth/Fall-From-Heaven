// FKFX_BoneProbe: test effect for the sand lion. Attach to a bone attachment point.
//   white dot = attachment point origin, red/green/blue = its local +X/+Y/+Z (exported in local coords)
//   yellow trail = world-space particles (stored with Apply, exported with ApplyInverse, the Firaxis convention)
// If the coloured dots stay glued to the bone and turn with it: attached FX follow bones, POSITION is root-local.
// If they look tiny in game (the lion is modelled small and scaled x10), set PROBE_SCALE to 10.
#include "Math.FXH"
#include "Transform.FXH"

#define PROBE_LEN 3.0
#define PROBE_SIZE 1.5
#define PROBE_SCALE 1.0

emitter FKFX_BoneProbe_O
{
	varying number p_age;
	SPAWN(number in_time = 0)
	{
		p_age = 0;
	}
	SIM
	{
		p_age = p_age + delta_time() * 5.0;	// 0.2 s life, re-emitted continuously
		kill(p_age > 1);
	}
	property geometry_type = quad_rotated;
	property blend_type = alpha;
	property material_lighting = none;
	RENDER
	{
		// exported straight in LOCAL coordinates: if POSITION is root-local these ride on the bone
		export("POSITION", float3(0, 0, 0) * PROBE_LEN * PROBE_SCALE);
		export("SCALE", point2d(PROBE_SIZE * PROBE_SCALE, PROBE_SIZE * PROBE_SCALE));
		export("ROTATION", 0);
		export("COLOR", float3(1, 1, 1));
		export("ALPHA", 1);
		export("BASECOLOR_UV", float4(0, 0, 1, 1));
	}
}

emitter FKFX_BoneProbe_X
{
	varying number p_age;
	SPAWN(number in_time = 0)
	{
		p_age = 0;
	}
	SIM
	{
		p_age = p_age + delta_time() * 5.0;	// 0.2 s life, re-emitted continuously
		kill(p_age > 1);
	}
	property geometry_type = quad_rotated;
	property blend_type = alpha;
	property material_lighting = none;
	RENDER
	{
		// exported straight in LOCAL coordinates: if POSITION is root-local these ride on the bone
		export("POSITION", float3(1, 0, 0) * PROBE_LEN * PROBE_SCALE);
		export("SCALE", point2d(PROBE_SIZE * PROBE_SCALE, PROBE_SIZE * PROBE_SCALE));
		export("ROTATION", 0);
		export("COLOR", float3(1, 0.1, 0.1));
		export("ALPHA", 1);
		export("BASECOLOR_UV", float4(0, 0, 1, 1));
	}
}

emitter FKFX_BoneProbe_Y
{
	varying number p_age;
	SPAWN(number in_time = 0)
	{
		p_age = 0;
	}
	SIM
	{
		p_age = p_age + delta_time() * 5.0;	// 0.2 s life, re-emitted continuously
		kill(p_age > 1);
	}
	property geometry_type = quad_rotated;
	property blend_type = alpha;
	property material_lighting = none;
	RENDER
	{
		// exported straight in LOCAL coordinates: if POSITION is root-local these ride on the bone
		export("POSITION", float3(0, 1, 0) * PROBE_LEN * PROBE_SCALE);
		export("SCALE", point2d(PROBE_SIZE * PROBE_SCALE, PROBE_SIZE * PROBE_SCALE));
		export("ROTATION", 0);
		export("COLOR", float3(0.1, 1, 0.1));
		export("ALPHA", 1);
		export("BASECOLOR_UV", float4(0, 0, 1, 1));
	}
}

emitter FKFX_BoneProbe_Z
{
	varying number p_age;
	SPAWN(number in_time = 0)
	{
		p_age = 0;
	}
	SIM
	{
		p_age = p_age + delta_time() * 5.0;	// 0.2 s life, re-emitted continuously
		kill(p_age > 1);
	}
	property geometry_type = quad_rotated;
	property blend_type = alpha;
	property material_lighting = none;
	RENDER
	{
		// exported straight in LOCAL coordinates: if POSITION is root-local these ride on the bone
		export("POSITION", float3(0, 0, 1) * PROBE_LEN * PROBE_SCALE);
		export("SCALE", point2d(PROBE_SIZE * PROBE_SCALE, PROBE_SIZE * PROBE_SCALE));
		export("ROTATION", 0);
		export("COLOR", float3(0.2, 0.4, 1));
		export("ALPHA", 1);
		export("BASECOLOR_UV", float4(0, 0, 1, 1));
	}
}

emitter FKFX_BoneProbe_Trail
{
	varying float3 p_position;
	varying number p_age;
	SPAWN(number in_time = 0)
	{
		p_age = 0;
		p_position = Apply(root_rotation(), root_scale(), root_position(), float3(0, 0, 0));	// world position at birth
	}
	SIM
	{
		p_age = p_age + delta_time() * 0.7;	// ~1.4 s life
		kill(p_age > 1);
	}
	property geometry_type = quad_rotated;
	property blend_type = alpha;
	property material_lighting = none;
	RENDER
	{
		export("POSITION", ApplyInverse(root_rotation(), root_scale(), root_position(), p_position));
		export("SCALE", point2d(PROBE_SIZE * 0.6 * PROBE_SCALE, PROBE_SIZE * 0.6 * PROBE_SCALE));
		export("ROTATION", 0);
		export("COLOR", float3(1, 0.85, 0.1) * (1 - p_age));
		export("ALPHA", 1 - p_age);
		export("BASECOLOR_UV", float4(0, 0, 1, 1));
	}
}

group FKFX_BoneProbe
{
	varying number p_time;
	SPAWN
	{
		p_time = 0;
	}
	SIM
	{
		p_time = p_time + delta_time();
		emit_rate("FKFX_BoneProbe_O", 30) { export("in_time", p_time); };
		emit_rate("FKFX_BoneProbe_X", 30) { export("in_time", p_time); };
		emit_rate("FKFX_BoneProbe_Y", 30) { export("in_time", p_time); };
		emit_rate("FKFX_BoneProbe_Z", 30) { export("in_time", p_time); };
		emit_rate("FKFX_BoneProbe_Trail", 25) { export("in_time", p_time); };
	}
}

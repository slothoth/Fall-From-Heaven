#include "Sampling.FXH"
#include "Flipbook.FXH"
#include "EulerRotations.FXH"
#include "Tweening.FXH"
#include "Transform.FXH"
#include "Math.FXH"
#include "Noise.FXH"

#define Z_OFFSET 28.5
#define MINIMUM_SIZE_FACTOR 0.0015

emitter FX_Volcano_Smoke
{
	varying point3d p_position;
	varying point3d p_velocity;
	varying color p_color;
    varying number p_alpha;
	varying number p_age;
    varying number p_time;
	varying number p_inv_lifetime;
	varying number p_size;
    varying number p_final_size;
	varying number p_rotation;
	varying number p_rotation_speed;
	varying number p_rotation_drag;
	varying number p_drag;
    varying number p_scroll_speed;


	SPAWN(
        float3 in_spawn_position = float3(0,0,0),
        number in_spawn_radius,
        number in_initial_speed,
        number in_cone_angle,
        number in_rotation,
        number in_rotation_speed,
        number in_rotation_drag,
        number in_initial_angle,
        number in_drag,
        number in_lifetime,
        number in_size,
        color in_color,
        number in_alpha,
        number in_scroll_speed = 0.25
        )
	{

		p_drag = -in_drag;
		p_color = in_color;
        p_alpha = in_alpha;
		p_rotation = mix( -in_rotation, in_rotation, random() );
		p_rotation_drag = in_rotation_drag;
		// Box Volume Emission
		// Spawn position occurrs within a volume, with velocity pointing up plus a cone volume of angle variance
        local number height_randomizer = SMOOTHSTOP2(random());
		local number spawn_x = in_spawn_radius * 1.5;
		local number spawn_y = in_spawn_radius * 1.5;
		local number spawn_z = in_spawn_radius * 1.5;
		p_position = point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( 0, spawn_z, random() )) * height_randomizer;
		p_position = p_position + in_spawn_position;
        // Velocity
        //local number height_randomizer = random();
		local number initial_velocity_magnitude = in_initial_speed * height_randomizer;

		local number cone_radius = 0.5 * in_cone_angle * (height_randomizer);//max (0,(height_randomizer - .5) * 2);	// goes from 0 to 180

        p_velocity = SampleUnitSphere( 1 - SMOOTHSTART4(random()) * cone_radius / 180, random() * 2 * PI )  * initial_velocity_magnitude;
		p_rotation_speed = mix( -in_rotation_speed, in_rotation_speed, random()) * 2; // Need to convert this so that it has reasonable units, like degrees per second

		p_inv_lifetime = 1.0 / (mix(0.75,1,height_randomizer)*in_lifetime);
		p_age = 0.0;
        p_final_size = in_size * (SMOOTHSTOP4(height_randomizer) * .75) + (3 * height_randomizer);
		p_size = in_size * .15;

		p_time = random() * 100;
        p_scroll_speed = in_scroll_speed * (1 + random() * 0.25) * .5;
	}

	SIM
	{
		local float3 drag_force = p_velocity * p_drag; // Not sure how Fork does drag, but this works
        local float3 wind_force = float3(.35,0.2,0.1);
		local point3d p_total_force = drag_force + wind_force; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time();
		p_position = p_position + p_velocity * delta_time();

		p_rotation = p_rotation + p_rotation_speed * delta_time() - p_rotation_drag * p_rotation_speed * delta_time();
		local number time_multiplier = (is_orphan() > 0)? 10: 1;
		//Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime * time_multiplier;
        p_time = p_time + delta_time() * (1-p_age);
		kill(p_age > 1);
	}

	property geometry_type = quad_rotated;
	property material_type = quad_unlit;
	property blend_type = alpha;
    property material_lighting = directional;
    property normalmap = true;
    property masked = true;
    property priority = 15;
    //property layer = opaque;

	RENDER
    {
		//export( "BASECOLOR_UV",  1 * float4(0,0,1,1) + float4(p_time, 0,p_time, 0) * p_scroll_speed );

        export( "BASECOLOR_UV",  NumberToFlipbookUV(float2(16,16), p_time * p_scroll_speed * 0.5) );
        export( "BASECOLOR_UV_ROTATE", p_time * 0.25);
        export( "MASK_UV", NumberToFlipbookUV(float2(8,8), -p_time * 0.35) );
        export( "MASK_UV_ROTATE",  0 );
		local number p_size_out = mix(p_size,p_final_size, SMOOTHSTOP2(p_age));
		export( "SCALE", point2d(p_size_out, p_size_out));
		export( "ROTATION", p_rotation);
		export( "POSITION", p_position);
        export( "TANGENT", p_velocity);
		local number out_alpha = SMOOTHSTOPARCH4(p_age) * p_alpha;
        local number red_light = max(SMOOTHSTART5(1-p_age),0) * 0.05;
		export( "COLOR", float3(p_color.r + red_light,p_color.g,p_color.b) * out_alpha * (1-p_age));
		export( "ALPHA",  out_alpha);
    }
}

group VolcanoSpew
{
	varying number p_time;
    SPAWN
    {
		//noCode
		p_time = floor(hash(instance_id()) * 100.125); // slight time offset between each instance

        emit_count("FX_Volcano_Smoke", 50)
		{
			export("in_spawn_position", float3(0,0,Z_OFFSET) );
			export("in_spawn_radius", 2 );
			export("in_initial_speed", 18.6 );
			export("in_initial_angle", 0 );
			export("in_rotation", 0);
			export("in_rotation_speed", 0.15);
			export("in_rotation_drag", 0.2);
			export("in_drag", 0.7);
			export("in_size", 11);
            export("in_color", color(0.045,.040,.040) );
            export("in_alpha", 1 );
			export("in_cone_angle", 26);
			export("in_lifetime", 10);
            export("in_scroll_speed", 0.5);
		};
    }

	SIM
	{

		p_time = p_time + delta_time();
        local float3 root_position = root_position();
		local float root_scale = root_scale();
        local float3 world_pos = Apply(root_scale, root_position, float3(0,0,0));
        local float2 v2FOW = sample_fow( world_pos.xy );
        local number emit_multiplier = (v2FOW.y < .5)? 0:1;

        emit_rate("FX_Volcano_Smoke", 6)
		{
            export("in_spawn_position", float3(0,0,Z_OFFSET) );
			export("in_spawn_radius", 5 );
			export("in_initial_speed", 12.6 );
			export("in_initial_angle", 0 );
			export("in_rotation", 0);
			export("in_rotation_speed", 0.15);
			export("in_rotation_drag", 0.3);
			export("in_drag", 0.4);
			export("in_size", 11);
            export("in_color", color(0.025,.025,.025) );
            export("in_alpha", 1 );
			export("in_cone_angle", 15);
			export("in_lifetime", 25);
		};
	}
}

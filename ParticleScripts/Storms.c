#include "Noise.FXH"
#include "EulerRotations.FXH"
#include "Spline.FXH"
#include "Sampling.FXH"
#include "Math.FXH"
#include "Tweening.FXH"
#include "Transform.FXH"
#include "Flipbook.FXH"

emitter FX_CloudTrails
{
	varying point3d p_position;
    varying float p_rotation;
	varying point3d p_previous_root;
	varying point3d p_in_pos;
    //varying point3d p_initial_tangent;
    //varying point3d p_initial_bitangent;
	varying number p_age;
    varying number p_time;
    varying number p_path_time;
	varying number p_inv_lifetime;
    varying number p_spin_speed;
    varying number p_UV_Offset;
    varying number p_cloud_scale;
    varying	color p_color;
    varying	number p_alpha;
    varying number p_rain_amount;
    varying number p_centripetal_force;

	SPAWN(  point3d in_pos,
            float in_time,
            float in_size,
            float in_cloud_size,
            float in_twist_amount,
            float in_spin_speed,
            float in_spin_speed_variation = 0,
            float in_centripetal_force = 0,
            float in_tip_divergence,
            float in_center_radius = 30,
            color in_color = color(1,1,1),
            float in_alpha = 1,
            float in_rain_amount = 1
            )
	{
        p_centripetal_force = in_centripetal_force;
        local number randomValue = (random() * 2 * PI);
        local float center_radius = in_center_radius;
        local float2 startPos = SampleUnitCircle(0) * (5 * random() + center_radius ) ;
		p_position = float3(startPos.x, startPos.y, random() * in_tip_divergence) ;
		p_in_pos = in_pos;
        p_previous_root = root_position();
		// Velocity

		local number lifetime = mix( 8,10, random() );

		p_inv_lifetime = 1.0 / lifetime;
		p_age = 0.0;

        p_path_time = SMOOTHSTOP2(random());
        local float vortex_size = in_size;
        p_cloud_scale = in_cloud_size;
        p_spin_speed = in_spin_speed + in_spin_speed_variation * (random());

        p_position.y = p_path_time * vortex_size;

        p_position.x = -p_path_time * p_path_time * vortex_size;
        p_position = p_position + float3(startPos.x, startPos.y, 0);
        local float random_orientation = floor(random() * 9);

        p_position = EulerRotateVectorZ (p_position, random_orientation - in_time * (p_spin_speed) - in_twist_amount *( 1 - (p_path_time ) )) ;
        //local float3 normalized_position =  normalize(p_position);
        //p_initial_bitangent = float3(normalized_position.x,normalized_position.y,0);
        //p_initial_tangent = EulerRotateVectorZ (p_initial_bitangent, PI * -0.5);
        local number spawn_x = 5;
		local number spawn_y = 5;
        local number spawn_z = 5;
		p_position = p_position + point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( -spawn_z/2, spawn_z/2, random() ));
        p_time = 0;
        p_rotation = random() * PI * 2;
        p_UV_Offset = mix(0,1, random());
        p_color = in_color;
        p_alpha = in_alpha;
        p_rain_amount = in_rain_amount;
	}

	SIM
	{

        local float3 world_pos = Apply(root_scale(), root_position(), p_position + p_in_pos);
        local float2 v2FOW = sample_fow( world_pos.xy );
        local number scale_multiply = SMOOTHSTOP3(v2FOW.y);
        local number speed_increase = length(p_previous_root - root_position()) * 6;
        local number delta_time = delta_time() * (1 + speed_increase);
        p_time = p_time + delta_time();
        p_position = EulerRotateVectorZ (p_position, -delta_time * (p_spin_speed) * ( 1 - (p_path_time * 0.0))) * (1 - p_centripetal_force);

		//Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime * (1 + is_orphan() * 2);
		kill(p_age > 1);

        local float p_quality = import( float, "FireFXQuality");
		emit_rate("Rain_Particles", 10.f  * ARCH2(p_path_time) * p_rain_amount * scale_multiply * (1-p_quality))
		{
			export("in_pos", p_position);
		};

        p_time = p_time + delta_time;
        p_previous_root = root_position();
        local float3 normalized_position =  normalize(p_position);
        local float3 p_initial_bitangent = float3(normalized_position.x,normalized_position.y,0);
        local float3 p_initial_tangent = EulerRotateVectorZ (p_initial_bitangent, PI * -0.5);

	}

	property geometry_type = quad_fixed;
	property material_type = quad_unlit;
	property blend_type = alpha;
	property priority = 10;
    property material_lighting = directional;
    property normalmap = true;
    property masked = true;


	RENDER
    {
        local number alpha = 0.45 * ARCH2(p_age) * ARCH2(p_path_time) * scale_multiply;
        local number p_UVX_Rate = 0.05;
		local number offset = p_time * p_UVX_Rate + p_UV_Offset;
        export( "BASECOLOR_UV", float4(0, 0,1,1 ) + float4(-offset, offset * .5, -offset, offset * .5));
        export( "NORMALMAP_UV", float4(0, 0, 1,1 ) );
        export( "MASK_UV", float4(0, 0, 1,1 ) );

		//local number p_size_mult = EvalSpline_TraiWidth( p_age );

		export( "SCALE", point2d(p_cloud_scale * (1+ p_path_time),p_cloud_scale) * ARCH2(p_path_time) * scale_multiply);
		//export( "DIRECTION", p_position - previous_position);

		export( "ROTATION", 0 );
		// Offset poisition by bone position here when that becomes a thing
        export( "POSITION", p_position + p_in_pos);
        export( "TANGENT", p_initial_tangent );
        export( "BITANGENT", p_initial_bitangent );
        local float color_multiplier = mix(.5,.6,p_path_time);
		export( "COLOR", p_color * color_multiplier * alpha * p_alpha);

		export( "ALPHA", p_alpha * alpha);
    }
}

emitter FX_CloudTrails_Center
{
	varying point3d p_position;
    varying point3d p_previous_root;
    varying float p_rotation;
	varying point3d p_acceleration;
	varying point3d p_velocity;
	varying point3d p_in_pos;
    varying point3d p_initial_tangent;
    varying number p_lighting_duration;
    varying number p_lighting_age;
    varying number p_time_to_lightning;
    //varying point3d p_initial_bitangent;
	varying number p_age;
    varying number p_time;
    varying number p_path_time;
	varying number p_inv_lifetime;
    varying number p_spin_speed;
    varying number p_UV_Offset;
    varying number p_cloud_scale;

	SPAWN(  point3d in_pos,
            float in_time,
            float in_size)
	{
        local number randomValue = (random() * 2 * PI);
        local float center_radius = 30;
        p_path_time = (random()) * 0.4;
        local float2 startPos = SampleUnitCircle(0) * (5 * random() + center_radius ) ;
		p_position = float3(startPos.x, startPos.y, random() * -20 * (1- p_path_time)) ;
		p_position = p_position + in_pos;

		// Velocity
		local number lifetime = mix( 1, 2, random() );
        //lifetime = lifetime * 0.5;
		p_inv_lifetime = 1.0 / lifetime;
		p_age = 0.0;

		//p_size = mix( 5, 10, random() );
		p_spin_speed = 0.0751;


        local float vortex_size = in_size;
        p_cloud_scale = 20;

        p_position.y = p_path_time * vortex_size;

        p_position.x = -p_path_time * p_path_time * vortex_size;
        p_position = p_position + float3(startPos.x, startPos.y, 0);
        local float random_orientation = floor(random() * 9);
        p_position = EulerRotateVectorZ (p_position, random_orientation- in_time * p_spin_speed - 5*( 1 - (p_path_time ) )) ;
        p_initial_tangent = EulerRotateVectorZ (float3(1,0,0), random_orientation - in_time * p_spin_speed - 5*( 1 - (p_path_time ) ));
        //p_initial_bitangent = EulerRotateVectorZ (p_initial_tangent, PI *.5);
        local number spawn_x = 5;
		local number spawn_y = 5;
        local number spawn_z = 5;
		p_position = p_position + point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( -spawn_z/2, spawn_z/2, random() ));
        p_time = 0;
        p_rotation = random() * PI * 2;
        p_UV_Offset = mix(0,1, random());
        p_time_to_lightning = random() * 105 + 2;
        p_lighting_duration = mix( .2, .5, random() );
        p_lighting_age = 0;
        p_previous_root = root_position();
	}

	SIM
	{
        local float3 world_pos = Apply(root_scale(), root_position(), p_position);
        local float2 v2FOW = sample_fow( world_pos.xy );
        local number scale_multiply = SMOOTHSTOP3(v2FOW.y);
        local number speed_increase = length(p_previous_root - root_position()) * 6;
        local number delta_time = delta_time() * (1 + speed_increase);

        local point3d p_orbit_force = Cross(float3(0,0,2), p_velocity);
		local point3d p_total_force = p_orbit_force; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time;
		local point3d previous_position = p_position;
        p_position = EulerRotateVectorZ (p_position, -delta_time *p_spin_speed * ( 1 - (p_path_time * 0.0)));

		//Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime * is_orphan();
        kill(p_age > 1);
        p_time = p_time + delta_time();
        local number lightning_multiplier = ( p_time > p_time_to_lightning ) ? 3:1;
        p_lighting_age = p_lighting_age + ( p_time > p_time_to_lightning ) ? delta_time() / p_lighting_duration: -p_lighting_age;
        p_time_to_lightning = p_time_to_lightning + (( p_time > p_time_to_lightning + p_lighting_duration) ? hash(p_time) * 165:0);
        lightning_multiplier = abs(sin(p_lighting_age * 5)) * 4 + 1;
        p_previous_root = root_position();
	}

    property geometry_type = quad_aligned;
	property material_type = quad_unlit;
	property blend_type = alpha;
	property priority = 2;
    property material_lighting = non_directional;
    property masked = true;
    property shadows = false;


	RENDER
    {
        local number alpha = .5 * scale_multiply * (1-p_age);
        local number p_UVX_Rate = 0.05;
		local number offset = p_time * p_UVX_Rate + p_UV_Offset;
        export( "BASECOLOR_UV", float4(0, 0,1,1 ) + float4(-offset, offset * .5, -offset, offset * .5));
        export( "NORMALMAP_UV", float4(0, 0, 1,1 ) );
        export( "MASK_UV", float4(0, 0, 1,1 ) );
		export( "SCALE", point2d(p_cloud_scale,p_cloud_scale) * ( 1-p_path_time ) * scale_multiply);
		//export( "ROTATION", p_time * .5);
        export( "POSITION", p_position );
        export( "TANGENT", p_initial_tangent );
        //export( "BITANGENT", p_initial_bitangent );

        export( "COLOR", color(1,1,1.0) * .6 * alpha * lightning_multiplier);
		export( "ALPHA", 1  * alpha);
    }
}

emitter FX_Mid_Fog_Storm_Particles
{
	varying point3d p_position;
    varying number p_cloud_scale;
    varying number p_page;
    varying number p_time;

	SPAWN(  float2 in_size,
            float in_radius,
            float3 in_offset )
	{
		local float2 disc_pos = SampleUnitDisc( mix(SMOOTHSTOP2(random()), random(), 0.75), random() * 2 * PI ) * in_radius;
		p_position = float3(disc_pos.x, disc_pos.y, random()* 15) + in_offset;
        p_cloud_scale = mix(in_size.x, in_size.y, random());
        p_time = 0;
        p_page = random();
	}

	SIM
	{
        p_position = EulerRotateVectorZ(p_position, delta_time() * -0.0051 * (p_page + 0.5));
        local float3 world_pos = Apply(root_scale(), root_position(), p_position);
        local float2 v2FOW = sample_fow( world_pos.xy );
        local number scale_multiply = SMOOTHSTART5(Clamp(0, 1, Clamp(0,1,v2FOW.x-v2FOW.y)  * 6 - 3));
		//Advance age, and kill if necesary
		p_time = p_time + delta_time();
	}

	property geometry_type = quad_fixed;
	property material_type = quad_unlit;
	property blend_type = alpha;
	property priority = 100;
    property material_lighting = non_directional;

	RENDER
    {
        export( "BASECOLOR_UV", NumberToFlipbookUV(float2(2,2), p_page) );
		export( "SCALE", point2d(p_cloud_scale,p_cloud_scale) * scale_multiply);
		export( "ROTATION", 0 );
        export( "TANGENT", float3(1,0,0));
        export( "BITANGENT", float3(0,1,0));
		export( "POSITION", p_position );
		export( "COLOR", color(1,1,1) *scale_multiply);
		export( "ALPHA", scale_multiply);
    }
}

emitter Rain_Particles
{
	varying point3d p_position;
	varying point3d p_acceleration;
	varying point3d p_velocity;
	varying number p_age;
	varying number p_inv_lifetime;


	SPAWN(point3d in_pos)
	{
		// Box Volume Emission
		// Spawn position occurrs within a volume, with velocity pointing up plus a cone volume of angle variance
		local number spawn_x = 10;
		local number spawn_y = 10;
		local number spawn_z = 1;
		p_position = point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( -spawn_z/2, spawn_z/2, random() ));
		p_position = float3(p_position.x, p_position.y, 0) ;
		p_position = p_position + in_pos;

		p_velocity = float3(1.5,0,-10);

		p_acceleration = point3d(0,0,0); // This is gravity, currently not used

		local number lifetime = 3;
		p_inv_lifetime = 1.0 / lifetime;
		p_age = 0.0;
	}

	SIM
	{
		local point3d p_total_force = p_acceleration; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time();
		p_position = p_position + p_velocity * delta_time();

		//Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime;
		kill(p_age > 1);
	}

    property geometry_type = quad_aligned;
	property material_type = quad_unlit;
	property blend_type = alpha;
	property priority = 1;

	RENDER
    {
        local number alpha = 0.3;
		export( "BASECOLOR_UV", float4( 0, 0, 1, 1 ) );
		export( "SCALE", point2d(.65,.15) );
		export( "TANGENT", p_velocity);
		export( "ROTATION", 0 );
        export( "POSITION", p_position );
		export( "COLOR", color(.25,.25,.25)  *alpha * p_age);
		export( "ALPHA", alpha  * p_age);
    }


}

group Hurricane_Cat4
{
	varying number p_time;
    varying float3 p_previous_root;

    SPAWN
    {
        p_time = 0;
        p_previous_root = root_position();
        emit_count( "FX_CloudTrails", 350 )
		{
			export( "in_pos", float3(0,0,0) );
            export( "in_time", p_time );
            export( "in_size", 100 );
            export( "in_cloud_size", 20 );
            export( "in_twist_amount", 5 );
            export( "in_spin_speed", 0.05);
            export( "in_tip_divergence", 10);
		};
        emit_count( "FX_CloudTrails_Center", 90 )
		{
			export( "in_pos", float3(0,0,0) );
            export( "in_time", p_time );
            export( "in_size", 130 );
		};
    }

	SIM
	{
        local number speed_increase = length(p_previous_root - root_position()) * 6;
        p_time = p_time + (delta_time());
        emit_rate( "FX_CloudTrails", 150.0 )
		{
			export( "in_pos", float3(0,0,0) );
            export( "in_time", p_time * (speed_increase + 1));
            export( "in_size", 100 );
            export( "in_cloud_size", 20 );
            export( "in_twist_amount", 5 );
            export( "in_spin_speed", 0.05);
            export( "in_tip_divergence", 10);
		};
        p_previous_root = root_position();
	}
}



/////////////////////// Blizzards and Dust storms
emitter snowFlurries
{
	varying number p_inv_lifetime;
	varying float3 p_position;
    varying float3 p_velocity;
	varying number p_age;
	varying number p_sign;
	varying number p_time;
    varying number p_size;
    varying number p_radius_squared;
    varying number p_timescale;
    varying color p_color;
    varying number p_alpha;
    varying number p_noise_scale;
    varying number p_gravity;
    varying number p_fog_fade;
    varying number p_stretch_scale;

	SPAWN(  float in_radius,
            float2 in_velocity,
            float in_lifetime,
            float in_size_min,
            float in_size_max,
            float in_timescale,
            color in_color,
            float in_alpha,
            float in_noise_scale,
            float in_min_alpha,
            float in_gravity,
            float3 in_offset,
            float in_stretch_scale = 0.025)
	{
		local number spawn_x = in_radius;
		local number spawn_y = in_radius;
        local float2 disc_position = SampleUnitDisc( SMOOTHSTART2(random()), (random()) * 2 * PI ) * in_radius;
		p_position = point3d(disc_position.x, disc_position.y, 0);
        //p_position = Apply( root_rotation(), root_scale(), root_position(), p_position );
        p_position = p_position + in_offset;
		p_time = random() * 1000;
		local number lifetime = 18 * (1-(p_position.x )/in_radius);
        lifetime = in_lifetime;
		p_inv_lifetime = 1.0 / lifetime;
		p_age = 0;
		local number p_speed = mix(in_velocity.x, in_velocity.y, random());
		p_sign = (random() > 0.5) ? 1 : 1;
        p_velocity = float3(p_speed,p_speed , 0);
        p_size = mix(in_size_min, in_size_max, random());
        p_radius_squared = in_radius * in_radius;
        p_timescale = in_timescale;
        p_color = in_color;
        p_alpha = mix(in_alpha, in_min_alpha, random());
        p_noise_scale = in_noise_scale;
        p_gravity = in_gravity;
        p_stretch_scale = in_stretch_scale;

        p_position = Apply( root_rotation(), root_scale(), root_position(), p_position );
        p_fog_fade = sample_fow( p_position.xy ).y;
	}

	SIM
	{
        local float2 v2FOW = sample_fow( p_position.xy );
        local number age_multiplier = (v2FOW.y < .5)? 3:0; //Kill particle if not in mostly visible FOW region
        p_fog_fade = p_fog_fade - delta_time() * age_multiplier;


        local float delta_time = delta_time() * p_timescale;
        local float frequency = 0.5;
        local float strength = p_noise_scale;
        local float gravity = p_gravity;
        local float drag = 0.2;
        local float3 noise_3d = float3(ValueNoise1D(p_time * frequency) *2 - 1, ValueNoise1D(p_time * frequency) *2 - 1,0) * -1;
        local point3d p_total_force = noise_3d * strength + float3(0, 0, gravity) - p_velocity * drag; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time;
		p_position = p_position + p_velocity * delta_time;

		//Advance age and time and kill if necesary
        local float distance_squared = p_position.x * p_position.x + p_position.y * p_position.y;

		p_age = p_age + delta_time * p_inv_lifetime;
		kill( p_age > 1 );
        kill( p_position.z < -5 );
        //p_velocity.z = (p_position.z < 0)? p_velocity.z * -1: p_velocity.z;
        p_time = p_time + delta_time;

        kill(p_fog_fade < 0);
        kill(v2FOW.y + p_age < .5);
	}

	property geometry_type = quad_aligned;
	property material_type = quad_unlit_distorted;
	property blend_type = alpha;
    property material_lighting = directional;


	RENDER
    {
        local number alpha = p_alpha * ARCH2(p_age) * p_fog_fade;
		export( "SCALE", point2d( p_size * (1-p_age) * Clamp(0.75, 3,length(p_velocity) * p_stretch_scale), p_size * .5 * (1-p_age)));
		export( "TANGENT", p_velocity );
		export( "BASECOLOR_UV", float4( 0, 0, 1, 1 ) );
        export( "DISTORTION_UV", float4(0,0,1,1) * 0.5 + float4(p_time,0,p_time,0) * -0.25 );
        export( "DISTORTION_SCALE", .3 );
        export( "POSITION",  ApplyInverse( root_rotation(), root_scale(), root_position(), p_position) );
        //export( "POSITION",  p_position );
		export( "COLOR", p_color *alpha * 0.8);
		export( "ALPHA", alpha);
    }
}

emitter rollingClouds
{
	varying number p_inv_lifetime;
	varying float3 p_position;
    varying float3 p_velocity;
	varying number p_age;
	varying number p_time;
    varying number p_size;
    varying number p_radius_squared;
    varying number p_timescale;
    varying color p_color;
    varying number p_alpha;
    varying number p_fog_fade;
    varying number root_scale;
	varying float3 root_position;
	varying float4 root_rotation;

	SPAWN(  float in_radius,
            float2 in_velocity,
            float in_lifetime,
            float in_size_min,
            float in_size_max,
            float in_timescale,
            color in_color,
            float in_alpha,
            float3 in_offset,
            float in_center_weight
            )
	{
        root_scale = root_scale();
		root_position = root_position();
		root_rotation = root_rotation();

		local number spawn_x = in_radius;
		local number spawn_y = in_radius;
        local number weighed_random = random();
        weighed_random = mix(weighed_random, SMOOTHSTART2(weighed_random), in_center_weight);
        local float2 disc_position = SampleUnitDisc( weighed_random, (random()) * 2 * PI ) * in_radius;
		p_position = point3d(disc_position.x, disc_position.y, 0);
        p_position = p_position + in_offset;
        p_position = Apply( root_rotation, root_scale, root_position, p_position );

		p_time = random() * 365; //Random start time offset
		p_inv_lifetime = 1.0 / in_lifetime;
		p_age = 0;

		local number p_speed = mix(in_velocity.x, in_velocity.y, random());

        p_velocity = float3(p_speed,p_speed , 0);
        p_size = mix(in_size_min, in_size_max, random());
        p_radius_squared = in_radius * in_radius;
        p_timescale = in_timescale;
        p_color = in_color;
        p_alpha = in_alpha;
        p_fog_fade = sample_fow( p_position.xy ).y;
	}

	SIM
	{
        local float2 v2FOW = sample_fow( p_position.xy );
        local number age_multiplier = (v2FOW.y < .5)? 2:0; //Kill particle if not in mostly visible FOW region
        p_fog_fade = p_fog_fade - delta_time() * age_multiplier;
        kill(p_fog_fade < 0);
        kill(v2FOW.y + p_age < .5);

        local float delta_time = delta_time() * p_timescale;
        local float frequency = 0.5;
        local float strength = 30;
        local float gravity = -10;
        local float3 wind = float3(50, 50, 0);
        local float drag = 0.2;
        local float3 noise_3d = float3(ValueNoise1D(p_time * frequency) *2 - 1, ValueNoise1D(p_time * frequency) *2 - 1,0) * -1;
        local point3d p_total_force = noise_3d * strength + float3(0, 0, gravity) - p_velocity * drag + wind; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time;
		p_position = p_position + p_velocity * delta_time;

		//Advance age and time and kill if necesary
		p_age = p_age + delta_time * p_inv_lifetime;
		kill( p_age > 1 );
        p_time = p_time + delta_time;
	}

	property geometry_type = quad_rotated;
	property material_type = quad_unlit_distorted;
	property blend_type = alpha;
    property normalmap = true;
    property distorted = true;
    property material_lighting = directional;
    property sort_order = reverse_emit_order;
    property priority = 0;
    //property layer = overlay;
    //property shadows = false;

	RENDER
    {
        local number alpha = p_alpha * ARCH2(p_age) * p_fog_fade;
		export( "SCALE", point2d( p_size, p_size ) * (1+ p_age));
		export( "TANGENT", p_velocity );
        export( "ROTATION", p_time );
		export( "BASECOLOR_UV", float4( 0, 0, 1, 1 ) );
        export( "NORMALMAP_UV", float4( 0, 0, 1, 1 ) );
        export( "DISTORTION_UV", float4(0,0,1,1) * 0.5 + float4(p_time,p_time,p_time,p_time) * -0.15 );
        export( "DISTORTION_SCALE", .051 );
        export( "POSITION",  ApplyInverse( root_rotation(), root_scale(), root_position(), p_position) );
        //export( "POSITION",  p_position );
		export( "COLOR", p_color * alpha);
		export( "ALPHA", alpha);
    }
}

emitter rollingCloudsOverlay
{
	varying number p_inv_lifetime;
	varying float3 p_position;
    varying float3 p_velocity;
	varying number p_age;
	varying number p_time;
    varying number p_size;
    varying number p_radius_squared;
    varying number p_timescale;
    varying color p_color;
    varying number p_alpha;
    varying number p_fog_fade;

	SPAWN(  float in_radius,
            float2 in_velocity,
            float in_lifetime,
            float in_size_min,
            float in_size_max,
            float in_timescale,
            color in_color,
            float in_alpha,
            float3 in_offset
            )
	{
		local number spawn_x = in_radius;
		local number spawn_y = in_radius;
        local number weighed_random = random();
        weighed_random = mix(weighed_random, SMOOTHSTART2(weighed_random), .35);
        local float2 disc_position = SampleUnitDisc( weighed_random, (random()) * 2 * PI ) * in_radius;
		p_position = point3d(disc_position.x, disc_position.y, 0);
        p_position = p_position + in_offset;

		p_time = random() * 365; //Random start time offset
		p_inv_lifetime = 1.0 / in_lifetime;
		p_age = 0;

		local number p_speed = mix(in_velocity.x, in_velocity.y, random());

        p_velocity = float3(p_speed,p_speed , 0);
        p_size = mix(in_size_min, in_size_max, random());
        p_radius_squared = in_radius * in_radius;
        p_timescale = in_timescale;
        p_color = in_color;
        p_alpha = in_alpha;
        p_fog_fade = 1;
        p_position = Apply( root_rotation(), root_scale(), root_position(), p_position );
	}

	SIM
	{
        //local float3 root_position = root_position();
        //local number root_scale = root_scale();
        //local float3 world_pos = Apply(root_scale, root_position, p_position);
        local float2 v2FOW = sample_fow( p_position.xy );
        local number age_multiplier = (v2FOW.y < .5)? 2:0; //Kill particle if not in mostly visible FOW region
        p_fog_fade = p_fog_fade - delta_time() * age_multiplier;
        kill(p_fog_fade < 0);
        kill(v2FOW.y + p_age < .5);

        local float delta_time = delta_time() * p_timescale;
        local float frequency = 0.5;
        local float strength = 30;
        local float gravity = -10;
        local float3 wind = float3(50, 50, 0);
        local float drag = 0.2;
        local float3 noise_3d = float3(ValueNoise1D(p_time * frequency) *2 - 1, ValueNoise1D(p_time * frequency) *2 - 1,0) * -1;
        local point3d p_total_force = noise_3d * strength + float3(0, 0, gravity) - p_velocity * drag + wind; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time;
		p_position = p_position + p_velocity * delta_time;

		//Advance age and time and kill if necesary
		p_age = p_age + delta_time * p_inv_lifetime;
		kill( p_age > 1 );
        p_time = p_time + delta_time;
	}

	property geometry_type = quad_fixed;
	//property material_type = quad_unlit_distorted;
	property blend_type = alpha;
    property normalmap = true;
    property distorted = true;
    property material_lighting = directional;
    property sort_order = reverse_emit_order;
    property priority = 0;
    property layer = overlay;
    property shadows = false;

	RENDER
    {
        local number alpha = p_alpha * ARCH2(p_age) * p_fog_fade;
		export( "SCALE", point2d( p_size, p_size ) * (1+ p_age));
		export( "TANGENT", float3(0,1,0) );
        export( "BITANGENT", float3(1,0,0) );
        export( "ROTATION", p_time );
		export( "BASECOLOR_UV", float4( 0, 0, 1, 1 ) );
        export( "NORMALMAP_UV", float4( 0, 0, 1, 1 ) );
        export( "DISTORTION_UV", float4(0,0,1,1) * 0.5 + float4(p_time,p_time,p_time,p_time) * -0.15 );
        export( "DISTORTION_SCALE", .1 );
        export( "POSITION",  ApplyInverse( root_rotation(), root_scale(), root_position(), p_position) );
		export( "COLOR", p_color * alpha);
		export( "ALPHA", alpha);
    }
}


emitter FX_spinning_flurries
{
    varying number p_time;
    SPAWN
    {
		p_time = 0;
    }
    SIM
    {
        p_time = p_time + delta_time();
        emit_rate( "FX_CloudTrails", 200.0 )
		{
			export( "in_pos", float3(0,35,-5) );
            export( "in_time", p_time );
            export( "in_size", 30 );
            export( "in_cloud_size", 1 * hash(p_time));
            export( "in_twist_amount", 10 );
            export( "in_spin_speed", 0.05);
            export( "in_tip_divergence", 15);
            export( "in_center_radius", 0);
            export( "in_color", color(.25,.20,.20) * 0.5);
            export( "in_alpha", 1.5);
            export( "in_rain_amount", 0.0);
            export( "in_spin_speed_variation", 0.425);
            export( "in_centripetal_force", 0.00152);
		};
    }
}


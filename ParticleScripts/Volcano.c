#include "Sampling.FXH"
#include "Flipbook.FXH"
#include "EulerRotations.FXH"
#include "Tweening.FXH"
#include "Transform.FXH"
#include "Math.FXH"
#include "Noise.FXH"

#define Z_OFFSET 12
#define MINIMUM_SIZE_FACTOR 0 // FfH: was 0.0015 (camera-distance AA made unit-scale magma a faint cloud in game)

emitter FX_Magma_Bits
{
	varying point3d p_position;
	varying point3d p_acceleration;
	varying point3d p_velocity;
	varying color p_color;
	varying number p_age;
	varying number p_inv_lifetime;
	varying number p_size;
	varying number p_drag;
    varying number p_quality;

	SPAWN(
        number in_time,
        float3 in_spawn_position,
        number in_spawn_radius,
        number in_initial_speed,
        float3 in_velocity,
        number in_cone_angle,
        number in_initial_angle_x,
        number in_initial_angle_y,
        number in_drag,
        number in_gravity,
        number in_lifetime,
        number in_size,
        color in_color)
	{
		p_drag = -in_drag;
		p_color = in_color;
		// Box Volume Emission
		// Spawn position occurrs within a volume, with velocity pointing up plus a cone volume of angle variance
		local number spawn_x = in_spawn_radius;
		local number spawn_y = in_spawn_radius;
		local number spawn_z = in_spawn_radius;
		p_position = point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( 0, spawn_z, random() ));
        p_position = p_position + in_spawn_position;

        // Velocity
        local number speed_variance = (random() * 0.5 + 0.5);
		local number initial_velocity_magnitude = max(2,in_initial_speed * speed_variance);

        // Biased spherical cap
        local number cone_radius = in_cone_angle;	// goes from 0 to 180
        local number off_center = random();
        p_velocity = SampleUnitSphere( 1 - SMOOTHSTART4(off_center) * in_cone_angle / 180, random() * 2 * PI ) * initial_velocity_magnitude;

		// Rotate vector around y axis
		//local number theta = in_initial_angle_y; // degrees
		local number theta = (in_initial_angle_x / 180) * PI; // convert to radians
		p_velocity = EulerRotateVectorX(p_velocity, theta);

        theta = (in_initial_angle_y / 180) * PI; // convert to radians
		p_velocity = EulerRotateVectorY(p_velocity, theta);

        p_velocity = p_velocity + in_velocity;

        // Scale gravity by vertical velocity, this makesthe particles clump up a bit more towards the end of their life
		p_acceleration = point3d(0,0,-in_gravity - (p_velocity.z * 0.25)); // This is gravity, currently not used

		p_inv_lifetime = 1.0 / (in_lifetime);
		p_age = 0.0;

		p_size = max(0.1,in_size * (random() + 0.25) * (1- off_center * 0.8) * (1-speed_variance));
        p_quality = import( float, "FireFXQuality");
        // FfH: FireFXQuality culling removed (sent ~1/3 of the drops to z -100 in game)
	}

	SIM
	{
        local float3 root_position = root_position();
        local number root_scale = root_scale();

		local point3d drag_force = p_velocity * p_drag; // cheap drag implementation
		local point3d p_total_force = p_acceleration + drag_force; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time();
		p_position = p_position + p_velocity * delta_time();

        local float3 world_pos = Apply(root_scale, root_position, p_position);
        local number t_height = terrain_height( world_pos );
        local number t_height_local = (t_height - root_position.z) / root_scale;

        //Stop moving when colliding with ground
        local number emit_overlay_count = (world_pos.z < t_height)? 1: 0;


        local number age_multiplier = (is_orphan() > 0 )? 20:1;
        //Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime * age_multiplier;
		kill(p_age > 1);
        kill(world_pos.z < (t_height ));
        kill(t_height < 0);

        local number p_size_mult = SMOOTHSTOP2(1-p_age);

        emit_count("FX_Magma_Bits_Overlay", emit_overlay_count * (p_quality > 0) ? 0 :1)
        {
            export("in_spawn_position", p_position);
            export("in_lifetime", 6);
            export("in_size",p_size * p_size_mult * 0.75);
            export("in_color", color(p_color.r,p_color.g +  p_size * 0.1,p_color.b));
        };
	}


    property geometry_type = quad_aligned;
	property material_type = quad_unlit_distorted;
	property blend_type = alpha;
    property layer = opaque;
    property sort_order = reverse_emit_order;
    property priority = 10;

	RENDER
    {
        // This does "Phonewire AA" where we grow the particle size if it's smaller than a pixel and decrease its alpha instead
        local float size = p_size * p_size_mult;
        local float3 camera_pos = import( float3, "CameraPos");
        local float minimumSize = length(camera_pos - Apply(root_position(),p_position))  * MINIMUM_SIZE_FACTOR;
        local float AA_Alpha = (minimumSize > size)? max(0,1 -  1 * (minimumSize - size) / minimumSize) : 1;

        export( "BASECOLOR_UV", float4(0,0,1,1) );
        export( "DISTORTION_UV", float4(0,0,1,1) * 0.25 + float4(p_age ,p_age,p_age ,p_age) * 0.5 );
        export( "DISTORTION_SCALE",  1);

		export( "SCALE", point2d(1, (1- length(p_velocity) * 0.03)) * (minimumSize > size)? minimumSize : size);
        export( "TANGENT", p_velocity );
		export( "POSITION", p_position);
		export( "COLOR", float3(p_color.r,p_color.g +  p_size * 0.1,p_color.b) * 1.5 * AA_Alpha);
		export( "ALPHA",   AA_Alpha);
    }
}

emitter FX_Large_Magma_Bits
{
	varying point3d p_position;
	varying point3d p_acceleration;
	varying point3d p_velocity;
	varying color p_color;
	varying number p_age;
	varying number p_inv_lifetime;
	varying number p_size;
	varying number p_rotation;
	varying number p_rotation_speed;
	varying number p_rotation_drag;
	varying number p_drag;


	SPAWN(
        number in_time,
        float3 in_spawn_position = float3(0,0,0),
        number in_spawn_radius,
        number in_initial_speed,
        number in_cone_angle,
        number in_rotation,
        number in_rotation_speed,
        number in_rotation_drag,
        number in_initial_angle,
        number in_drag,
        number in_gravity,
        number in_lifetime,
        number in_size,
        color in_color)
	{
		p_drag = -in_drag;
		p_color = in_color;
		p_rotation = mix( -in_rotation, in_rotation, random() );
		p_rotation_drag = in_rotation_drag;
		// Box Volume Emission
		// Spawn position occurrs within a volume, with velocity pointing up plus a cone volume of angle variance
		local number spawn_x = in_spawn_radius;
		local number spawn_y = in_spawn_radius;
		local number spawn_z = in_spawn_radius;
		p_position = in_spawn_position + point3d(mix( -spawn_x/2, spawn_x/2, random() ), mix( -spawn_y/2, spawn_y/2, random() ), mix( 0, spawn_z, random() ));

        // Velocity
		local number initial_velocity_magnitude = in_initial_speed;

		local number cone_radius = in_cone_angle;	// goes from 0 to 180

        p_velocity = SampleUnitSphere( 1 - SMOOTHSTART3(random()) * in_cone_angle / 180, random() * 2 * PI )  * initial_velocity_magnitude;

		//rotate vector around y axis
		local number theta = in_initial_angle; // degrees
		theta = (theta / 180) * PI; // convert to radians
		p_velocity = EulerRotateVectorY(p_velocity, theta) * random();

		local number sign = (random() > 0.5) ? -1 : 1; // This will is only for bi-directional rotation speed
		local number min_spin = in_rotation_speed * 0.5;
		local number max_spin = in_rotation_speed;
		p_rotation_speed = mix( min_spin, max_spin, random() ) * sign;

		p_acceleration = point3d(0,0,-in_gravity);

		p_inv_lifetime = 1.0 / in_lifetime;
		p_age = 0.0;

		p_size = in_size * random();
	}

	SIM
	{
        local number root_scale = root_scale();
        local float3 root_position = root_position();

		local point3d drag_force = p_velocity * p_drag; // Not sure how Fork does drag, but this works
		local point3d p_total_force = p_acceleration + drag_force; // Need to add up all forces here
		p_velocity = p_velocity + (p_total_force) * delta_time();

		p_position = p_position + p_velocity * delta_time();

        local float3 world_pos = Apply(root_scale, root_position, p_position);


		p_rotation = p_rotation + p_rotation_speed * delta_time() - p_rotation_drag * p_rotation_speed * delta_time();

		local number age_multiplier = (is_orphan() > 0 )? 20:1;
        //Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime * age_multiplier;
		kill(p_age > 1);

        emit_rate("FX_Magma_Bits", 3)
		{
			export("in_time", 0 );
            export("in_spawn_position", p_position );
            export("in_initial_speed", 10 );
            export("in_velocity", p_velocity  * 0.25);
			export("in_spawn_radius",0 );
			export("in_initial_angle_x", 30 );
            export("in_initial_angle_y", 30 );
			export("in_drag", 0);
			export("in_gravity", 3.0);
			export("in_size", 1);
            export("in_color", color(-100,-100,-100));
			export("in_cone_angle", 25);
			export("in_lifetime", 10);
		};


	}

	property geometry_type = quad_rotated;
	property material_type = quad_unlit;
	property blend_type = alpha;
    property layer = opaque;

	RENDER
    {
		export( "BASECOLOR_UV", float4(0,0,1,1));
		export( "SCALE", point2d(p_size, p_size));
		export( "ROTATION", p_rotation );
		export( "POSITION", p_position);
		export( "COLOR", p_color);
		export( "ALPHA",  1);
    }
}

emitter FX_Magma_Bits_Overlay
{
	varying point3d p_position;
    varying color p_color;
	varying number p_age;
    varying number p_inv_lifetime;
	varying number p_size;

	SPAWN(
        float3 in_spawn_position,
        number in_lifetime,
        number in_size,
        color in_color)
	{
		p_color = in_color;
		p_position = in_spawn_position;
		p_inv_lifetime = 1.0 / (in_lifetime * mix(0.5, 1, random()));
		p_age = 0.0;
		p_size = (length(float2(p_position.x,p_position.y)) <10)? 0 : in_size;

        local float3 world_pos = Apply(root_scale(), root_position(), p_position);
        local float2 v2FOW = sample_fow( world_pos.xy );
        p_size = (v2FOW.y < .5)? 0 : in_size;
	}

	SIM
	{
        //Advance age, and kill if necesary
		p_age =  p_age + delta_time() * p_inv_lifetime;
		kill(p_age > 1);
        kill(p_size < .1);
	}

	property geometry_type = quad_aligned;
	//property material_type = quad_unlit_distorted;
	property blend_type = alpha;
    property shadows = false;
    property distorted = true;
    //property material_lighting =directional;
    //property layer = opaque;

	RENDER
    {
        local float size = p_size * 0.75 * max((1- p_age), 0.4);
        local float3 camera_pos = import( float3, "CameraPos");
        local float minimumSize = length(camera_pos - Apply(root_position(),p_position))  * MINIMUM_SIZE_FACTOR;
        local float AA_Alpha = (minimumSize > size)? max(0,1 -  1 * (minimumSize - size) / minimumSize) : 1;

		export( "BASECOLOR_UV", float4(0,0,1,1) );
		export( "SCALE", point2d(size * 1.5 * (1+p_age), size));
        export( "DISTORTION_UV", float4(0,0,1,1) * 0.05 + float4(p_age ,p_age,0 ,0) * -0.25 );
        export( "DISTORTION_SCALE",  0.1);
		export( "TANGENT", float3(p_position.x, p_position.y, -5) );
        export( "POSITION", p_position);
        local float out_alpha = (1- p_age) * AA_Alpha;
        export( "COLOR", float3(p_color.r,p_color.g * (1 - p_age),p_color.b) * 2 * out_alpha) ;
		export( "ALPHA",  0.5* out_alpha);
    }
}



group VolcanoSpew
{
	varying number p_time;
    SPAWN
    {
		//noCode
		p_time = floor(hash(instance_id()) * 100.125); // slight time offset between each instance


        emit_count("FX_Large_Magma_Bits", 200)
		{
			export("in_time", p_time );
            export("in_spawn_position", float3(0,0,Z_OFFSET));
			export("in_spawn_radius", 1 );
			export("in_initial_speed", 1 );
			export("in_initial_angle", 00 );
			export("in_rotation", 0);
			export("in_rotation_speed", 0);
			export("in_rotation_drag", 0.2);
			export("in_drag", 0);
			export("in_gravity", 3);
			export("in_size", .5);
            export("in_color", color(0.01,0.01,0.01));
			export("in_cone_angle", 45);
			export("in_lifetime", 15);
		};

        emit_count("FX_Magma_Bits", 400)
		{
			export("in_time", p_time );
            export ("in_spawn_position", float3(0,0,Z_OFFSET- 6));
			export("in_spawn_radius", 4 );
			export("in_initial_speed", 8 );
            export("in_velocity" , float3(0,0,0));
			export("in_initial_angle_x", 25 * (2 * hash(floor(p_time)) -1) );
            export("in_initial_angle_y", 25 * (2 * hash(floor(p_time + 100)) -1) );
			export("in_drag", 0.05);
			export("in_gravity", 3);
			export("in_size", 3);
            export("in_color", color(1,0.025,0)  * 2.5);
			export("in_cone_angle", 13.5 );
			export("in_lifetime", 15);
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

        emit_rate("FX_Magma_Bits", emit_multiplier * 1000 * (SMOOTHSTOP3(sin(p_time))+7))
		{
			export("in_time", p_time );
            export ("in_spawn_position", float3(0,0,Z_OFFSET));
			export("in_spawn_radius", 1.5 );
			export("in_initial_speed", max(8 * abs((sin(p_time * PI ))) * (hash(floor(p_time + 235))* 0.2 + 0.8), 3) );
            export("in_velocity" , float3(0,0,0));
			export("in_initial_angle_x", 25 * (2 * hash(floor(p_time)) -1) );
            export("in_initial_angle_y", 25 * (2 * hash(floor(p_time + 100)) -1) );
			export("in_drag", 0.05);
			export("in_gravity", 3);
			export("in_size", 3);
            export("in_color", color(1,0.025,0)  * 2.5);
			export("in_cone_angle", 3.5 * abs(sin(2*p_time)));
			export("in_lifetime", 15);
		};

        emit_rate("FX_Large_Magma_Bits", 15)
		{
			export("in_time", p_time );
            export("in_spawn_position", float3(0,0,Z_OFFSET));
			export("in_spawn_radius", 1 );
			export("in_initial_speed", 1 );
			export("in_initial_angle", 00 );
			export("in_rotation", 100);
			export("in_rotation_speed", 5);
			export("in_rotation_drag", 0.2);
			export("in_drag", 0);
			export("in_gravity", 3);
			export("in_size", 0.25);
            export("in_color", color(0,0,0));
			export("in_cone_angle", 45);
			export("in_lifetime", 15);
		};
	}
}

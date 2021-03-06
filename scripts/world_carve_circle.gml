/// world_carve_circle(x, y, radius, strength);
var _x = clamp(argument[0], 0, World.width-1);
var _y = clamp(argument[1], 0, World.height-1);
var _radius = argument[2];
var _strength = argument[3];

// check world_generate for terrain IDs

surface_set_target(World.surTerrain);

for(var i = clamp(_x-_radius, 0, World.width); i < clamp(_x+_radius, 0, World.width); i += 1)
{
    for(var j = clamp(_y-_radius, 0, World.height); j < clamp(_y+_radius, 0, World.height); j += 1)
    {
        if(point_distance(i, j, _x, _y) <= _radius)
        {
            World.terrain_durability[_x, _y] -= _strength;
            if(World.terrain_durability[_x, _y] <= 0)
            {
                World.terrain_durability[_x, _y] = 0;
                World.terrain[i, j] = 0; // air
                
                draw_set_blend_mode(bm_subtract); // delete mode
                draw_point_color(i, j, c_black);
                draw_set_blend_mode(bm_normal);
            }
        }
    }
}

surface_reset_target();


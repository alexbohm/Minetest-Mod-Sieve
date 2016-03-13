minetest.log("action","Sieve: Starting Load")
--Created by Alex Bohm
--[[
Notes:

MetaData Ref
"burn_t" = total seconds of burn time on place and take
"mat_n" = total number of material to process

Auto Sieve is not functional yet (almost there).
]]
function con_mat(pos, stack)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if inv:contains_item("mat", stack) then
        inv:remove_item("mat", ItemStack(stack:get_name().." 1"))
        inv:add_item("out", ItemStack(material(stack:get_name())))
    end
end
function con_fuel(pos, stack)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if inv:contains_item("fuel", stack) then
        inv:remove_item("fuel", ItemStack(stack:get_name().." 1"))
    end
end

function accept(itemname)
    if itemname == 'default:sand' or itemname == 'default:gravel' or itemname == 'default:desert_sand' or itemname == 'default:dirt' then
        return true
    else
        return false
    end
    --[[
    Acceptable Items:
    "default:sand"
    "default:gravel"
    "default:desert_sand"
    "default:dirt"
    ]]
end

function material(itemname)
    local chance = math.random(40)
        if accept(itemname) then
            if chance <= 5 then
                --stick
                r_str = 'default:stick 1'
            elseif chance <= 10 and chance < 12 then
                --coal
                r_str = 'default:coal_lump 1'
            elseif chance <= 12 and chance < 14 then
                --gold
                r_str = 'default:gold_lump 1'
            elseif chance <= 14 and chance < 16 then
                --copper
                r_str = 'default:copper_lump 1'
            elseif chance <= 16 and chance < 18 then
                --iron
                r_str = 'default:iron_lump 1'
            elseif chance <= 18 and chance < 19 then 
                --mese fragment
                r_str = 'default:mese_crystal_fragment 1'
            elseif chance <= 19 and chance < 20 then
                --mese crystal
                r_str = 'default:mese_crystal 1'
            elseif chance == 20 then
                --mese gem
                r_str = 'default:diamond 1'
            else
                return nil
            end
            return r_str
        else
            return nil
        end
end
--Cloth Fiber
minetest.register_craftitem("sieve:cloth_fiber", {
	description = "Cloth Fiber",
    inventory_image = "sieve_cloth_fiber.png",
	})
minetest.register_craft({
    output = "sieve:cloth_fiber 4",
    recipe = {
        {"default:leaves", "", "default:leaves"},
        {"", "default:wood", ""},
        {"default:leaves", "", "default:leaves"}
    }
})
minetest.log("action","Sieve: Cloth Loaded")
-- Mesh
minetest.register_craftitem("sieve:mesh", {
	description = "Mesh",
    inventory_image = "sieve_mesh.png",
	})
minetest.register_craft({
    output = "sieve:mesh 1",
    recipe = {
        {"sieve:cloth_fiber", "sieve:cloth_fiber"},
        {"sieve:cloth_fiber", "sieve:cloth_fiber"},
    }
})
minetest.log("action","Sieve: Mesh Loaded")
--Shaker Motor
minetest.register_craftitem("sieve:shaker_motor", {
    description = "Shaker Motor",
    inventory_image = "sieve_shaker_motor.png",
    })
minetest.register_craft({
    output = "sieve:shaker_motor 2",
    recipe = {
        {"", "",""},
        {"default:cobble", "default:steel_ingot","default:cobble"},
        {"default:cobble", "default:copper_ingot","default:cobble"},
    }
})
minetest.log("action","Sieve: Shaker Motor Loaded")
--Shaker Frame
minetest.register_craftitem("sieve:shaker_frame", {
    description = "Shaker Frame",
    inventory_image = "sieve_shaker_frame.png",
    })
minetest.register_craft({
    output = "sieve:shaker_frame 1",
    recipe = {
        {"default:steel_ingot", "sieve:shaker_motor","default:steel_ingot"},
        {"sieve:shaker_motor", "default:furnace","sieve:shaker_motor"},
        {"default:steel_ingot", "sieve:shaker_motor","default:steel_ingot"},
    }
})
minetest.log("action","Sieve: Shaker Frame Loaded")
--Hand Sieve
minetest.register_node("sieve:hand_sieve", {
    description = "Hand Sieve",
    paramtype = "light",
    tiles = {
    	"sieve_hand_sieve_top.png",
    	"sieve_hand_sieve_bottom.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png"
    },
    groups = {oddly_breakable_by_hand=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
                {-0.5, 0.1875, -0.5, 0.5, 0.19, 0.5}, --top
                {0.5,0.1875,0.5,-0.5,0.5,0.4375},--top
                {-0.5,0.1875,0.5,-0.4375,0.5,-0.5}, --top
                {0.5,0.1875,-0.5,-0.5,0.5,-0.4375}, --top
                {0.5,0.1875,0.5,0.4375,0.5,-0.5}, --top
                {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375}, --leg
                {-0.5, -0.5, 0.5, -0.4375, 0.5, 0.4375}, --leg
                {0.5, -0.5, 0.5, 0.4375, 0.5, 0.4375}, --leg
                {0.5, -0.5, -0.5, 0.4375, 0.5, -0.4375}, --leg
            },
        },
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        --minetest.chat_send_all(itemstack:to_string())
        if accept(itemstack:get_name()) then
            itemstack:take_item()
            minetest.item_drop(ItemStack(material(itemstack:get_name())), player, pos)
        end
    end
    
})
minetest.register_craft({
    output = "sieve:hand_sieve",
    recipe = {
        {"default:stick", "default:stick", "default:stick"},
        {"default:stick", "sieve:mesh", "default:stick"},
        {"default:stick", "default:stick", "default:stick"}
    }
})
minetest.log("action","Sieve: Hand Sieve Loaded")
--Auto Top
minetest.register_craftitem("sieve:auto_sieve_top", {
    description = "Auto Sieve Top",
    inventory_image = "sieve_auto_top.png",
    is_ground_content = true,
    groups = {oddly_breakable_by_hand=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
                }
                }
})
minetest.register_craft({
    output = "sieve:auto_sieve_top",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "sieve:mesh", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
    }
})
minetest.log("action","Sieve: Auto Sieve Top Loaded")

--Auto Legs
minetest.register_craftitem("sieve:auto_sieve_legs", {
    description = "Auto Sieve Legs",
    inventory_image = "sieve_auto_legs.png",
    is_ground_content = true,
    groups = {oddly_breakable_by_hand=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
                }
                }
})
minetest.register_craft({
    output = "sieve:auto_sieve_legs",
    recipe = {
        {"default:steel_ingot", "sieve:shaker_frame", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"}
    }
})
minetest.log("action","Sieve: Auto Sieve Legs Loaded")
--Auto Sieve
minetest.register_node("sieve:auto_sieve", {
    description = "Auto Sieve",
    paramtype = "light",
    tiles = {
        "sieve_auto_sieve_top.png",
        "sieve_auto_sieve_bottom.png",
        "sieve_auto_sieve_side.png",
        "sieve_auto_sieve_side.png",
        "sieve_auto_sieve_side.png",
        "sieve_auto_sieve_side.png"
    },
    is_ground_content = true,
    groups = {oddly_breakable_by_hand=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
                {-0.5, 0.1875, -0.5, 0.5, 0.19, 0.5}, --top
                {0.5,0.5,-0.5,-0.5,0,-0.4375},--top
                {-0.5,0.5,-0.5,-0.4375,0,0.5},--top
                {0.5,0.5,0.5,-0.5,0,0.4375},--top
                {0.5,0.5,-0.5,0.4375,0,0.5},--top
                {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375}, --leg
                {-0.5, -0.5, 0.5, -0.4375, 0.5, 0.4375}, --leg
                {0.5, -0.5, 0.5, 0.4375, 0.5, 0.4375}, --leg
                {0.5, -0.5, -0.5, 0.4375, 0.5, -0.4375}, --leg
                },
        },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
        "size[8,9;]"..
        "list[context;mat;0,0;1,1;]"..
        "list[context;fuel;0,3;1,1;]"..
        "list[context;out;3,0;5,4;]"..
        "image[0,1;2,2;sieve_auto_sieve_side.png]"..
        "list[current_player;main;0,5;8,4;]")
        meta:set_int("burn_t", 0)
        local inv = meta:get_inventory()
        inv:set_size("mat", 1*1)
        inv:set_size("fuel", 1*1)
        inv:set_size("out", 5*4) 
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return 0
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        if listname == 'fuel' then
            if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time > 0 then
                return stack:get_count()
            else
                return 0
            end
        elseif listname == 'mat' then
            if accept(stack:get_name()) then
                return stack:get_count()
            else
                return 0
            end
        elseif listname == 'out' then
            return 0
        end
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if listname == "fuel" then
            meta:set_int("burn_t", inv:get_stack("fuel", 1):get_count()*minetest.get_craft_result({method="fuel",width=1,items={stack}}).time)
        elseif listname == "mat" then
            meta:set_int("mat_n", inv:get_stack("mat_n", 1):get_count())
            con_mat(pos, stack)
        end
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if listname == "fuel" then
            meta:set_int("burn_t", inv:get_stack("fuel", 1):get_count()*minetest.get_craft_result({method="fuel",width=1,items={stack}}).time)
        elseif listname == "mat" then
            meta:set_int("mat_n", inv:get_stack("mat_n", 1):get_count())
        end
    end,
    on_destruct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
    for i, item in ipairs(inv:get_list("out")) do
        minetest.add_item(pos, item)
    end
    minetest.add_item(pos, inv:get_stack("mat", 1))
    minetest.add_item(pos, inv:get_stack("fuel", 1))
    end,

})
minetest.register_craft({
    output = "sieve:auto_sieve",
    recipe = {
        {"sieve:auto_sieve_top"},
        {"sieve:auto_sieve_legs"}
    }
})
minetest.log("action","Sieve: Auto Sieve Loaded")

minetest.log("action","Sieve: Finished Load")
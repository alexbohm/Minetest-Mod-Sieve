minetest.log("action","Sieve: Starting Load")
--Created by Alex Bohm

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
--Hand Sieve
minetest.register_node("sieve:hand_sieve", {
    description = "Hand Sieve",
    tiles = {
    	"sieve_hand_sieve_top.png",
    	"sieve_hand_sieve_bottom.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png",
    	"sieve_hand_sieve_side.png"
    },
    is_ground_content = true,
    groups = {oddly_breakable_by_hand=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
                }
                },
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        minetest.chat_send_all(itemstack:get_name())
        if itemstack:get_name() == 'default:sand' then
            itemstack:take_item()
            local chance = math.random(40)
            if chance <= 5 then
                --stick
                minetest.item_drop(ItemStack('default:stick 1'), player, pos)
            elseif chance <= 10 then
                --coal
                minetest.item_drop(ItemStack('default:coal_lump 1'), player, pos)
            elseif chance <= 12 then
                --gold
                minetest.item_drop(ItemStack('default:gold_lump 1'), player, pos)
            elseif chance <= 14 then
                --copper
                minetest.item_drop(ItemStack('default:copper_lump 1'), player, pos)
            elseif chance <= 16 then
                --iron
                minetest.item_drop(ItemStack('default:iron_lump 1'), player, pos)
            elseif chance <= 18 then 
                --mese fragment
                minetest.item_drop(ItemStack('default:mese_crystal_fragment 1'), player, pos)
            elseif chance == 19 then
                --mese crystal
                minetest.item_drop(ItemStack('default:mese_crystal 1'), player, pos)
            elseif chance == 20 then
                --mese gem
                minetest.item_drop(ItemStack('default:diamond 1'), player, pos)
            end
        elseif itemstack:get_name() == 'default:gravel' then
            itemstack:take_item()
            local chance = math.random(40)
            if chance <= 5 then
                --stick
                minetest.item_drop(ItemStack('default:stick 1'), player, pos)
            elseif chance <= 10 then
                --coal
                minetest.item_drop(ItemStack('default:coal_lump 1'), player, pos)
            elseif chance <= 12 then
                --gold
                minetest.item_drop(ItemStack('default:gold_lump 1'), player, pos)
            elseif chance <= 14 then
                --copper
                minetest.item_drop(ItemStack('default:copper_lump 1'), player, pos)
            elseif chance <= 16 then
                --iron
                minetest.item_drop(ItemStack('default:iron_lump 1'), player, pos)
            elseif chance <= 18 then 
                --mese fragment
                minetest.item_drop(ItemStack('default:mese_crystal_fragment 1'), player, pos)
            elseif chance == 19 then
                --mese crystal
                minetest.item_drop(ItemStack('default:mese_crystal 1'), player, pos)
            elseif chance == 20 then
                --mese gem
                minetest.item_drop(ItemStack('default:diamond 1'), player, pos)
            end
        elseif itemstack:get_name() == 'default:desert_sand' then
            itemstack:take_item()
            local chance = math.random(40)
            if chance <= 5 then
                --stick
                minetest.item_drop(ItemStack('default:stick 1'), player, pos)
            elseif chance <= 10 then
                --coal
                minetest.item_drop(ItemStack('default:coal_lump 1'), player, pos)
            elseif chance <= 12 then
                --gold
                minetest.item_drop(ItemStack('default:gold_lump 1'), player, pos)
            elseif chance <= 14 then
                --copper
                minetest.item_drop(ItemStack('default:copper_lump 1'), player, pos)
            elseif chance <= 16 then
                --iron
                minetest.item_drop(ItemStack('default:iron_lump 1'), player, pos)
            elseif chance <= 18 then 
                --mese fragment
                minetest.item_drop(ItemStack('default:mese_crystal_fragment 1'), player, pos)
            elseif chance == 19 then
                --mese crystal
                minetest.item_drop(ItemStack('default:mese_crystal 1'), player, pos)
            elseif chance == 20 then
                --mese gem
                minetest.item_drop(ItemStack('default:diamond 1'), player, pos)
            end
        elseif itemstack:get_name() == 'default:dirt' or itemstack:get_name() == 'default:dirt_with_grass' then
            itemstack:take_item()
            if itemstack:get_name() == 'default:dirt_with_grass' then
                minetest.item_drop(ItemStack('default:grass_4 1'), player, pos)
            end
            local chance = math.random(40)
            if chance <= 5 then
                --stick
                minetest.item_drop(ItemStack('default:stick 1'), player, pos)
            elseif chance <= 10 then
                --coal
                minetest.item_drop(ItemStack('default:coal_lump 1'), player, pos)
            elseif chance <= 12 then
                --gold
                minetest.item_drop(ItemStack('default:gold_lump 1'), player, pos)
            elseif chance <= 14 then
                --copper
                minetest.item_drop(ItemStack('default:copper_lump 1'), player, pos)
            elseif chance <= 16 then
                --iron
                minetest.item_drop(ItemStack('default:iron_lump 1'), player, pos)
            elseif chance <= 18 then 
                --mese fragment
                minetest.item_drop(ItemStack('default:mese_crystal_fragment 1'), player, pos)
            elseif chance == 19 then
                --mese crystal
                minetest.item_drop(ItemStack('default:mese_crystal 1'), player, pos)
            elseif chance == 20 then
                --mese gem
                minetest.item_drop(ItemStack('default:diamond 1'), player, pos)
            end
        end
        return itemstack
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
----[[Auto Top
minetest.register_node("sieve:auto_sieve_top", {
    description = "Auto Sieve Top",
    tiles = {
    	"sieve_auto_sieve_top_top.png",
    	"sieve_auto_sieve_top_bottom.png",
    	"sieve_auto_sieve_top_side.png",
    	"sieve_auto_sieve_top_side.png",
    	"sieve_auto_sieve_top_side.png",
    	"sieve_auto_sieve_top_side.png"
    },
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
--]]
----[[Auto Legs
minetest.register_node("sieve:auto_sieve_legs", {
    description = "Auto Sieve Legs",
    tiles = {
    	"sieve_auto_sieve_legs_top.png",
    	"sieve_auto_sieve_legs_bottom.png",
    	"sieve_auto_sieve_legs_side.png",
    	"sieve_auto_sieve_legs_side.png",
    	"sieve_auto_sieve_legs_side.png",
    	"sieve_auto_sieve_legs_side.png"
    },
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
        {"default:stone", "default:furnace", "default:stone"},
        {"default:stone", "", "default:stone"},
        {"default:stone", "", "default:stone"}
    }
})
minetest.log("action","Sieve: Auto Sieve Legs Loaded")
--]]
----[[Auto Sieve
minetest.register_node("sieve:auto_sieve", {
    description = "Auto Sieve",
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
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
                }
                }
})
minetest.register_craft({
    output = "sieve:auto_sieve",
    recipe = {
        {"sieve:auto_sieve_top"},
        {"sieve:auto_sieve_legs"}
    }
})
minetest.log("action","Sieve: Auto Sieve Loaded")
--]]
minetest.log("action","Sieve: Finished Load")
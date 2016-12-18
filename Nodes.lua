local function accept(stack)
    for _,v in pairs( --these are the items that are accepted as src material
        {'default:sand','default:gravel','default:desert_sand','default:dirt'})
    do
        if stack:get_name() == v then
            return true
        end
    end
    return false
end
local function updateformspec(time) 
    local formspec = "size[8,9;]list[context;src;0,0;1,1;]list[context;fuel;0,3;1,1;]list[context;dst;3,0;5,4;]image[0,1;2,2;sieve_auto_sieve_side.png]list[current_player;main;0,5;8,4;]"
    local imgs = {36,33,30,27,24,21,18,15,12,9,6,3}
    for _,v in pairs(imgs) do
        if time>=v then 
            return formspec.."image[2,1;1,3;sieve_fuel"..v..".png]"
        end
    end
    return formspec.."image[2,1;1,3;sieve_fuel0.png]"
end
local percent = { --used to define what chance an item has to give material
--{"itemstack string", exclusive top cuttoff}
--put the list in order from small to large cutoffs (like the original list)
    {"default:diamond 1", 2},
    {"default:mese_crystal 1", 4},
    {"default:mese_crystal_fragment 1", 8},
    {"default:iron_lump 1", 15},
    {"default:copper_lump 1", 25},
    {"default:gold_lump 1", 35},
    {"default:coal_lump 1", 40},
    {"default:stick 1", 50}
}
function material()
    local chance = math.random(200)
    for _,v in pairs(percent) do
        if chance<v[2] then
            return ItemStack(v[1])
        end
    end
    return nil
end

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
        local timer = minetest.get_node_timer(pos)
        if accept(itemstack) and not timer:is_started() then
            itemstack:take_item(1)
            timer:start(3)
            minetest.add_item(pos, material())
            return itemstack
        else
            return nil
        end
    end,
})
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
    groups = {choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1, tubedevice_receiver = 1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
                {-0.5, 0.1875, -0.5, 0.5, 0.19, 0.5},
                {0.5,0.5,-0.5,-0.5,0,-0.4375},
                {-0.5,0.5,-0.5,-0.4375,0,0.5},
                {0.5,0.5,0.5,-0.5,0,0.4375},
                {0.5,0.5,-0.5,0.4375,0,0.5},
                {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
                {-0.5, -0.5, 0.5, -0.4375, 0.5, 0.4375},
                {0.5, -0.5, 0.5, 0.4375, 0.5, 0.4375},
                {0.5, -0.5, -0.5, 0.4375, 0.5, -0.4375},
                },
        },

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
        "size[8,9;]"..
        "list[context;src;0,0;1,1;]"..
        "list[context;fuel;0,3;1,1;]"..
        "list[context;dst;3,0;5,4;]"..
        "image[0,1;2,2;sieve_auto_sieve_side.png]"..
        "image[2,1;1,3;sieve_fuel0.png]"..
        "list[current_player;main;0,5;8,4;]")
        local inv = meta:get_inventory()
        inv:set_size("src", 1*1)
        inv:set_size("fuel", 1*1)
        inv:set_size("dst", 5*4)
        meta:set_int("fueltime", 0)
    end,

    on_destruct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        for i, item in ipairs(inv:get_list("dst")) do
            minetest.add_item(pos, item)
        end
        minetest.add_item(pos, inv:get_stack("src", 1))
        minetest.add_item(pos, inv:get_stack("fuel", 1))
        minetest.get_node_timer(pos):stop()
    end,
    --Pipeworks Insertion-------------------------------------------------
    tube = {
        insert_object = function(pos, node, stack, direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local timer = minetest.get_node_timer(pos)
            local left
            if direction.y==-1 then
                left = inv:add_item("src", stack)
            else
                left = inv:add_item("fuel", stack)
            end

            if not timer:is_started() and inv:get_stack("fuel",1):get_count()>0 and inv:get_stack("src",1):get_count()>0 then
                timer:start(3)
            end
            return left
        end,
        can_insert = function(pos, node, stack, direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if direction.y==-1 then
                return accept(stack) and inv:room_for_item("src", stack)
            else
                return minetest.get_craft_result({method="fuel",width=1,items={stack}}).time > 0 and inv:room_for_item("fuel", stack)
            end
        end,
        connect_sides = {left= 1, right= 1, back= 1, front= 1, bottom= 1, top= 1}
    },
    input_inventory = "dst",
    after_place_node = pipeworks.after_place,
    after_dig_node = pipeworks.after_dig,
    --Manual Insertion-------------------------------------------------
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
        elseif listname == 'src' then
            if accept(stack) then
                return stack:get_count()
            else
                return 0
            end
        elseif listname == 'dst' then
            return stack:get_count()
        else
            return 0;
        end
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        if listname ~= "dst" then
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local timer = minetest.get_node_timer(pos)
            if not timer:is_started() and inv:get_stack("fuel",1):get_count()>0 and inv:get_stack("src",1):get_count()>0 then
                timer:start(3)
            end
        end
    end,
    on_timer = function(pos, formname, fields, sender)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local timer = minetest.get_node_timer(pos)
        if inv:get_stack("src",1):get_count()>0 and meta:get_int("fueltime")>=3 then
            inv:remove_item("src", inv:get_stack("src",1):take_item(1))
            local reward = material()
            if inv:room_for_item("dst", reward) then
                inv:add_item("dst", reward)
            end
        end
        meta:set_int("fueltime", meta:get_int("fueltime")-3)

        if inv:get_stack("fuel", 1):get_count()>0 and inv:get_stack("src",1):get_count()>0 and meta:get_int("fueltime")<3 then
            meta:set_int("fueltime", minetest.get_craft_result({method="fuel",width=1,items={inv:get_stack("fuel",1)}}).time)
            inv:remove_item("fuel", inv:get_stack("fuel",1):take_item(1))
        end
        meta:set_string("formspec", updateformspec(meta:get_int("fueltime")))
        return meta:get_int("fueltime")>=3
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
})
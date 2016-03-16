minetest.register_craft({
    output = "sieve:cloth_fiber 4",
    recipe = {
        {"default:leaves", "", "default:leaves"},
        {"", "default:wood", ""},
        {"default:leaves", "", "default:leaves"}
    }
})
minetest.register_craft({
    output = "sieve:mesh 1",
    recipe = {
        {"sieve:cloth_fiber", "sieve:cloth_fiber"},
        {"sieve:cloth_fiber", "sieve:cloth_fiber"},
    }
})
minetest.register_craft({
    output = "sieve:shaker_motor 2",
    recipe = {
        {"", "",""},
        {"default:cobble", "default:steel_ingot","default:cobble"},
        {"default:cobble", "default:copper_ingot","default:cobble"},
    }
})
minetest.register_craft({
    output = "sieve:shaker_frame 1",
    recipe = {
        {"default:steel_ingot", "sieve:shaker_motor","default:steel_ingot"},
        {"sieve:shaker_motor", "default:furnace","sieve:shaker_motor"},
        {"default:steel_ingot", "sieve:shaker_motor","default:steel_ingot"},
    }
})
minetest.register_craft({
    output = "sieve:hand_sieve",
    recipe = {
        {"default:stick", "default:stick", "default:stick"},
        {"default:stick", "sieve:mesh", "default:stick"},
        {"default:stick", "default:stick", "default:stick"}
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
minetest.register_craft({
    output = "sieve:auto_sieve_legs",
    recipe = {
        {"default:steel_ingot", "sieve:shaker_frame", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"}
    }
})
minetest.register_craft({
    output = "sieve:auto_sieve",
    recipe = {
        {"sieve:auto_sieve_top"},
        {"sieve:auto_sieve_legs"}
    }
})
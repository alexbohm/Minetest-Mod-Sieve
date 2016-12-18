# Minetest-Mod-Sieve
This is a simple mod for the open source game "Minetest".
Feel free to use/add your own textures (I used 32x32).
This mod is a work in progress
Depends:
	pipeworks

Acceptable Items to process:
  "default:sand"
  "default:gravel"
  "default:desert_sand"
  "default:dirt"


Crafting:
I recommend that one uses the Craft Guide mod
https://forum.minetest.net/viewtopic.php?t=2334
	Cloth Fiber:
		X= default:leaves  O= default:wood
		X   X
		  O
		X   X
	Mesh:
		X= sieve:cloth_fiber
		X X
		X X
	Hand Sieve:
		X= sieve:mesh  O= default:stick
		O O O
		O X O
		O O O
	Shaker Motor:
		X= default:cobble C= default:copper_ingot S= default:steel_ingot
		X S X
		X C X
    Shaker Frame:
    	S= default:steel_ingot M= sieve:shaker_motor F= default:furnace
    	S M S
    	M F M
    	S M S
    Auto Sieve Top:
    	S= default:steel_ingot M= sieve:mesh
    	S S S
    	S M S
    	S S S
    Auto Sieve Legs:
    	S= default:steel_ingot F= sieve:shaker_frame
    	S F S
    	S   S
    Auto Sieve:
    	L= sieve:auto_sieve_legs T= sieve:auto_sieve_top
    	T
    	L

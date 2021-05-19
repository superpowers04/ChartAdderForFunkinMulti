-- Created specifically for adding configs and songs for https://shadowmario.itch.io/funkinmulti or https://gamebanana.com/mods/44205
-- This code isn't the cleanest but should work pretty well
-- Feel free to ask for help with this and feel free to edit/redistribute this. Just don't remove the disclaimer and please give credit
-- Originally created by Superpowers04, https://gamebanana.com/members/1622031 on gamebanana and Superpowers04#3887 on Discord

f = string.format
local succ,err = pcall(function() -- Wrapping in a pcall to prevent errors from closing the CMD

-- Characters
local chars = {	
	blank=[[
		{
		"": "Generated automatically in multiplayer mod chart adder by Super",
		"clone": "", "": "Copies the offsets of a character and a few interactions, disable it by removing this line or leaving it blank",
		"no_antialiasing": false, "": "If set to true, forces antialiasing to be disabled, useful for Pixel characters",
		"sing_duration": 4, "": "Duration of character sing animation's mult, Dad clones use 6.1 while everyone else uses 4",
		"dance_idle": false, "": "Makes the character use danceRight/danceLeft animations instead of Idle, useful for Skid & Pump/GF clones",

		"scale": 1, "": "Sprite scale on common stages, online lobby and Character Select screen, Senpai uses 6 while BF-Pixel/Spirit uses 6.6, everyone else uses 1",
		"scale_pixel": 0.91, "": "Sprite scale on Pixel stages, Senpai/Spirit/BF-Pixel uses 6, everyone else uses 0.91",
		"pixel_offset_scale": 0.91, "": "Fixes the animation offsets being a bit broken on Pixel stages for non-pixel characters, usually just set this to the same value as scale_pixel. This is dumb",
		"online_offset_scale": 0.7, "": "Fixes the singing animations being a bit broken on Online Mode Lobby, Spirit/Senpai/BF-Pixel uses 1, everyone else uses 0.7. This is also dumb",

		"voices": "bf", "": "Voices to be used on Lobby singing, set this to 'custom' if you want to use custom voice files, the files should be named 'sing_left.ogg', 'sing_up.ogg', 'sing_down.ogg' and 'sing_right.ogg', and should be located in your character's folder",
		"alt_anims": false, "": "Enables alt animations like those from Parents-Christmas",
		"flip_x": %s, "": "Flips X axis from the sprite, useful for Boyfriend/Pico/Tankman clones",
		"spirit_trail": false, "": "Enables Spirit's visual effect",
		"read_only": false, "": "Hides it from character select (Both online, local mp and singleplayer), useful for decreasing your list size for characters you will never play with",

		"animations":
		[
			%s
		], "": "The idle/sing/miss animations are added automatically with the same values as Boyfriend's, you just have to add animations to this array if you want to edit something or add Hey/Scared animations to it",

		"animations_offsets":
		[			
			{
				"anim": "idle",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singUP",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singRIGHT",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singLEFT",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singDOWN",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singUPmiss",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singRIGHTmiss",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singLEFTmiss",
				"player1": [0, 0],
				"player2": [0,0]
			},
			{
				"anim": "singDOWNmiss",
				"player1": [0, 0],
				"player2": [0, 0]
			}
		], "":"These are here as a template, by default they do nothing",

		"hey_anim": "", "": "Which animation should it use for the Bopeebo 'Hey!'",
		"scared_anim": "", "": "Which animation should it use for Spooky Month stage scare",

		"common_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on common stages as Player 1 and 2",
		"pixel_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on Pixel stages as Player 1 and 2",
		"local_multiplayer_offset": [0, 0], "": "Your character's offset on the Local Multiplayer/Singleplayer Character Select screen",
		"online_offset": [0, 0], "": "Your character's offset on Online Mode lobby",
		"playername_relative": 0, "": "Relative (Y) position from the Player Name to their character on Online Mode Lobby",

		"": "Sometimes i hate my own code, good luck messing with this! I will probably convert the Animation Debug into a Character Editor someday, idk"
	}]],
	--[[ Based off of Bald BF]] boyfriend = [[
		{
		"clone": "bf", "": "Copies the offsets of a character and a few interactions, disable it by removing this line or leaving it blank",
		"no_antialiasing": false, "": "If set to true, forces antialiasing to be disabled, useful for Pixel characters",
		"sing_duration": 4, "": "Duration of character sing animation's mult, Dad clones use 6.1 while everyone else uses 4",
		"dance_idle": false, "": "Makes the character use danceRight/danceLeft animations instead of Idle, useful for Skid & Pump/GF clones",

		"scale": 1, "": "Sprite scale on common stages, online lobby and Character Select screen, Senpai uses 6 while BF-Pixel/Spirit uses 6.6, everyone else uses 1",
		"scale_pixel": 0.91, "": "Sprite scale on Pixel stages, Senpai/Spirit/BF-Pixel uses 6, everyone else uses 0.91",
		"pixel_offset_scale": 0.91, "": "Fixes the animation offsets being a bit broken on Pixel stages for non-pixel characters, usually just set this to the same value as scale_pixel. This is dumb",
		"online_offset_scale": 0.7, "": "Fixes the singing animations being a bit broken on Online Mode Lobby, Spirit/Senpai/BF-Pixel uses 1, everyone else uses 0.7. This is also dumb",

		"voices": "bf", "": "Voices to be used on Lobby singing, set this to 'custom' if you want to use custom voice files, the files should be named 'sing_left.ogg', 'sing_up.ogg', 'sing_down.ogg' and 'sing_right.ogg', and should be located in your character's folder",
		"alt_anims": false, "": "Enables alt animations like those from Parents-Christmas",
		"flip_x": true, "": "Flips X axis from the sprite, useful for Boyfriend/Pico/Tankman clones",
		"spirit_trail": false, "": "Enables Spirit's visual effect",
		"read_only": false, "": "Hides it from character select (Both online, local mp and singleplayer), useful for decreasing your list size for characters you will never play with",

		"animations":
		[
			{
				"anim": "hey",
				"name": "BF HEY",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "scared",
				"name": "BF idle shaking",
				"fps": 24,
				"loop": true,
				"indices": []
			}
		], "": "The idle/sing/miss animations are added automatically with the same values as Boyfriend's, you just have to add animations to this array if you want to edit something or add Hey/Scared animations to it",

		"animations_offsets":
		[],

		"hey_anim": "hey", "": "Which animation should it use for the Bopeebo 'Hey!'",
		"scared_anim": "scared", "": "Which animation should it use for Spooky Month stage scare",

		"common_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on common stages as Player 1 and 2",
		"pixel_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on Pixel stages as Player 1 and 2",
		"local_multiplayer_offset": [0, 0], "": "Your character's offset on the Local Multiplayer/Singleplayer Character Select screen",
		"online_offset": [0, 0], "": "Your character's offset on Online Mode lobby",
		"playername_relative": 0, "": "Relative (Y) position from the Player Name to their character on Online Mode Lobby",
	}]],
	-- Thanks to natsuki cutie*baka#1279 for these JSON's 
	mom=[[
		{
		"clone": "mom", "": "Copies the offsets of a character and a few interactions, disable it by removing this line or leaving it blank",
		"no_antialiasing": false, "": "If set to true, forces antialiasing to be disabled, useful for Pixel characters",
		"sing_duration": 6.1, "": "Duration of character sing animation's mult, Dad clones use 6.1 while everyone else uses 4",
		"dance_idle": false, "": "Makes the character use danceRight/danceLeft animations instead of Idle, useful for Skid & Pump/GF clones",

		"scale": 1, "": "Sprite scale on common stages, online lobby and Character Select screen, Senpai uses 6 while BF-Pixel/Spirit uses 6.6, everyone else uses 1",
		"scale_pixel": 0.91, "": "Sprite scale on Pixel stages, Senpai/Spirit/BF-Pixel uses 6, everyone else uses 0.91",
		"pixel_offset_scale": 0.91, "": "Fixes the animation offsets being a bit broken on Pixel stages for non-pixel characters, usually just set this to the same value as scale_pixel. This is dumb",
		"online_offset_scale": 0.7, "": "Fixes the singing animations being a bit broken on Online Mode Lobby, Spirit/Senpai/BF-Pixel uses 1, everyone else uses 0.7. This is also dumb",

		"voices": "mom", "": "Voices to be used on Lobby singing, set this to 'custom' if you want to use custom voice files, the files should be named 'sing_left.ogg', 'sing_up.ogg', 'sing_down.ogg' and 'sing_right.ogg', and should be located in your character's folder",
		"alt_anims": false, "": "Enables alt animations like those from Parents-Christmas",
		"flip_x": false, "": "Flips X axis from the sprite, useful for Boyfriend/Pico clones",

		"animations":
		[
			{
				"anim": "idle",
				"name": "Mom Idle",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUP",
				"name": "Mom Up Pose",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFT",
				"name": "Mom Left Pose",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHT",
				"name": "Mom Pose Left",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWN",
				"name": "MOM DOWN POSE",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUPmiss",
				"name": "Mom Up Pose",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFTmiss",
				"name": "Mom Left Pose",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHTmiss",
				"name": "Mom Pose Left",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWNmiss",
				"name": "MOM DOWN POSE",
				"fps": 24,
				"loop": false,
				"indices": []
			}
		], "": "The idle/sing/miss animations are added automatically with the same values as Boyfriend's for preventing a dumb crash, you just have to add animations to this array if you want to edit something or add Hey/Scared animations to it",
		"hey_anim": "", "": "Which animation should it use for the Bopeebo 'Hey!'",
		"scared_anim": "", "": "Which animation should it use for Spooky Month stage scare",

		"animations_offsets":
		[
			{
				"anim": "idle",
				"player1": [0, 0],
				"player2": [0, 0]
			},
			{
				"anim": "singUP",
				"player1": [14, 71],
				"player2": [34, 71]
			},
			{
				"anim": "singRIGHT",
				"player1": [10, -60],
				"player2": [10, -40]
			},
			{
				"anim": "singLEFT",
				"player1": [85, -23],
				"player2": [170, -23]
			},
			{
				"anim": "singDOWN",
				"player1": [20, -160],
				"player2": [60, -160]
			},
			{
				"anim": "singUPmiss",
				"player1": [14, 71],
				"player2": [34, 71]
			},
			{
				"anim": "singRIGHTmiss",
				"player1": [10, -60],
				"player2": [10, -40]
			},
			{
				"anim": "singLEFTmiss",
				"player1": [85, -23],
				"player2": [170, -23]
			},
			{
				"anim": "singDOWNmiss",
				"player1": [20, -160],
				"player2": [60, -160]
			}
		],

		"common_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on common stages as Player 1 and 2",
		"pixel_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on Pixel stages as Player 1 and 2",
		"local_multiplayer_offset": [0, -200], "": "Your character's offset on the Local Multiplayer/Singleplayer Character Select screen",
		"online_offset": [0, -140], "": "Your character's offset on Online Mode lobby",
		"playername_relative": 200, "": "Relative (Y) position from the Player Name to their character on Online Mode Lobby",

		"": "Sometimes i hate my own code, good luck messing with this! I will probably convert the Animation Debug into a Character Editor someday, idk"
	}]],
	pico=[[
		{
			"clone": "pico",
			"sing_duration": 4,
			"scale": 1,
			"scale_pixel": 0.91,
			"pixel_offset_scale": 0.91,
			"online_offset_scale": 0.7,

			"voices": "pico",
			"flip_x": true,

			"animations":
			[
				{
					"anim": "idle",
					"name": "Pico Idle Dance",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singUP",
					"name": "pico Up note",
					"fps": 24,
					"loop": false,
					"indices": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
				},
				{
					"anim": "singLEFT",
					"name": "Pico Note Right",
					"fps": 24,
					"loop": false,
					"indices": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				},
				{
					"anim": "singRIGHT",
					"name": "Pico NOTE LEFT",
					"fps": 24,
					"loop": false,
					"indices": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				},
				{
					"anim": "singDOWN",
					"name": "Pico Down Note",
					"fps": 24,
					"loop": false,
					"indices": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
				},
				{
					"anim": "singUPmiss",
					"name": "pico Up note miss",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singLEFTmiss",
					"name": "Pico Note Right Miss", 
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singRIGHTmiss",
					"name": "Pico NOTE LEFT miss",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singDOWNmiss",
					"name": "Pico Down Note MISS",
					"fps": 24,
					"loop": false,
					"indices": []
				}
			],
			"hey_anim": "",
			"scared_anim": "",

			"animations_offsets":
			[
				{
					"anim": "idle",
					"player1": [-220, 0],
					"player2": [0, 0]
				},
				{
					"anim": "singUP",
					"player1": [-180, 20],
					"player2": [-29, 27]
				},
				{
					"anim": "singRIGHT",
					"player1": [-240, 0],
					"player2": [-88, -13]
				},
				{
					"anim": "singLEFT",
					"player1": [-90, -10],
					"player2": [20, -8]
				},
				{
					"anim": "singDOWN",
					"player1": [-100, -70],
					"player2": [171, -80]
				},
				{
					"anim": "singUPmiss",
					"player1": [-180, 40],
					"player2": [-29, 27]
				},
				{
					"anim": "singRIGHTmiss",
					"player1": [-220, 30],
					"player2": [-88, -13]
				},
				{
					"anim": "singLEFTmiss",
					"player1": [-180, 10],
					"player2": [20, 11]
				},
				{
					"anim": "singDOWNmiss",
					"player1": [-120, -20],
					"player2": [171, -70]
				}
			],

			"common_stage_offset": [0, 0, 0, 0],
			"pixel_stage_offset": [0, 0, 0, 0],
			"local_multiplayer_offset": [-105, -60],
			"online_offset": [-68, -24],
			"playername_relative": 10
		}
	]],
	dad=[[{
		"clone": "dad",
		"no_antialiasing": false,
		"sing_duration": 6.1,
		"dance_idle": false,

		"scale": 1,
		"scale_pixel": 0.91,
		"pixel_offset_scale": 0.91,
		"online_offset_scale": 0.7,

		"voices": "dad",
		"alt_anims": false,
		"flip_x": false,

		"animations":
		[
			{
				"anim": "idle",
				"name": "Dad idle dance",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUP",
				"name": "Dad Sing Note UP",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFT",
				"name": "Dad Sing Note LEFT",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHT",
				"name": "Dad Sing Note RIGHT",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWN",
				"name": "Dad Sing Note DOWN",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUPmiss",
				"name": "Dad Sing Note UP",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFTmiss",
				"name": "Dad Sing Note LEFT",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHTmiss",
				"name": "Dad Sing Note RIGHT",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWNmiss",
				"name": "Dad Sing Note DOWN",
				"fps": 24,
				"loop": false,
				"indices": []
			}
		],
		"hey_anim": "",
		"scared_anim": "",

		"animations_offsets":
		[
		],

		"common_stage_offset": [0, 0, 0, 0],
		"pixel_stage_offset": [0, 0, 0, 0],
		"local_multiplayer_offset": [0, 50],
		"online_offset": [0, 0],
		"playername_relative": 0
	}
	]],
	spooky=[[
		{
			"clone": "spooky", "": "Copies the offsets of a character and a few interactions, disable it by removing this line or leaving it blank",
			"no_antialiasing": false, "": "If set to true, forces antialiasing to be disabled, useful for Pixel characters",
			"sing_duration": 4, "": "Duration of character sing animation's mult, Dad clones use 6.1 while everyone else uses 4",
			"dance_idle": true, "": "Makes the character use danceRight/danceLeft animations instead of Idle, useful for Skid & Pump/GF clones",

			"scale": 1, "": "Sprite scale on common stages, online lobby and Character Select screen, Senpai uses 6 while BF-Pixel/Spirit uses 6.6, everyone else uses 1",
			"scale_pixel": 0.91, "": "Sprite scale on Pixel stages, Senpai/Spirit/BF-Pixel uses 6, everyone else uses 0.91",
			"pixel_offset_scale": 0.91, "": "Fixes the animation offsets being a bit broken on Pixel stages for non-pixel characters, usually just set this to the same value as scale_pixel. This is dumb",
			"online_offset_scale": 0.7, "": "Fixes the singing animations being a bit broken on Online Mode Lobby, Spirit/Senpai/BF-Pixel uses 1, everyone else uses 0.7. This is also dumb",

			"voices": "spooky", "": "Voices to be used on Lobby singing, set this to 'custom' if you want to use custom voice files, the files should be named 'sing_left.ogg', 'sing_up.ogg', 'sing_down.ogg' and 'sing_right.ogg', and should be located in your character's folder",
			"alt_anims": false, "": "Enables alt animations like those from Parents-Christmas",
			"flip_x": false, "": "Flips X axis from the sprite, useful for Boyfriend/Pico clones",

			"animations":
			[
			    {
					"anim": "danceLeft",
					"name": "spooky dance idle",
					"fps": 24,
					"loop": false,
					"indices": [0, 1, 2, 3, 4, 5]
				},
				{
					"anim": "danceRight",
					"name": "spooky dance idle",
					"fps": 24,
					"loop": false,
					"indices": [6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
				},
				{
					"anim": "singUP",
					"name": "spooky UP NOTE",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singLEFT",
					"name": "note sing left",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singRIGHT",
					"name": "spooky sing right",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singDOWN",
					"name": "spooky DOWN note",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singUPmiss",
					"name": "spooky UP NOTE",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singLEFTmiss",
					"name": "note sing left",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singRIGHTmiss",
					"name": "spooky sing right",
					"fps": 24,
					"loop": false,
					"indices": []
				},
				{
					"anim": "singDOWNmiss",
					"name": "spooky DOWN note",
					"fps": 24,
					"loop": false,
					"indices": []
				}
			], "": "The idle/sing/miss animations are added automatically with the same values as Boyfriend's for preventing a dumb crash, you just have to add animations to this array if you want to edit something or add Hey/Scared animations to it",
			"hey_anim": "", "": "Which animation should it use for the Bopeebo 'Hey!'",
			"scared_anim": "", "": "Which animation should it use for Spooky Month stage scare",

			"animations_offsets":
			[
				{
					"anim": "singUP",
					"player1": [-57, 24],
					"player2": [-15, 24]
				},
				{
					"anim": "singRIGHT",
					"player1": [-75, -20],
					"player2": [-85, -14]
				},
			    {
					"anim": "singDOWN",
					"player1": [-24, -138],
					"player2": [47, -138]
				},
				{
					"anim": "singLEFT",
					"player1": [97, -10],
					"player2": [137, -24]
				},
				{
					"anim": "singUPmiss",
					"player1": [-57, 24],
					"player2": [-15, 24]
				},
				{
					"anim": "singRIGHTmiss",
					"player1": [-75, -20],
					"player2": [-85, -14]
				},
			    {
					"anim": "singDOWNmiss",
					"player1": [-24, -138],
					"player2": [47, -138]
				},
				{
					"anim": "singLEFTmiss",
					"player1": [97, -10],
					"player2": [137, -24]
				}
			],

			"common_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on common stages as Player 1 and 2",
			"pixel_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on Pixel stages as Player 1 and 2",
			"local_multiplayer_offset": [0, -50], "": "Your character's offset on the Local Multiplayer/Singleplayer Character Select screen",
			"online_offset": [0, 0], "": "Your character's offset on Online Mode lobby",
			"playername_relative": 0, "": "Relative (Y) position from the Player Name to their character on Online Mode Lobby",

			"": "Sometimes i hate my own code, good luck messing with this! I will probably convert the Animation Debug into a Character Editor someday, idk"
		}
	]],
	senpai=[[
		{
		"clone": "senpai",
		"sing_duration": 4,
		"no_antialiasing": true,
		"scale": 6,
		"scale_pixel": 6,
		"pixel_offset_scale": 1,
		"online_offset_scale": 1,

		"voices": "custom",
		"flip_x": false,

		"animations":
		[
			{
				"anim": "idle",
				"name": "Senpai Idle",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUP",
				"name": "SENPAI UP NOTE",
				"fps": 24,
				"loop": true,
				"indices": []
			},
			{
				"anim": "singLEFT",
				"name": "SENPAI LEFT NOTE",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHT",
				"name": "SENPAI RIGHT NOTE",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWN",
				"name": "SENPAI DOWN NOTE",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUPmiss",
				"name": "SENPAI UP note miss",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFTmiss",
				"name": "SENPAI LEFT note miss",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHTmiss",
				"name": "SENPAI RIGHT note miss",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWNmiss",
				"name": "SENPAI DOWN note miss",
				"fps": 24,
				"loop": false,
				"indices": []
			}
		],
		"hey_anim": "",
		"scared_anim": "",

		"animations_offsets": [],

		"common_stage_offset": [0, 30, 0, 0],
		"pixel_stage_offset": [0, 30, 0, 0],
		"local_multiplayer_offset": [180, -30],
		"online_offset": [75, 0],
		"playername_relative": 170
		}
	]],
	gf=[[
	{
		"clone": "gf", "": "Copies the offsets of a character and a few interactions, disable it by removing this line or leaving it blank",
		"no_antialiasing": false, "": "If set to true, forces antialiasing to be disabled, useful for Pixel characters",
		"sing_duration": 4, "": "Duration of character sing animation's mult, Dad clones use 6.1 while everyone else uses 4",
		"dance_idle": true, "": "Makes the character use danceRight/danceLeft animations instead of Idle, useful for Skid & Pump/GF clones",

		"scale": 1, "": "Sprite scale on common stages, online lobby and Character Select screen, Senpai uses 6 while BF-Pixel/Spirit uses 6.6, everyone else uses 1",
		"scale_pixel": 0.91, "": "Sprite scale on Pixel stages, Senpai/Spirit/BF-Pixel uses 6, everyone else uses 0.91",
		"pixel_offset_scale": 0.91, "": "Fixes the animation offsets being a bit broken on Pixel stages for non-pixel characters, usually just set this to the same value as scale_pixel. This is dumb",
		"online_offset_scale": 0.7, "": "Fixes the singing animations being a bit broken on Online Mode Lobby, Spirit/Senpai/BF-Pixel uses 1, everyone else uses 0.7. This is also dumb",

		"voices": "gf", "": "Voices to be used on Lobby singing, set this to 'custom' if you want to use custom voice files, the files should be named 'sing_left.ogg', 'sing_up.ogg', 'sing_down.ogg' and 'sing_right.ogg', and should be located in your character's folder",
		"alt_anims": false, "": "Enables alt animations like those from Parents-Christmas",
		"flip_x": false, "": "Flips X axis from the sprite, useful for Boyfriend/Pico clones",

		"animations":
		[
			{
				"anim": "danceLeft",
				"name": "GF Dancing Beat0",
				"fps": 24,
				"loop": false,
				"indices": [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
			},
			{
				"anim": "danceRight",
				"name": "GF Dancing Beat0",
				"fps": 24,
				"loop": false,
				"indices": [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29]
			},
			{
				"anim": "singUP",
				"name": "GF Up Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFT",
				"name": "GF left note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHT",
				"name": "GF Right Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWN",
				"name": "GF Down Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singUPmiss",
				"name": "GF Up Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singLEFTmiss",
				"name": "GF left note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singRIGHTmiss",
				"name": "GF Right Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
				"anim": "singDOWNmiss",
				"name": "GF Down Note",
				"fps": 24,
				"loop": false,
				"indices": []
			},
		    {
				"anim": "cheer",
				"name": "GF Cheer",
				"fps": 24,
				"loop": false,
				"indices": []
			},
			{
			   "anim": "scared",
			   "name": "GF FEAR",
			   "fps": 24,
			   "loop": false,
			   "indices": []
			},
			{
			   "anim": "hairBlow",
			   "name": "GF Dancing Beat Hair blowing",
			   "fps": 24,
			   "loop": false,
			   "indices": []
			},
			{
			   "anim": "hairFall",
			   "name": "GF Dancing Beat Hair Landing",
			   "fps": 24,
			   "loop": false,
			   "indices": []
			}
		], 
		"hey_anim": "cheer", 
		"scared_anim": "scared",

		"animations_offsets":
		[
		    {
				"anim": "singLEFT",
				"player1": [0, -19],
				"player2": [0, -19]
			},
			{
				"anim": "singRIGHT",
				"player1": [0, -20],
				"player2": [0, -20]
			},
			{
				"anim": "singUP",
				"player1": [0, 4],
				"player2": [0, 4]
			},
			{
				"anim": "singLEFTmiss",
				"player1": [0, -19],
				"player2": [0, -19]
			},
			{
				"anim": "singRIGHTmiss",
				"player1": [0, -20],
				"player2": [0, -20]
			},
			{
				"anim": "singUPmiss",
				"player1": [0, 4],
				"player2": [0, 4]
			},
			{
				"anim": "singDOWNmiss",
				"player1": [0, -20],
				"player2": [0, -20]
			}
		],

		"common_stage_offset": [0, 0, 0, 0], "": "Your character's offset ingame on common stages as Player 1 and 2",
		"pixel_stage_offset": [0, 50, 0, 50], "": "Your character's offset ingame on Pixel stages as Player 1 and 2",
		"local_multiplayer_offset": [0, 0], "": "Your character's offset on the Local Multiplayer/Singleplayer Character Select screen",
		"online_offset": [-80, -115], "": "Your character's offset on Online Mode lobby",
		"playername_relative": 100, "": "Relative (Y) position from the Player Name to their character on Online Mode Lobby",

		"": "Sometimes i hate my own code, good luck messing with this! I will probably convert the Animation Debug into a Character Editor someday, idk"
	}]]
}
chars.init = function(self) -- Just here to prevent repeating code
	
	self.bf = self.boyfriend
	self.bfcar = self.boyfriend
	self.bfchristmas = self.boyfriend
	self.spookies = self.spooky
	self.spookeez = self.spooky
	self.momcar = self.mom
	self.weeb = self.senpai
	self['bf-car'] = self.boyfriend
	self['mom-car'] = self.mom
	self['mom-assets'] = self.mom
	self['mom_assets'] = self.mom
	self['momassets'] = self.mom
	self['daddy-dearest'] = self.dad
	self['daddy_dearest'] = self.dad
	self['daddydearest'] = self.dad
	self['daddy'] = self.dad
	self['spooky_kids_assets'] = self.spooky
	self['spooky_kids'] = self.spooky
	self['spooky-kids-assets'] = self.spooky
	self['spooky-kids'] = self.spooky
	self['pico_fnf_assetss'] = self.pico
	self['pico_fnf_assets'] = self.pico
	self['pico_fnf'] = self.pico
	self['pico-fnf-assetss'] = self.pico
	self['pico-fnf-assets'] = self.pico
	self['pico-fnf'] = self.pico
	self['gf-assets'] = self.gf
	self['gf_assets'] = self.gf
	self['girlfriend'] = self.gf
	self['gf-christmas'] = self.gf
	self['gfchristmas'] = self.gf
end
chars:init()
local animpatts = {
	["idle"]='<SubTexture name="([^"]-[iI][dD][lL][eE][^"]-)%d%d%d%d" .-/>',
	["singRIGHT"]='<SubTexture name="([^"]-[Rr][iI][gG][hH][tT][^"]-)%d%d%d%d" .-/>',
	["singLEFT"]='<SubTexture name="([^"]-[lL][eE][fF][tT][^"]-)%d%d%d%d" .-/>',
	["singDOWN"]='<SubTexture name="([^"]-[Dd][oO][wW][nN][^"]-)%d%d%d%d" .-/>',
	["singUP"]='<SubTexture name="([^"]-[uU][pP][^"]-)%d%d%d%d" .-/>',
} -- All the animation patterns used for looking for animation id's
local charaliases = {
	['boyfriend'] = 'bf',

}
local configjson = [[{
	"icon":%q,
	"icon_2": "pico",
	"stage":%q,
	"name":%q,
	"note":"Created using multiplayer mod chart adder by Super, Do not redistribute this file."
}]]

-- Move function, compensate for Windows using move instead of mv

function mv(from,to)
	if iswindows then
		os.execute(f('move %q %q',from,to))
	else
		os.execute(f('mv %q %q',from,to))
	end
end
function question(options) -- Function for grabbing an answer
	local answer = string.lower(io.read())
	if type(options) == 'string' then
		if answer ~= options then return true else return false end
	elseif type(options) == 'number' then
		if tonumber(answer) ~= options then return true else return false end
	elseif type(options) == 'table' then
		for k,v in pairs(options) do
			if tostring(v) == answer then return true end
		end
		return false
	end
	return false
end
function fileexist(file)
	if not file then return false end
	local fi = io.open(file,'r')
	if fi then
		return true
	else
		return false
	end
end
function getlist(path) -- function to make things cleaner
	-- if legacy then path = path .. 'charts/' end
	local addstr = "" 
	local configcount = 0
	local count = 0
	for d in io.popen(f(dircommand,path)):lines() do -- This method is inefficient but makes sure that all songs are added to songs.txt
		if (not string.match(addstr,d) or string.sub(d,-3) == '.ogg') and not string.match(d,'%!') then
			local name = d
			d = path .. d
			print(d)

			local exists = false
			if iswindows then -- Compensation for Windows treating Dirs differently than Unix, Dammit Windows....
				exists = io.open(d .. "Inst.ogg",'r') or io.open(d .. "Voices.ogg",'r') or io.open(d .. "/" .. name .. ".json",'r') or io.open(d .. "/config.json",'r')
			else
				exists = io.open(d,'r')
			end
			if exists then
				local code = false
				if not iswindows then -- Compensation for Windows treating Dirs differently than Unix, Dammit Windows....
					_,_,code =  io.open(d,'r'):read() -- Open file for code
				end

				if iswindows or (code and tostring(code) == '21') then -- Code 21 stands for Directory, check if 'file' is Directory. Skip if on Windows as Windows treats Dirs differently than Unix, Dammit Windows....
		 			if not io.open(d .. "Inst.ogg",'r') or io.open(d .. "Voices.ogg",'r') then 
		 				if io.open(f("%s/%s_Inst.ogg",d,name),'r') then -- Rename NAME_Inst.ogg to Inst.ogg
		 					mv(f("%s/%s_Inst.ogg",d,name),f('%s/Inst.ogg',d))
		 				end
		 				if io.open(f("%s/%s_Inst.ogg",d,name),'r') then -- Rename NAME_Voices.ogg to Voices.ogg
		 					mv(f("%s/%s_Inst.ogg",d,name),f('%s/Inst.ogg',d))
		 				end
		 			end
		 			if not io.open(f("%s/%s.json",d,name),'r') then
		 				print(f('%q is missing a %s.json, this could cause crashing!',d,name))
		 			end
		 			if not io.open(d .. "/config.json")  then -- Add config if missing

						print('Adding config to ' .. d)
						local cfg = {
							icon='pico',
							stage='stage'
						}
						if advancedmode then
							print(f('\n%s needs a icon, Pico is used by default and as a fallback.\nPlease enter a character icon. Press Enter to skip and use pico',name))
							local a = string.lower(io.read())
							if charaliases[a] then cfg.icon = charaliases[a] else cfg.icon = a end
							-- TODO Add stages table and require picking from them		
						end
						local djson = f(configjson,cfg.icon,cfg.stage,name)
						local file = io.open(d .. '/config.json','w')
						file:write(djson)
						file:close()
						configcount = configcount + 1
					end
					count = count + 1
					addstr = name .. '\n' .. addstr -- Add to songs.txt buffer
				elseif string.sub(d,-3) == 'ogg' then -- Rename and move 'Inst' and 'Voices' files
					local n,t = string.match(name,'(.-)_(Inst).ogg') -- Matches with SONGNAME_Inst.ogg
					if not t or not n then n,t = string.match(name,'(.-)_(Voices).ogg') end  -- Matches with SONGNAME_Voices.ogg
					if n and t then
						print(f("Moving %q to %q, If it isn't detected then rerun me!",d,f('%s%s/%s.ogg',path,n,t)))
						mv(d,f('%s%s/%s.ogg',path,string.lower(n),t))
					end
				end
			else
				print(f("%q Seems to be missing or doesn't have a Inst,Voices or '%s.json'",d,name))
			end
		end
	end
	return addstr,count,configcount
end
function isdir(path)
	if iswindows then -- Compensation for Windows treating Dirs differently than Unix, Dammit Windows....
		-- return io.popen([[if exist "%s/*" echo true]],'r'):read() ~= '' -- took me 5 hours to get this line and it's pretty inefficient, not using it
		local _,_,code = io.open(path,'r')
		if not code or code ~= 13 then return false end
		return true -- Honestly, I give up, this will incorrectly return true if a file doesn't have permission but I don't know any other fast ways of doing it. It's very unlikely for there to be permission issues
	else
		local code = false
		local succ = pcall(function() _,_,code = io.open(path,'r'):read() end)
		if not succ then return false end
		return (code and code == 21)
	end
	return false
end

function getlistchar(path) -- function to make things cleaner
	local addstr = "" 
	local configcount = 0
	local count = 0
	for d in io.popen(f(dircommand,path)):lines() do -- This method is inefficient but makes sure that all songs are added to songs.txt
		if (not string.match(addstr,d) or string.sub(d,-3) == '.ogg') and not string.match(d,'%!') then
			local name = d
			d = path .. d
			print(d)
			

			if fileexist(d) or isdir(d) then
				local code = false



				if isdir(d) then -- Function for checking if it's a directory
					local contain = '\n' .. io.popen(f(dircommand,d),'r'):read('*a') -- Folder contents
					local json = chars.boyfriend -- Init var for config
					local char = string.match(contain,'\n([^%.\n]-)%.xml') -- Grab name of XML
					hasconfig = fileexist(d .. "/config.json")
					-- print(char)
					if char and (not hasconfig) then 
						if not config then
							if chars[string.lower(char)] then -- Check if XML is in Chars
								json = chars[string.lower(char)]
								print(f('%s contains a recognised XML, renaming and using %s(or their respective config) as a config base',name,char)) 
							else
								print(f("\n%s does not contain a XML with a known character(It has %s), Would you like to try automatically detecting what animations to use?\nThis will not setup offsets, you probably will have to do that manually\nBoyfriend's animations will be used otherwise\nIf you don't then just press enter, otherwise type 'y' or 'yes'",name,char))
								local autodet = question({'yes','y','ye'})
								if autodet then
									local xmlfile = ""
									local succ,err = pcall(function() xmlfile = io.open(f('%s/%s.xml',d,char)):read('*a') end) -- Open file in catched environment
									if succ then
										if xmlfile ~= "" then 
											local animids = {}
											local err = false
											local animlist = {}
											for k,v in pairs(animpatts) do
												local animid = string.match(xmlfile,v)
												if not animid then -- Unable to find animation id
													err = k
													break
												end
												table.insert(animlist,f('		{\n			"anim": %q,\n			"name": %q,\n			"fps": 24,\n			"loop": true,\n			"indices": []\n		}',k,animid) )-- Add anim info to list
											end
											if not err then
												print(f("Should the character be flipped? If it's a Boyfriend/Pico/Tankman clone, then Yes otherwise, no\nY to set to true and anything else to set it to false"))
												local flipx = question({'yes','y','ye','true'})
												json = string.format(chars.blank,flipx,table.concat(animlist,',\n'))
												print(f('Successfully formatted config for %s',name))
											else
												print(f('Unable to find animation ID for %s, defaulting to boyfriend XML',k)) -- Unable to find animation id
											end
										else
											print(f('The XML came back as empty! Defaulting to boyfriend XML'))
										end
									else
										print(f('Something went wrong when trying to open the XML, Error:%s, Char:%q,Dir:%q\ndefaulting to boyfriend XML',err,char,d)) -- XML couldn't be opened
									end
									print('Press enter to continue')
									io.read()
								end
							end
						end
						if char ~= 'character' then 
							mv(f('%s/%s.xml',d,char),f('%s/character.xml',d))
							mv(f('%s/%s.png',d,char),f('%s/character.png',d))
						end
					end
		 			if not hasconfig and char then -- Add config if missing

						print(f('Adding config to %s',name))
						
						local file = io.open(f('%s/config.json',d),'w')
						file:write(json)
						file:close()
						configcount = configcount + 1
					elseif not char then
						print(f('%s does not contain any character files.',name))
					end
					count = count + 1
					-- addstr = name .. '\n' .. addstr -- Add to characters.txt buffer
				end
			else
				print(f("%q does not contain any character files or is invalid.",d,name))
			end
		end
	end
	return addstr,count,configcount
end
-- Checking Operating system

iswindows = true
if io.open('/dev','r') then
	iswindows = false
end


-- Warning

if not io.open('./hasusedmmcabs','r') then
	local accept = "dowhqudhqhdiwqhduqhdwu"
	while accept ~= "yes" do
		if iswindows then os.execute('cls') else os.execute('clear') end
		if accept ~= "dowhqudhqhdiwqhduqhdwu" then print('Please reread the warning!\n\n') end
		print([[I see this is your first time running this. Please read this, this explains how to use it and other important info
Important Stuff ----------

 This is meant for personal use only, DO NOT USE THIS AND THEN POST ANYTHING THIS MAKES ONTO GAMEBANANA OR ANY OTHER SITE UNLESS STRICTLY ALLOWED BY THE AUTHOR.
 Any mods made with this will probably get withheld for being low quality.
 This will always make the stage set to "Stage" and the character icon to Pico for any charts missing a config
 This wipes the songs.txt every time it's run.
 Songs will usually be listed in reverse alphabetical order.
 
Adding a Chart ----------

 (/'s stand for a folder for example mods/charts means the charts folder in your mods folder)
 To add charts, make a new folder named the song in your mods/charts folder, grab the chart from the mod(Commonly found under the Data/SONGSNAME folder) and then paste it into the folder you created,
 Copy the Inst and Voices into the folder(Or copy the SONGNAME_Voices and SONGNAME_Inst to the main charts folder and the script will handle it)
 Run the script and then check your game
 You can disable charts by adding a ! to it's name and the script will ignore it
 If the chart skips randomly and there's no song then make sure to have the Inst and Voices as OGG files and that they're in the folder for the chart

This tool is not garrenteed to work with all charts. Some charts may crash the game or be unusable with the Multiplayer mod
If you end up having any issues with this, feel free to comment on the Gamebanana page or DM me on Discord(Superpowers04#3887)/Gamebanna(Superpowers04)

Type 'yes' and press enter to continue and to never show this again]]) -- Disclaimer, Please don't remove this if you're modifying this.
		accept = string.lower(io.read())
		
	end
	io.open('./hasusedmmcabs','w'):write('') -- Prevents disclaimer from popping up again
end



dircommand = 'dir -1 %q'
if iswindows then dircommand = 'dir %q /b' end

-- Finding path for charts/songs
local path = "./"
if fileexist('./filepath.txt','r') then
	path,legacy = string.match(io.open('./filepath.txt','r'):read('*a'),'path="(.-)"\nlegacy=(.+)') 
	if not path then path,legacy = io.open('./filepath.txt','r'):read('*a'),true end
end

if not fileexist(path .. 'songs.txt') then
	if fileexist('../mods/songs.txt') then -- 3.2+
		path = '../mods/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=false',path))
	elseif fileexist('./mods/songs.txt') then
		path = './mods/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=false',path))
	-- Legacy support, or 3.1-
	elseif fileexist('../mods/charts/songs.txt') then
		path = '../mods/charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
		legacy = true
	elseif fileexist('./mods/charts/songs.txt') then
		path = './mods/charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
		legacy = true
	elseif fileexist('../charts/songs.txt') then
		path = '../charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
		legacy = true
	else

		print("This script is unable to find songs.txt! \nPlease put everything from the zip in a new folder next to your mods folder, or put it next to 'funkinmulti.exe'.\n If you're unable to figure this out or it continues to cause issues then put the path to the charts folder in a file named 'filepath.txt' and then try again \nThis will only work with the Multiplayer mod.\nNo actions have been taken. Press enter to exit")
		return io.read()
	end
end
-- print(legacy)
if legacy == 'true' then legacy = true elseif legacy ~= true then legacy = false end -- check if legacy, if so then set it, else don't
-- Actually formatting songs.txt and adding config files
local skip = false
advancedmode = false
if not legacy then
	print([[It seems you're using 3.2, would you like to skip generating charts and just generate characters?
Press S and then Enter to skip or Press enter to continue]])
	skip = question({'s','sk','ski','skip','y','yes'})
end
if (not skip) or legacy then
	print([[Would you like to manually specify icons or stages?
By default icons are set to 'Pico' and stages are set to 'Stage'
If you do not understand this or don't then just press enter, otherwise type 'y' or 'yes']])
	advancedmode = question({'yes','y','ye'}) -- Advanced mode, For people who want to select the icons or stage
	if legacy then
		chartlist,chartcount,chartcfgcount = getlist(path)
	else
		chartlist,chartcount,chartcfgcount = getlist(path .. 'charts/')
	end
	if chartlist then 
		local charts = io.open(path .. 'songs.txt','w')
		charts:write(chartlist) -- Save buffer
		charts:close()
		print(f('Currently loaded charts/songs:\n%s',chartlist))
		print(f([[Entered %i songs into charts.txt, Added configs to %i songs.
		All the songs/charts listed above should appear ingame, if several do not then check your songs.txt, Try removing every song but the ones causing an issue, and then once you figure out which one is causing it, try removing the config from it and making sure the first character is capitalized, Not all songs need this though. You can edit the songs.txt while the game is running]],chartcount,chartcfgcount))
		if legacy then print('Press enter to close') else print('Press enter to continue') end
		io.read()
	end
end
if not legacy then 
	print([[It seems you're using 3.2, Would you like to generate characters?
Press S and then Enter to skip or Press enter to continue]])
	skip = question({'s','sk','ski','skip','y','yes'})

	if not skip then
		local charlist,charcount,charcfgcount = getlistchar(path.. 'characters/') -- Adds characters/ to check if not in legacy
		if charlist then 
			-- local charsf = io.open(path .. 'characters.txt','w')
			-- charsf:write(charlist) -- Save buffer
			-- charsf:close()
			-- print(f('Currently loaded chars:\n%s',charlist))
			print(f([[Found and scanned %i characters, Added configs to %i characters.]],charcount,charcfgcount))
			print('Press enter to close')
			io.read()
		end
	end
end
end) 
if not succ then 
	print(f('%s\nSomething went wrong, Please report this! Press enter to exit',err))
	io.read()
end

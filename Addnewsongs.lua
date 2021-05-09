-- Created specifically for adding configs and songs for https://shadowmario.itch.io/funkinmulti or https://gamebanana.com/mods/44205
-- This code isn't the cleanest but should work pretty well
-- Feel free to ask for help with this and feel free to edit/redistribute this. Just don't remove the disclaimer and please give credit
-- Originally created by Superpowers04, https://gamebanana.com/members/1622031 on gamebanana and Superpowers04#3887 on Discord

f = string.format
local succ,err = pcall(function() -- Wrapping in a pcall to prevent errors from closing the CMD

-- Move function, compensate for Windows using move instead of mv

function mv(from,to)
	if iswindows then
		os.execute(f('move %q %q',from,to))
	else
		os.execute(f('mv %q %q',from,to))
	end
end
function getlist(path)
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
						local djson = f([[{"icon":"pico","stage":"stage","name":%q,"note":"Created using multiplayer mod chart adder by Super, Do not redistribute this file."}]],name)
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
if io.open('./filepath.txt','r') then
	path,legacy = string.match(io.open('./filepath.txt','r'):read(),'path="(.-)"\nlegacy=(.-)') 
	if not path then path,legacy = io.open('./filepath.txt','r'):read(),true end
end
if not io.open(path .. 'songs.txt','r') then
	if io.open('../mods/songs.txt','r') then
		path = '../mods/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=false',path))
	elseif io.open('./mods/songs.txt','r') then
		path = './mods/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=false',path))
	-- Legacy support
	elseif io.open('../mods/charts/songs.txt','r') then
		path = '../mods/charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
	elseif io.open('./mods/charts/songs.txt','r') then
		path = './mods/charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
	elseif io.open('../charts/songs.txt','r') then
		path = '../charts/'
		fp = io.open('./filepath.txt','w')
		fp:write(f('path=%q\nlegacy=true',path))
	else

		print("This script is unable to find songs.txt! \nPlease put everything from the zip in a new folder next to your mods folder, or put it next to 'funkinmulti.exe'.\n If you're unable to figure this out or it continues to cause issues then put the path to the charts folder in a file named 'filepath.txt' and then try again \nThis will only work with the Multiplayer mod.\nNo actions have been taken. Press enter to exit")
		return io.read()
	end

end
if legacy == 'true' then legacy = true else legacy = false end
-- Actually formatting songs.txt and adding config files


if not legacy then 
	chartlist,chartcount,chartcfgcount = getlist(path.. 'charts/')
	-- TODO addsupport for Characters
else
	chartlist,chartcount,chartcfgcount = getlist(path)
end

local charts = io.open(path .. 'songs.txt','w')
charts:write(chartlist) -- Save buffer
charts:close()
print(f('Currently loaded charts/songs:\n%s',chartlist))
print(f([[Entered %i songs into charts.txt, Added configs to %i songs.
All the songs/charts listed above should appear ingame, if several do not then check your songs.txt, Try removing every song but the ones causing an issue, and then once you figure out which one is causing it, try removing the config from it and making sure the first character is capitalized, Not all songs need this though. You can edit the songs.txt while the game is running
Press enter to close]],chartcount,chartcfgcount))
io.read()
end) 
if not succ then 
	print(f('%s\nSomething went wrong, Please report this! Press enter to exit',err))
	io.read()
end

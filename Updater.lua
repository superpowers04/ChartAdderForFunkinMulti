-- Created specifically for adding configs and songs for https://shadowmario.itch.io/funkinmulti or https://gamebanana.com/mods/44205
-- This code isn't the cleanest but should work pretty well
-- Feel free to ask for help with this and feel free to edit/redistribute this. Just don't remove the disclaimer and please give credit
-- Originally created by Superpowers04, https://gamebanana.com/members/1622031 on gamebanana and Superpowers04#3887 on Discord

-- This is the updater
local debugmode = false -- Change to true to disable updating
local f = string.format
-- print('Checking for updates...')
local iswindows = true
if io.open('/dev','r') then iswindows = false end
function curl(url)
	if iswindows then -- Windows
		return assert(io.popen(f('cURL/curl.exe -s %q',url),'r'):read('*a'))
	else -- Unix
		return assert(io.popen(f('curl -s %q',url),'r'):read('*a'))
	end
end
function clear() -- Clears the command prompt/window
	if iswindows then return os.execute('cls') else return os.execute('clear') end
end
local verfile = io.open('version','r')
version = ' Not installed!'
if verfile then version = verfile:read('*a') end


function update() -- Check for updates and update if needed 
	
	if not debugmode then -- Don't execute
		local versionurl = "https://raw.githubusercontent.com/superpowers04/ChartAdderForFunkinMulti/main/version" -- Change this to your URL if you're forking it
		print('Checking for updates...')
		local onlinever = 0.0 
		onlinever = curl(versionurl) -- download and check version from github
		if onlinever == '' then print('Unable to check for updates!') io.read() return end
		if onlinever then onlinever = string.gsub(onlinever,'\n','') end
		if onlinever and onlinever ~= version then
			print(f('New update available %s! Your version:%s, Would you like to update?\nIf updating does not work, then you can use the alternative download from the gamebanana page\nType "y" and press enter to update or anything else to skip',onlinever,version))
			answer = string.lower(io.read())
			if answer and answer == 'y' then 
				clear()
				print('Updating...')
				-- io.open('./version','w'):write(onlinever)
				local update = curl('https://raw.githubusercontent.com/superpowers04/ChartAdderForFunkinMulti/main/Addnewsongs.lua') -- Grab latest lua file
				if update == '' or not string.match(update,'https://shadowmario.itch.io/funkinmult') then -- Make sure download actually contains lua file
					print(f('Something went wrong when trying to update! I got no response',err))
					io.read() 
					return 
				end
				
				local succ,err = pcall(function()load(update)end) -- Run in pcall to catch errors
				if not succ then -- If there's an error, print it!
					print(f('Something went wrong when trying to update! Please report:%s\nPress enter to continue',err))
					io.read() 
					return 
				end
				local succ = io.open('Addnewsongs.lua','w'):write(update)
				if succ then 
					io.open('version','w'):write(onlinever)
					print('Finished updating. Press enter to continue')
					io.read()
				else
					print('Something went wrong when trying to save, You might have to reinstall!')
					io.read()
					os.exit()
				end
			else
				print('Skipping update!')
			end
		elseif onlinever and onlinever == version then
			print('Uptodate, Nothing to do')
		else
			print('Unable to check for updates!\nPress enter to continue')
			io.read()
		end

	end
end
update()
dofile('Addnewsongs.lua')

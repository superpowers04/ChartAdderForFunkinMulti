local f = string.format
local json = require('dkjson')
local file = false
local format = false -- Whether to format JSON
local stdout = false -- Output to STDOUT
local doubleRemoval = false -- Remove double directional notes
local overlap = false -- Overlapping notes
local syncsides = false -- Syncing both sides
local noteReverse = false -- Reversed note info
local print = print
local oldprint = print

function sameside(side1,side)
	return noteattribs.ids[noteattribs.mapped[tostring(side1)]][tostring(side)] or false
end
function getNote(note) -- This should not need to exist but sometimes things like to invert the note
	if not note then return false end
	local newnote = {}
	if noteReverse then newnote.time = note[3];newnote.length = note[1] else newnote.time = note[1];newnote.length = note[3] end
	newnote.id = note[2]
	return newnote
end

do -- Argument handling
	if not arg[1] or arg[1] == '-h' then
		print([[Friday Night Funkin' Chart reparser. Reparses charts to fix any possible bugs and such
		Chartfixer.lua [-cdSOf] (Input JSON or Input File path) [Output file dir]
			Using -h or providing no arguments will show this dialog
		Arguments:
			c  - Output to STDout
			d  - Remove any double directional notes
			S  - Sync notes on both sides
			O  - Don't remove any overlapping notes(Use this if your chart is missing random notes and overlapping notes aren't an issue)
			r  - Reverses the order of note information(Use this if your chart is missing random notes)
			f  - Format output JSON to make human readable (Requires Node)

	]])
	end
	if string.sub(arg[1],0,1) == '-' then 
		local arguments = {
			c=function()-- Output to STDOUT
				print = io.write
				stdout = true
			end,
			d = function()
				oldprint('Removing doubles')
				doubleRemoval = true
			end,
			f = function()
				format = true
			end,
			O = function()
				oldprint('Allowing overlaps')
				overlap = true
			end,
			S = function()
				oldprint('Syncing both sides')
				syncsides = true
			end,
			r = function()
				oldprint('Reversing note info order')
				noteReverse = not noteReverse
			end,
		}
		for argument in string.gmatch(arg[1],'[%d%w]') do
			if not arguments[argument] then return print(f('%s is not a valid command switch! use -help to see all of the command switches',argument)) end
			arguments[argument]()
		end
		table.remove(arg,1)

	end
	if string.match(arg[1],'{') then 
		if string.match(arg[1],'}') then -- Check if arg[1] is a JSON string
			chartjson = arg[1]
		else -- Else format entire arg list
			chartjson = string.match(table.concat(arg,' '),'[^\\]?({.-[^\\]})')
		end
	else
		-- if arg[3] == '-f' then format = true end
		outputfile = arg[2] or arg[1]
		file = io.open(arg[1],'r')
		chartjson = file:read('*a')
		file:close()
	end
end

do -- Error handling and loading chart
	chart = json.decode(chartjson)
	chartold = json.decode(chartjson)
	if not chart then return print('NO CHART TO PARSE') end
	if not chart.song then return print('MISSING SONG') end
	if not chart.song.notes and not chart.notes then return print('MISSING NOTES') end
end
noteattribs= {}
noteattribs.named = {
	'left',
	'up',
	'down',
	'right',
	'left-2nd',
	'up-2nd',
	'down-2nd',
	'right-2nd',
}
noteattribs.invert = {

	4,5,6,7,3,2,1,0
}
noteattribs.mapped={

		['4']='right',['5']='right',['6']='right',['7']='right',['3']='left',['2']='left',['1']='left',['0']='left'
}
noteattribs.ids = {
	left={
		['3']=true,['2']=true,['1']=true,['0']=true
	},
	right={
		['4']=true,['5']=true,['6']=true,['7']=true
	}
}
blocked = {
	crossFade=true
}
if not chart.song.notes and chart.notes then -- Why is this even a thing?
	chart.song.notes = chart.notes 
	chartold.song.notes = chartold.notes 
end

-- Clean chart because it's needed for some reason
for k,v in pairs(chart) do
	if string.lower(k) ~= "song" then 
		if not chart.song[k] and not blocked[k] then
			chart.song[k] = v
			chart[k] = nil
		end
		chart[k] = nil
	end
end

for sid,section in pairs(chart.song.notes) do
	if section.sectionNotes then
		chart.song.notes[sid].sectionNotes = {}
		section.crossFade = nil
		for nid,oldnote in pairs(chartold.song.notes[sid].sectionNotes) do -- Loop through chart notes to be copied
			if not skip and oldnote then

				--[[
					Usual layout:
				    {
				    TIME,
				    NOTE,
				    LENGTH
				  	}
				]]
				-- local note.time = oldnote[3]

				local note = getNote(oldnote) -- Normal note
				-- note[1] = oldnote[1]
				-- note[2]= oldnote[2]
				
				local nextnote = getNote(chartold.song.notes[sid].sectionNotes[nid + 1] or chartold.song.notes[sid + 1].sectionNotes[1])
				
				if nextnote then
					if nextnote.time == 0 then nextnote.time = -nextnote.time end
					if note.time == 0 then note.time = -nextnote.time end

					local timebetween = nextnote.time - note.time -- Get time between notes
					if timebetween < -0.1 then timebetween = -timebetween end
					if timebetween < 0.00001 and nextnote.id ==  nextnote.id and not overlap then -- Compare notes
						if timebetween < -1 then
							print(f('Next note has less time than this one! Doing nothing! %s',timebetween))
						else
							print(f('Skipping %s',timebetween))
							skip = true -- Skip next note if this note and next note are the same
						end
					end
					if doubleRemoval then
						local timebetween = nextnote.time - note.time
						if timebetween < 0.00001 and nextnote.id ~= note.id and sameside(nextnote.id,note.id) then
							print(f('Skipping %s,%s',json.encode(nextnote),json.encode(note)))
							skip = true -- Skip next note if this note and next note are the same
						end
					end

				end
				table.insert(chart.song.notes[sid].sectionNotes,{note.time,note.id,note.length})
				
				if syncsides then -- Syncing sides
					local note2 = {} -- Reversed Note
					note2.time = note.time
					note2.id= noteattribs.invert[note.id+1] -- Adds one to account for Lua counting from one, not zero
					note2.length = note.length	
					table.insert(chart.song.notes[sid].sectionNotes,{note2.time,note2.id,note2.length})
				
					if nextnote and (math.floor(nextnote.time) == math.floor(note2.time) and math.floor(nextnote.time) == math.floor(note2.time)) then -- Compare notes
						skip = true -- Skip if this note and next note are the same
					end

				end
			else
				skip = false
			end
		end

	end
end
chart.song.sections = sectionCount
chart.song.speed = tonumber(chart.song.speed)
chart.song.bpm = tonumber(chart.song.bpm)
if stdout then return io.write(json.encode(chart)) end
if format then
	io.open('output.json','w'):write(json.encode(chart))
	io.popen(f([[( read p;node -e $p ;mv 'output.json' %q) << EOL
	fs.readFile('output.json',function(_,data){fs.writeFile('output.json',JSON.stringify(JSON.parse(data.toString()),null,2),function(){})})
	EOL]],outputfile))
else
	if not outputfile then return io.write(json.encode(chart)) end
	io.open(outputfile,'w'):write(json.encode(chart))
end

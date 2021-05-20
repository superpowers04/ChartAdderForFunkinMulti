# ChartAdderForFunkinMulti 
 Add's charts for the Friday Night Funkin Multiplayer mod
 Updater.lua automatically updates
## Important Stuff

 This is meant for personal use only. <b>DO NOT USE THIS AND THEN POST ANYTHING THIS MAKES ONTO GAMEBANANA OR ANY OTHER SITE UNLESS STRICTLY ALLOWED BY THE AUTHOR.</b><br/>
 Any mods made with this will probably get withheld for being low quality.<br>
 This will always make the stage set to "Stage" and the character icon to Pico for any charts missing a config<br>
 This wipes the songs.txt every time it's run.<br>
 Songs will usually be listed in reverse alphabetical order.<br>
 
## Adding a Chart

 (/'s stand for a folder for example mods/charts means the charts folder in your mods folder)<br>
 To add charts, make a new folder named the song in your mods/charts folder, grab the chart from the mod(Commonly found under the Data/SONGSNAME folder) and then paste it into the folder you created.<br>
 Copy the Inst and Voices into the folder(Or copy the SONGNAME_Voices and SONGNAME_Inst to the main charts folder and the script will handle it)<br>
 Run the script and then check your game<br>
 You can disable charts by adding a ! to it's name and the script will ignore it<br>
 If the chart skips randomly and there's no song then make sure to have the Inst and Voices as OGG files and that they're in the folder for the chart<br>

This tool is not garrenteed to work with all charts. Some charts may crash the game or be unusable with the Multiplayer mod<br>
If you end up having any issues with this, feel free to comment on the Gamebanana page or DM me on Discord(Superpowers04#3887)/Gamebanna(Superpowers04)<br>





# ChartFixer (Basic terminal knowledge and computer common sense required) UNFINISHED
Updater.lua does not automatically update
**Requires http://dkolf.de/src/dkjson-lua.fsl/home to work**
```Friday Night Funkin' Chart reparser. Reparses charts to fix any possible bugs
		Chartfixer.lua [-cdSOf] (Input JSON or Input File path) [Output file dir]
			Using -h or providing no arguments will show this dialog
		Arguments:
			c  - Output to STDout
			d  - Remove any double directional notes and makes chart a bit easier
			S  - Sync notes on both sides
			O  - Don't remove any overlapping notes(Use this if your chart is missing random notes and overlapping notes aren't an issue)
			r  - Reverses the order of note information(Use this if your chart is missing random notes)
			g  - prompts for overlap distance, the maximum distance between notes before it gets deleted
			f  - Format output JSON to make human readable (Requires NodeJS to be installed to work)
 ```
 Useful for if you want to make a chart easier(-d), if a chart has multiple notes in a single note(Causing inputs to not register) or if the chart just needs to be cleaned

 

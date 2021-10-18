# Batch-Convert-multi-BIN-to-single-BIN
for PSX / PS1 multibin files, batch convert to single BIN

A handy script I found here after a request for Pop Starter games (personally, I use OG hardware/ not emulation):
https://forum.recalbox.com/topic/16504/how-to-batch-process-psx-images-with-multiple-bins-per-cd

with additional notes on the batch file.

Usually, you'd use an older version of CD Mage to convert multi BIN files to single BIN files. Xstation doesn't have an issue with multi bin 
so haven't had to do it much. PS3 seems ok as well, but some games won't run off an external hard drive and need to be on the internal.

You need CHDMAN.EXE


Script has being changed, it was broken and I couldn't figure out why. Error message from CHDMAN.exe in regards to the 
line for CHD to bin conversion, it wouldn't do the conversion, then it was deleting the CHD it created.

I've edited out the conversion, and the deletion lines from the batch. You now run a new batch file from inside the 'temp' folder once they've all 
being converted to '.chd' files. This will batch convert everything in the folder its run from into single bin/ cue files.

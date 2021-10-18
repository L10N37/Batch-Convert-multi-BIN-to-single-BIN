@REM Multi-BIN Batch conversion script for chdman

@REM 2019-01-29 by The_Mole for forum.recalbox.com

 

@REM Requires chdman.exe in the image-sourcepath


REM VajskiDs 18/10/2021: 
REM 				Please note I have an actual hard drive that I've allocated the drive letter 'x' to.
REM				    the workpath needs to have the same format as below, i.e. I've created a folder on the
REM					root of my 'X' drive called temp ("X:\temp\") to avoid wasting writes to my OS's SSD.

REM					If you have a folder full of PSX titles *including* ones that are already single BIN
REM					you don't want to run this tool UNTIL separating them, as it will needlessly convert
REM					the already single BIN files into CHD and back, thus achieving nothing ....but wasting time.

REM					I'd suggest a file manager like 'Total Commander'
REM                 Configuration Options->Quick Search->Letters with Search Dialogue (enable this)

REM					search for ' *track '
REM											CTRL+A to select all multibins, hold right click, cut, paste into a new folder in a new subdir in the same folder
REM
REM							Select ALL cue files, paste them in there as well - the batch will skip the cue files associated with single bin files that are missing
REM																				and convert all multibin files, leaving a single bin equivelant in your 'destpath' dir

REM                                                                                        after this, clean up time (delete multibin tracks) and move everything back to
REM																							a single folder for conversion to .VCD


@REM Switch off unneccessary output

@ECHO off 

REM Clear the screen

CLS  

REM Let's SET the different folders

REM Here you SET the source path, where your multi-bin CD-images are. Subdirectories are supported.

SET sourcepath="X:\PS1\POPS\multibin\"

REM Here you SET a path for the intermediate chd file. %TEMP refers to the Windows standard Temp-Folder.

REM If you convert a larger batch you may want to conserve writes on your system-SSD and use a ramdisk or HDD, instead.

SET workpath=X:\temp%

REM Here you SET your output directory, where you want your single-bin CD-images to be stored.

REM If you SET it to your source path, your cue-files will be overwritten.

SET destpath="X:\singlebin\"

REM This is a safety catch to make sure, you edit the file, before running it.

REM Put a rem-command before the line below to unlock the script.

GOTO idiotfilter

REM Here we start the loop: For every cue-file in %sourcepath% and its subdirectories execute the commands inside the bracket

FOR /R "%sourcepath%" %%R IN (*.cue) DO ( 

REM Print an empty line 

ECHO. 

REM Print a status message. %%~nR refers to the filename of the cue-file WITHOUT extension

ECHO ### Converting %%~nR to chd ###

REM Create the chd-Image. %%R refers to the cue-file WITH extension,

%sourcepath%\chdman.exe createcd -i "%%R" -o "%workpath%\%%~nR.chd" -f 


REM Print an empty line 

ECHO. 

REM Print a status message. %%~nR refers to the filename of the cue-file WITHOUT extension

ECHO ### Converting chd to %%~nR.bin ###

REM Create the single-bin image, including a cue-file, overwrite existing files.

%sourcepath%\chdman.exe extractcd -i "%workpath%\%%~nR.chd" -o "%destpath%\%%~nR.cue" -ob "%destpath%\%%~nR.bin" -f

REM Delete the chd-file. We no longer need it and it's always good to clean up after yourself.

DEL "%workpath%\%%~nR.chd"

REM Print an empty line 

ECHO. 

@REM Print an empty line 

ECHO. 

REM Close the loop. Start the next or move on if there are no files left.

)

REM This is a jump mark. If you read all comment lines, you know, why it's here.

:idiotfilter

REM Well... what it says.

EXIT

::build.bat: Build 3dos from source code (bootloader + kernel)
::Originally created by KNNSpeed, modified by HackerDaGreat57

::TO EXECUTE THIS FILE SUCCESSFULLY, PLEASE SET YOUR %DOS_ROOT% SYSTEM VARIABLE TO THE REPOSITORY ROOT (WHERE README.MD IS)
::AND SET %DOS_COMPILER% TO GCC'S INSTALL ROOT DIRECTORY (MINE IS D:/SRC/_COMPILERS/MSYS2/MINGW64 FOR EXAMPLE)

::Allow local variables to be created so the script doesn't mess with system variables. Also lets local variables to be modified
setlocal ENABLEDELAYEDEXPANSION

::CurDir_DOS is the current path in DOS form (\)
set CurDir_DOS=%CD%
::CurDir_fDOS is the current path in DOS form with forward-slashes instead of backslashes (\ -> /)
set CurDir_fDOS=%CurDir_DOS:\=/%
::CurDir_UNIX is the current path in Unix form (spaces are escaped with a backslash)
::This is needed by GCC because it thinks it is a native Unix executable
set CurDir_UNIX=%CurDir_fDOS: =\ %
set GCC_FOLDER_NAME=mingw64

::Move to the bin folder where the final executables will be written
cd ../bin

::Delete the objects list (we'll rebuild it later)
del objects.list

rem
rem Need to set path for various DLLs in the GCC folder, otherwise compile will
rem fail. Due to the above setlocal, this is not a persistent PATH edit; it
rem will only apply to this script.
rem
rem Also Need to tell GCC where to find as and ld
rem

set PATH=%CD%\%GCC_FOLDER_NAME%\bin;%PATH%

rem
rem Create the HFILES variable, which contains the massive set of includes (-I)
rem needed by GCC.
rem
rem Two of the include folders are always included, and they
rem are %CurDir_DOS%/inc/ (the user-header directory) and %CurDir_DOS%/startup/
rem

set HFILES="%CurDir_DOS%\inc\" -I"%CurDir_DOS%\startup\"

rem
rem Loop through the h_files.txt file and turn each include directory into -I strings
rem

FOR /F "tokens=*" %%h IN ('type "%CurDir_DOS%\h_files.txt"') DO set HFILES=!HFILES! -I"%%h"

rem
rem Windows uses backslashes. GCC and *nix-based things expect forward slashes.
rem This converts backslashes into forward slashes on Windows.
rem

set HFILES=%HFILES:\=/%

rem
rem This echo is useful for debugging this script, namely to make sure you
rem aren't missing any include directories.
rem

rem echo !HFILES!
rem pause

rem
rem Loop through and compile the backend .c files, which are listed in c_files_windows.txt
rem

@echo %echo_stat%
FOR /F "tokens=*" %%f IN ('type "%CurDir_DOS%\c_files_windows.txt"') DO "%GCC_FOLDER_NAME%\bin\gcc.exe" -ffreestanding -fshort-wchar -fno-stack-protector -fno-stack-check -fno-strict-aliasing -mno-stack-arg-probe -fno-merge-all-constants -m64 -mno-red-zone -DGNU_EFI_USE_MS_ABI -maccumulate-outgoing-args --std=c11 -I!HFILES! -Og -g3 -Wall -Wextra -Wdouble-promotion -fmessage-length=0 -c -MMD -MP -Wa,-adhln="%%~df%%~pf%%~nf.out" -MF"%%~df%%~pf%%~nf.d" -MT"%%~df%%~pf%%~nf.o" -o "%%~df%%~pf%%~nf.o" "%%~ff"
@echo off

rem
rem Compile the .c files in the startup folder (if any exist)
rem

@echo %echo_stat%
FOR %%f IN ("%CurDir_fDOS%/startup/*.c") DO "%GCC_FOLDER_NAME%\bin\gcc.exe" -ffreestanding -fshort-wchar -fno-stack-protector -fno-stack-check -fno-strict-aliasing -fno-merge-all-constants -mno-stack-arg-probe -m64 -mno-red-zone -DGNU_EFI_USE_MS_ABI -maccumulate-outgoing-args --std=c11 -I!HFILES! -Og -g3 -Wall -Wextra -Wdouble-promotion -fmessage-length=0 -c -MMD -MP -Wa,-adhln="%CurDir_fDOS%/startup/%%~nf.out" -MF"%CurDir_fDOS%/startup/%%~nf.d" -MT"%CurDir_fDOS%/startup/%%~nf.o" -o "%CurDir_fDOS%/startup/%%~nf.o" "%CurDir_fDOS%/startup/%%~nf.c"
@echo off

rem
rem Compile the .s files in the startup folder (Any assembly files needed to
rem initialize the system)
rem

@echo %echo_stat%
FOR %%f IN ("%CurDir_fDOS%/startup/*.s") DO "%GCC_FOLDER_NAME%\bin\gcc.exe" -ffreestanding -fshort-wchar -fno-stack-protector -fno-stack-check -fno-strict-aliasing -fno-merge-all-constants -mno-stack-arg-probe -m64 -mno-red-zone -DGNU_EFI_USE_MS_ABI -maccumulate-outgoing-args --std=c11 -I"%CurDir_fDOS%/inc/" -g -o "%CurDir_fDOS%/startup/%%~nf.o" "%CurDir_fDOS%/startup/%%~nf.s"
@echo off

rem
rem Compile user .c files
rem

@echo on
FOR %%f IN ("%CurDir_fDOS%/src/*.c") DO "%GCC_FOLDER_NAME%\bin\gcc.exe" -ffreestanding -fshort-wchar -fno-stack-protector -fno-stack-check -fno-strict-aliasing -fno-merge-all-constants -mno-stack-arg-probe -m64 -mno-red-zone -DGNU_EFI_USE_MS_ABI -maccumulate-outgoing-args --std=c11 -I!HFILES! -Og -g3 -Wall -Wextra -Wdouble-promotion -fmessage-length=0 -c -MMD -MP -Wa,-adhln="%CurDir_fDOS%/src/%%~nf.out" -MF"%CurDir_fDOS%/src/%%~nf.d" -MT"%CurDir_fDOS%/src/%%~nf.o" -o "%CurDir_fDOS%/src/%%~nf.o" "%CurDir_fDOS%/src/%%~nf.c"
@echo off

rem
rem Create OBJECTS variable, whose sole purpose is to allow conversion of
rem backslashes into forward slashes in Windows
rem

set OBJECTS=

rem
rem Create the objects.list file, which contains properly-formatted (i.e. has
rem forward slashes) locations of compiled Backend .o files
rem

FOR /F "tokens=*" %%f IN ('type "%CurDir_DOS%\c_files_windows.txt"') DO (set OBJECTS="%%~df%%~pf%%~nf.o" & set OBJECTS=!OBJECTS:\=/! & set OBJECTS=!OBJECTS: =\ ! & set OBJECTS=!OBJECTS:"\ \ ="! & echo !OBJECTS! >> objects.list)

rem
rem Add compiled .o files from the startup directory to objects.list
rem

FOR %%f IN ("%CurDir_fDOS%/startup/*.o") DO echo "%CurDir_UNIX%/startup/%%~nxf" >> objects.list

rem
rem Add compiled user .o files to objects.list
rem

FOR %%f IN ("%CurDir_fDOS%/src/*.o") DO echo "%CurDir_UNIX%/src/%%~nxf" >> objects.list

rem
rem Link the object files using all the objects in objects.list to generate the
rem output binary, which is called "BOOTX64.EFI"
rem

@echo on
"%GCC_FOLDER_NAME%\bin\gcc.exe" -nostdlib -Wl,--warn-common -Wl,--no-undefined -Wl,-dll -s -shared -Wl,--subsystem,10 -e efi_main -Wl,-Map=output.map -o "BOOTX64.EFI" @"objects.list"
@echo off
rem Remove -s in the above command to keep debug symbols in the output binary.

rem
rem Output the program size
rem

echo.
echo Generating binary and Printing size information:
echo.
rem "%GCC_FOLDER_NAME%\bin\objcopy.exe" -O binary "program.exe" "program.bin"
"%GCC_FOLDER_NAME%\bin\size.exe" "BOOTX64.EFI"
echo.

set /P UPL="Cleanup, recompile, or done? [c for cleanup, r for recompile, any other key for done] "

echo.
echo **********************************************************
echo.

if /I "%UPL%"=="C" endlocal & .\Cleanup.bat
if /I "%UPL%"=="R" endlocal & goto rerun_script

rem
rem Return to the folder started from and exit
rem
rem No more need for local variables
rem

endlocal

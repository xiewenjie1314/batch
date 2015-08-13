@set VERSION_FILE_PATH=../../apps/common_app/userapp/interface.c
@sed -n -e 's/#define[ \t]*SW_VERSION_PINK[ \t]*[\(]*[ \t]*\([0-9]*\)[ \t]*[\)]*.*$/\1/p'  %VERSION_FILE_PATH% > ver.txt
@set /p SW_VER= < ver.txt
@del ver.txt

@set SW_VER_HIGH=%SW_VER:~0,-2%
@set SW_VER_LOW=%SW_VER:~-2,2%


if exist ME_Africa_sattp_S2.bin (
   echo "ME_Africa_sattp_S2.bin exist"
) else (
echo "ME_Africa_sattp_S2.bin No exist"
SatTPClient.exe ME_Africa_sattp_S2.cfg ME_Africa_sattp_S2.bin
)
if exist Softcam.bin (
   echo "Softcam.bin exist"
) else (
echo "Softcam.bin No exist"
Softcam.exe
)

@set year=%date:~0,4%
@set month=%date:~5,2%
@set day=%date:~8,2%


copy MT_pink_update.bin ..\pink\Antemina\Antemina_V%SW_VER_HIGH%.%SW_VER_LOW%_%day%-%month%-%year%.bin

@echo off
for /f "tokens=2 delims==" %%a in ('wmic LogicalDisk where "DriveType='2'" get DeviceID /value') do (
  set DriveU=%%a
)
if defined DriveU (
	echo Update file Copy tu USB drive, please wait...
	COLOR 0A
	copy MT_pink_update.bin %DriveU%\Antemina_V%SW_VER_HIGH%.%SW_VER_LOW%_%day%-%month%-%year%.bin
) else (
	echo Please insert the usb flash drive.)

del MT_pink_update.bin

pause



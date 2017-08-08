#-s Visual Studio Settings directory
#-v Vimrc directory
#-a autohotkey directory

VSSettingsFileName="CurrentSettings.vssettings"
VimRCFileName="_vimrc"
GVimRCFileName="_gvimrc"
AHKFileName="default.ahk"
AHKExeName="startup.exe"
VSSettingsSet=false
VimRCSet=false
AHKSet=false
LinuxEnv=false

while getopts ":s:v:a:l" opt; do
	case $opt in
		s)
			VSSettingsDir=$OPTARG
			VSSettingsSet=true
			;;
		v)
			VimRCDir=$OPTARG
			VimRCSet=true
			;;
		a)
			AHKDir=$OPTARG
			AHKSet=true
			;;
		l)
			LinuxEnv=true
	esac
done

VimRCDest="$VimRCDir/$VimRCFileName"
GVimRCDest="$VimRCDir/$GVimRCFileName"
VSSettingsDest="$VSSettingsDir/$VSSettingsFileName"
AHKDest="$AHKDir/$AHKFileName"
AHKExeDest="$AHKDir/$AHKExeName"

if ($LinuxEnv) ; then
	VimRCDest="$VimRCDir/.vimrc"
	GVimRCDest="$VimRCDir/.gvimrc"
fi

git pull

if $VSSettingsSet ; then
	cp "$VSSettingsFileName" "$VSSettingsDest" 
	echo "$VSSettingsFileName Copied to $VSSettingsDest"
fi

if $VimRCSet ; then
	cp "$VimRCFileName" "$VimRCDest"
	echo "$VimRCFileName Copied to $VimRCDest"
	cp "$GVimRCFileName" "$GVimRCDest"
	echo "$GVimRCFileName Copied to $GVimRCDest"
fi

if $AHKSet ; then
	cp "$AHKFileName" "$AHKDest"
	echo "$AHKFileName Copied to $AHKDest"
	./compileahk.bat "$AHKFileName" "$AHKExeName"
	cp "$AHKExeName" "$AHKExeDest"
	echo "$AHKExeName Copied to $AHKExeDest"
fi

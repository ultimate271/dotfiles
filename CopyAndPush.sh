#-s Visual Studio Settings directory
#-v Vimrc directory
#-a autohotkey directory

VSSettingsFileName="CurrentSettings.vssettings"
VimRCFileName="_vimrc"
GVimRCFileName="_gvimrc"
AHKFileName="default.ahk"
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

if $VSSettingsSet ; then
	cp "$VSSettingsDest" $VSSettingsFileName
	echo "$VSSettingsDest copied to $VSSettingsFileName"
fi

if $VimRCSet ; then
	cp "$VimRCDest" $VimRCFileName
	echo "$VimRCDest copied to $VimRCFileName"
	cp "$GVimRCDest" "${GVimRCFileName}"
	echo "$GVimRCDest Copied to $GVimRCFileName"
fi

if $AHKSet ; then
	cp "$AHKDest" $AHKFileName
	echo "$AHKDest copied to $AHKFileName"
fi

#MacAddress=$(Getmac | grep '-' | awk '/\\Device/{ print $1 }')

if ($LinuxEnv) ; then
	Username=$(id -un)
	Computername=$(hostname -f)
	CurrentTime=$(date)
else
	Username=$(env | grep "^USERNAME" | awk 'BEGIN { FS="=" } { print $2 }')
	Computername=$(env | grep "^COMPUTERNAME" | awk 'BEGIN { FS="=" } { print $2 }')
	CurrentTime=$(date "+%F %T")
fi
git commit -am "From ${Username}@${Computername} updated on $CurrentTime"
git push origin master


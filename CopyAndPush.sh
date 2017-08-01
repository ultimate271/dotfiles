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

while getopts ":s:v:a:" opt; do
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
	esac
done

if $VSSettingsSet ; then
	cp "${VSSettingsDir}/${VSSettingsFileName}" $VSSettingsFileName
	echo "${VSSettingsDir}/${VSSettingsFileName} copied to $VSSettingsFileName"
fi

if $VimRCSet ; then
	cp "${VimRCDir}/${VimRCFileName}" $VimRCFileName
	echo "${VimRCDir}/${VimRCFileName} copied to $VimRCFileName"
	cp "${VimRCDir}/${GVimRCFileName}" "${GVimRCFileName}"
	echo "${VimRCDir}/${GVimRCFileName} Copied to $GVimRCFileName"
fi

if $AHKSet ; then
	cp "${AHKDir}/${AHKFileName}" $AHKFileName
	echo "${AHKDir}/${AHKFileName} copied to $AHKFileName"
fi

#MacAddress=$(Getmac | grep '-' | awk '/\\Device/{ print $1 }')

Username=$(env | grep "^USERNAME" | awk 'BEGIN { FS="=" } { print $2 }')
Computername=$(env | grep "^COMPUTERNAME" | awk 'BEGIN { FS="=" } { print $2 }')
CurrentTime=$(date "+%F %T")
git commit -am "From ${Username}@${Computername} updated on $CurrentTime"
git push origin master


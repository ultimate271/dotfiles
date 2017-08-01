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

git pull

if $VSSettingsSet ; then
	cp "$VSSettingsFileName" "$VSSettingsDir" 
	echo "$VSSettingsFileName Copied to $VSSettingsDir"
fi

if $VimRCSet ; then
	cp "$VimRCFileName" "$VimRCDir"
	echo "$VimRCFileName Copied to $VimRCDir"
	cp "$GVimRCFileName" "$VimRCDir"
	echo "$GVimRCFileName Copied to $VimRCDir"
fi

if $AHKSet ; then
	cp "$AHKFileName" "$AHKDir"
	echo "$AHKFileName Copied to $AHKDir"
fi

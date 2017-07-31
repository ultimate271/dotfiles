#-s Visual Studio Settings directory
#-v Vimrc directory
#-a autohotkey directory

VSSettingsFileName="CurrentSettings.vssettings"
VimRCFileName="_vimrc"
AHKFileName="default.ahk"
while getopts ":s:v:a:" opt; do
	case $opt in
		s)
			VSSettingsDir=$OPTARG
			;;
		v)
			VimRCDir=$OPTARG
			;;
		a)
			AHKDir=$OPTARG
	esac
done

git pull

cp $VSSettingsFileName $VSSettingsDir 
echo "$VSSettingsFileName Copied to $VSSettingsDir"

cp $VimRCFileName $VimRCDir 
echo "$VimRCFileName Copied to $VimRCDir"

cp $AHKFileName $AHKDir
echo "$AHKFileName Copied to $AHKDir"

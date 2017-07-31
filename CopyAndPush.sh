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

cp "${VSSettingsDir}\\${VSSettingsFileName}" $VSSettingsFileName
echo "${VSSettingsDir}\\${VSSettingsFileName} copied to $VSSettingsFileName"

cp "${VimRCDir}\\${VimRCFileName}" $VimRCFileName
echo "${VimRCDir}\\${VimRCFileName} copied to $VimRCFileName"

cp "${AHKDir}\\${AHKFileName}" $AHKFileName
echo "${AHKDir}\\${AHKFileName} copied to $AHKFileName"

MacAddress=(Getmac | grep - | awk '/\\Device/{ print $1 }')
CurrentTime=(date "+%F %T")
git commit -am "From $MacAddress updated on $CurrentTime"
git push origin master


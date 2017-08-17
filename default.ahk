#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock & 1::
	Send, admin{Tab}alliant{Enter}
Return

Capslock & 2::
	Send, Alliant304{Tab}Alliant{Tab}sa{Tab}RouteLeader13{Enter 2}
Return

+NumpadSub::_
Return

#c::
	Run, Explorer `,
Return

#z::
	Run, Explorer %USERPROFILE%
Return

#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock & 1::
	Send, admin{Tab}alliant{Enter}
Return

Capslock::
	Send, {Esc}
Return

+NumpadSub::_
Return

#c::
	Run, Explorer `,
Return

#e::
	Run, Explorer %USERPROFILE%
Return

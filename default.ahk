#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock & 1::
	Send, admin{Tab}alliant{Enter}
Return

Capslock & 2::
	Send, {F5}{Tab 3}{Enter}
Return

+NumpadSub::_
Return

#c::
	Run, Explorer `,
Return

#e::
	Run, Explorer %USERPROFILE%
Return

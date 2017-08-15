#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock & 1::
	Send, admin{Tab}alliant{Enter}
Return

Capslock & 2::
	Send, {F10}{Tab 18}{Enter}04032016{Tab}04092016{Tab 4}374949
Return

+NumpadSub::_
Return

#c::
	Run, Explorer `,
Return

#z::
	Run, Explorer %USERPROFILE%
Return

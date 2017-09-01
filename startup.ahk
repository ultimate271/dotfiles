#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock::Backspace
Return

Backspace::
Return

Backspace & =::
	Send, admin{Tab}alliant{Enter}
Return

Backspace & -::
	Send, {F8}!m100!f
Return

+NumpadSub::_
Return

#c::
	Run, Explorer `,
Return

#z::
	Run, Explorer %USERPROFILE%
Return

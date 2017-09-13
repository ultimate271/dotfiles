#Persistent
SetCapsLockState, AlwaysOff

#Capslock::Capslock
Return

Capslock::Backspace
Return

Backspace::
Return

RShift::Esc
Return

Backspace & ]::
	Send, admin{Tab}alliant{Enter}
Return

Backspace & [::
	Send, {F10}!p10282016{Tab 2}16000{Tab 2}00001!f
Return

+NumpadSub::_
Return

#j::
	Run, Explorer `,
Return

#q::
	Run, Explorer %USERPROFILE%
Return

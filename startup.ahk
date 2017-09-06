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
	Send, {F2}{Tab 3}943520{Tab}52720{Enter}!i
Return

+NumpadSub::_
Return

#j::
	Run, Explorer `,
Return

#q::
	Run, Explorer %USERPROFILE%
Return

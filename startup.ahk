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

;^j::
;    Send, ^c
;Return
;
;^k::
;    Send, ^v
;Return

Backspace & ]::
    Send, admin{Tab}Alliant{Enter}
Return

Backspace & [::
    Send, {F7}{Tab 14}{Enter}{Down}{Tab}11172017{Tab 3}{Down}{Tab 2}{Space}{Tab}{Space}{Tab 2}{Down}{Tab}{Enter}
Return

Backspace & 0::
    Send, {F6}!i11062017{Tab 2}{Down 4}{Tab}C0517180{Tab 3}{Down}!f
Return

+NumpadSub::_
Return

#j::
    Run, Explorer `,
Return

#q::
    Run, Explorer %USERPROFILE%
Return

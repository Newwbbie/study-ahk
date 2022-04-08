#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


F2::
    SetTimer, press1, 1000
Return

F3::
    pause
Return

press1() {
    send 1
}
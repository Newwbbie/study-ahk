#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 每隔一秒钟喝一口红药，1号位

; 1. 定义一个热键
F2::
    SetTimer, press1, 3500
    SetTimer, pre, 9600
Return

F3::
    Pause
return 


press1() {
    send 1
}

pre() {
    send 3
}
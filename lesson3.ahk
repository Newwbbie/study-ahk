#SingleInstance Force
SetWorkingDir, %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, 10
SetKeyDelay, 10


F2::
    WinGetPos, x, y, w, h, A
    bb_x := 1295
    bb_y := 615
    bb_w := 51
    bb_h := 50
    Send, {ctrl down}
    loop 12 {
        loop 5 {
            if GetKeystate("F2","P") { ; 如果按住的话
                MouseMove %bb_x%, %bb_y%
                send, {Click}
                bb_y := bb_y + bb_h
                Sleep, 10
            } else {
                Send, {ctrl up}
                Break ; 不是按住退出循环 
            }
        }
        bb_y := bb_y - bb_h * 5
        bb_x := bb_x + bb_w
    }
    Send, {ctrl up}
Return

F3::
    pause
Return

F4::
    WinGetPos, x, y, w, h, A
    bb_x := GetRandom(AdaptPosX(1300))
    bb_y := GetRandom(AdaptPosY(615))
    bb_w := 51 / 1080 * h
    bb_h := 50 / 1080 * h
    ; MsgBox %bb_x%,%bb_y%,%bb_w%,%bb_h%
    Send, {ctrl down}
    loop 12 {
        loop 5 {
            if GetKeystate("F4","P") { ; 如果按住的话
                MouseMove %bb_x%, %bb_y%
                send, {Click}
                bb_y := bb_y + bb_h
                Sleep, 10
            } else {
                Send, {ctrl up}
                Break ; 不是按住退出循环 
            }
        }
        bb_y := bb_y - bb_h * 5
        bb_x := bb_x + bb_w
    }
    Send, {ctrl up}
Return

AdaptPosX(x_1920) {
    WinGetPos, x, y, w, h, A
    If (x_1920 > 1255) {
        return w + (x_1920 - 1920) / 1080 * h
    } else {
        return x_1920 / 1080 * h
    }
}

AdaptPosY(y_1080) {
    WinGetPos, x, y, w, h, A
    return y_1080 / 1080 * h
}

GetRandom(num) {
    Random, OutputVar , num - 5, num + 5
    return OutputVar
}
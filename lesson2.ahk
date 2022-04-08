#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 定义一个定时器，以一个很快的频率去监测血量
; 监测自定义的血量监测点的明度（V），根据v去判断该点是否有血
; 从而完成监测血量的目标，蓝量同理。
F2::
    SetTimer, autoHP, 100
Return

F3::
    pause
Return

autoHP() {
    PixelGetColor, color, 120, 1020 , RGB
    v := RGB2HSV(color)
    if (v < 0.4) {
        send 1
    }
}

RGB2HSV(color) {
    ; 提取rgb，转成10进制
    rgb := SubStr(color, 3, 6)
    r := toBase("0x"+SubStr(rgb, 1 , 2), 10)
    g := toBase("0x"+SubStr(rgb, 3 , 2), 10)
    b := toBase("0x"+SubStr(rgb, 5 , 2), 10)

    ; 转hsv
    cMax := max(r,g,b)
    cMin := min(r,g,b)
    dlta := cMax - cMin
    ; MsgBox %r%, %g%, %b%, %cMax%, %cMin%, %dlta%

    if (dlta != 0 && cMax == r) {
        h := (g - b) / dlta
    } else if (dlta != 0 && cMax == g) {
        h := (b - r) / dlta + 2
    } else if (dlta != 0 && cMax == b) {
        h := (r - g) / dlta + 4
    }
    h := h * 60
    if (h < 0) {
        h := h + 360
    }
    if (cMax != 0) {
        s := dlta / cMax
    }
    v := cMax / 255
    ; MsgBox %h%, %s%, %v%
    ; 这里得到三个值，我只返回了对我有用的v
    ; 如果需要在别处使用，请自行修改
    return v
}

toBase(n, b) {
    return (n < b ? "" : ToBase(n//b,b)) . ((d:=Mod(n,b)) < 10 ? d : Chr(d+55))
}

max(a, b, c) {
    return (a>=b && a>=c) ? a : (b>=a && b>=c) ? b : c
}

min(a, b, c) {
    return (a<=b && a<=c) ? a : (b<=a && b<=c) ? b : c
}
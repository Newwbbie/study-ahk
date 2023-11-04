#SingleInstance Force
SetWorkingDir, %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, 10
SetKeyDelay, 10

; 140, 160
; 1445, 830
global arr := []

InitArr(w, h) {
    loop %w% {
        x += 1
        y := 0
        loop %h% {
            y += 1
            arr[y, x] := 0
        }
    }
}

ReadInfo(StartX, StratY, EndX, EndY, w, h) {
    sepX := (EndX - StartX) / w
    sepY := (EndY - StratY) / h
    x := StartX - sepX
    y := StratY - sepY
    xindexX := 0
    loop %w% {
        x += sepX
        xindexX += 1
        xindexY := 0
        loop %h% {
            y += sepY
            indexY += 1
            SearchNum(x, y, indexX, indexY)
        }
    }
}

SearchNum(x, y, indexX, indexY, sep=10) {
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/1.png
    if !ErrorLevel {
        arr[indexY, indexX] := 1
        Return
    }
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/2.png
    if !ErrorLevel {
        arr[indexY, indexX] := 2
        Return
    }
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/3.png
    if !ErrorLevel {
        arr[indexY, indexX] := 3
        Return
    }
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/4.png
    if !ErrorLevel {
        arr[indexY, indexX] := 4
        Return
    }
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/5.png
    if !ErrorLevel {
        arr[indexY, indexX] := 5
        Return
    }
    ImageSearch, OutputVarX, OutputVarY, x-sep, y-sep, x+sep, y+sep, *100 pic/6.png
    if !ErrorLevel {
        arr[indexY, indexX] := 6
        Return
    }
}

F2::
    Click 140, 160
    Sleep, 100
    InitArr(30, 16)
    ReadInfo(140, 160, 1445, 830, 30, 16)
    msgbox % arr["1"]["1"]
Return
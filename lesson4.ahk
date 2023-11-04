#SingleInstance Force
SetWorkingDir, %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, 10
SetKeyDelay, 10

; 1. 石头的使用
; 2. 需求录入
; 3. 获取装备信息
; 4. 词缀的提取
; 5. 词缀和需求的对比，判断
; 6. 流程控制

F2::
    startZz()
Return

F3::
    pause
Return


; 保持上一次剪贴板内容
global info
; 希望出现的词缀
global hope
; 希望roll到的T级（通常设置某个T的最小值）
global hopeNum
; 需要满足几条词缀
global need

; 词缀数组
global ciZhuiArray := {}
; 满足词缀数
global target := 0


IfNo(str) {
    msgbox, 4,, %str%
    IfMsgBox No
return 1
}

startZz() {
    WinActivate, ahk_exe PathOfExile_x64.exe
    key = 小天赋效果提高|攻击和施法速度加快|最大生命|智慧|敏捷|力量
    val = 25|1|1|1|1|1
    need := 3
    hope := StrSplit(key, "|")
    hopeNum := StrSplit(val, "|")
    czInfo := ""
    If (hope.Length() < 1) {
        Return
    }
    for i, vi in hope {
        if (hopeNum[i] = "" or hopeNum[i] = "ERROR") {
            czInfo .= vi . "`n"
        } else {
            czInfo .= vi . " 满足 " . hopeNum[i] . "`n"
        }
    }
    str := "准备做装，满足以下随机 " . need . " 条：`n" . czInfo

    if IfNo(str) {
        Return
    }

    ; 是否用增幅
    UseZengFu := 1
    ; 开始做装
    tuiBian()
    whileFlag := 1
    While (whileFlag) {
        readCiZhui()
        while (ciZhuiArray.Length() < 1) {
            readCiZhui()
        }
        analyseCiZhui()
        if (target = 0) {
            if (need = 1 and ciZhuiArray.Length() = 1) {
                zengFu()
            } else {
                gaiZao()
            }
        } else if (target >= need) {
            MsgBox 完成！
            Break
        } else if (target = 1 and ciZhuiArray.Length() = 1 and UseZengFu = 1) {
            zengFu()
        } else if ((target = 2 and ciZhuiArray.Length() = 2) or (target = 1 and need = 2)) {
            fuHao()
            Sleep, 1000
            readCiZhui()
            analyseCiZhui()
            If (target < need) {
                chongZhu()
                tuiBian()
            }
        } else {
            gaiZao()
        }
    }
}

;读词缀
readCiZhui() {
    infoArray := {}
    ciZhui := ""
    ciZhuiArray := {}
    target := 0
    index := 0
    while (info = Clipboard) {
        index += 1
        if (index > 5) {
            Break
        }
        Sleep, 100
        Send ^c
    }

    info := Clipboard
    infoArray := StrSplit(info, "--------")
    czIndex := 0
    for i,vi in infoArray {
        If (InStr(vi, "物品等级")) {
            czIndex := i + 1
        }
        If (InStr(vi, "implicit") or InStr(vi, "enchant")) {
            czIndex += 1
        }
    }
    ciZhui := infoArray[czIndex]
    ciZhuiArray := StrSplit(ciZhui, "`n")
    ciZhuiArray.RemoveAt(1)
    ciZhuiArray.Pop()
    MsgBox %ciZhui%
}

;分析词缀
analyseCiZhui() {
    for i,vi in ciZhuiArray { 		;遍历词缀
        for j,vj in hope { 			;遍历目标关键词
            if (InStr(vi, vj) != 0) { 	;如果找到关键词j
                if (hopeNum[j] = "" or hopeNum[j] = "ERROR") {
                    ; 没有值，说明直接匹配字就行
                    target++
                    Break
                }
                if (InStr(vi, "基础") or InStr(vi, "每个")) {
                    RegExMatch(ciZhuiArray[i],"\d+ \- \d+", num)
                    numArray := StrSplit(num, " ")
                    num := numArray.Pop()
                } else {
                    RegExMatch(ciZhuiArray[i],"\d+", num) ;拿到数字
                }
                if (num = 0) { 		;拿到0，说明是带小数点的那条词缀，改变正则重新取值
                    RegExMatch(ciZhuiArray[i],"\d+\.\d+", num)
                }
                if (num >= hopeNum[j] or num = -1) { ;和目标比对
                    target++ 		;满足条件就+1权值
                }
                Break 				;如果中途找到词缀，j遍历可以跳过
            }
        } 
    }
    MsgBox target = %target%
}

;蜕变石
tuiBian() {
    click 55, 270 Right
    click 330, 470
}

;增幅石
zengFu() {
    click 222, 326 Right
    Click 330, 470
}

;改造石
gaiZao() {
    click 110, 270 Right
    click 330, 470
}

;富豪石
fuHao() {
    click 430, 270 Right
    click 330, 470
}

;重铸石
chongZhu() {
    click 434, 507 Right
    click 330, 470
}
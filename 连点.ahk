setMouseDelay, 10

F1::
    
    loop
    {
        Click
        Sleep, 100
        if GetKeyState("F1")
        {
            break
        }
    }
return
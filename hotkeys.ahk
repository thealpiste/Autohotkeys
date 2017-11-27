~LAlt UP::
ChordIsBroken := True
Return

!g::
ChordIsBroken := False
Input, OutputVar, L1 M
If (!ChordIsBroken && OutputVar = "M")
{ 
	Run https://accounts.google.com
}
Else
{
	SendInput %OutputVar%
}
Return

!c::
ChordIsBroken := False
Input, OutputVar, L1 M
If (!ChordIsBroken && OutputVar = "A")
{
	Run Calc
}
Else If (!ChordIsBroken && OutputVar = "M")
{
	Run Cmd
}
Else If (!ChordIsBroken && OutputVar = "H")
{
	Run "Chrome"
}
Else
{
	SendInput %OutputVar%
}
Return

!v::
ChordIsBroken := False
Input, OutputVar, L1 M
If (!ChordIsBroken && OutputVar = "S")
{
	Run "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
}
Else
{
	SendInput %OutputVar%
}
Return

!n::
ChordIsBroken := False
Input, OutputVar, L1 M
If (!ChordIsBroken && OutputVar = "P")
{
	Run "C:\Program Files\Notepad++\notepad++.exe"
}
Else
{
	SendInput %OutputVar%
}
Return

!s::
ChordIsBroken := False
Input, OutputVar, L1 M
If (!ChordIsBroken && OutputVar = "N")
{
	Run "%windir%\system32\SnippingTool.exe"
}
Else
{
	SendInput %OutputVar%
}
Return


;Map arrows keys
!i::Send { Up }
return

!k::Send { Down }
return

!j::Send { Left }
return

!l::Send { Right }
return

!u::Send { Home }
return

!o::Send { End }
return

LAlt & h:: Send ^{Left}

LAlt & l:: Send ^{Right}


;Start terminal
^!t::Run "C:\Program Files\ConEmu\ConEmu64.exe"
return

!y::Send { Volume_Up }

!p::Send { Volume_Down }

;!y::Send { Volume_Mute }

return


; Redefine only when the active window is a console window 
#IfWinActive ahk_class ConsoleWindowClass

; Close Command Window with Ctrl+w
$^w::
WinGetTitle sTitle
If (InStr(sTitle, "-")=0) { 
    Send EXIT{Enter}
} else {
    Send ^w
}

return 


; Ctrl+up / Down to scroll command window back and forward
^Up::
Send {WheelUp}
return

^Down::
Send {WheelDown}
return


; Paste in command window
^V::
; Spanish menu (Editar->Pegar, I suppose English version is the same, Edit->Paste)
Send !{Space}ep
return

#IfWinActive 


;Open current selected file with notepad++
F1::

ClipSaved := ClipboardAll

Clipboard =

Send ^c

ClipWait

FullPath := Clipboard


Loop, parse, FullPath, `n, `r

{

	IfNotExist, %A_Loopfield%

		continue

	SplitPath, A_Loopfield ,,, OutExt,

	run, "C:\Program Files\Notepad++\notepad++.exe" %A_LoopField%

}

Clipboard := ClipSaved

OutExt =

ClipSaved =

return

;Minimize active window

#s::Send,{AltDown}{Esc}{AltUp}{LWinDown}

#a::
Send,{AltDown}{ShiftDown}{Esc}{ShiftUp}{AltUp}{LWinDown}
Sleep, 0
WinMaximize,A
return


#c:: ; Windows and C closes active window
WinGetTitle, Title, A
PostMessage, 0x112, 0xF060,,, %Title%
return

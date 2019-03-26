#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

/*
	https://www.autohotkey.com/boards/viewtopic.php?f=6&t=63031&p=269249#p269249	
	example:
	---------------------------
	localhost:81/wordpress/wp-admin/plugins.php - Google Chrome ahk_class Chrome_WidgetWin_1
 	Parse error: syntax error, unexpected ')', expecting ']' in G:\Bitnami\wordpress-5.0.3-2\apps\wordpress\htdocs\wp-content\plugins\Antragsmanagement\vendor\composer\ClassLoader.php on line 46
	---------------------------	
*/
ahkEditorTit := "global-IntelliSense-everywhere-Nightly-Build ahk_class SunAwtFrame"
ahkEditorTit := "wordpress ahk_class SunAwtFrame"


while(1){
	
	/*
		needle=WinMerge - [Source\ x 2] ahk_class WinMergeWindowClassW ; mouseWindowTitle=0x14c13b4  ; 
 ; WinMove,needle=WinMerge - [Source\ x 2] ahk_class WinMergeWindowClassW ,, 2368,40, 1914,1052
		
	*/
	SetTitleMatchMode,2
	WinWait,% ahkEditorTit
	; localhost:81/wordpress/wp-admin/plugins.php - Google Chrome ahk_class Chrome_WidgetWin_1
	WinWaitActive,localhost:81/wordpress/wp-admin/plugins.php - Google Chrome ahk_class Chrome_WidgetWin_1
	;WinGetTitle,at,ahk_class #32770
	WinGetActiveTitle,at
	WinGetClass,ac,% at
	if(ac <> "Chrome_WidgetWin_1"){
		sleep,150
		Continue
		MsgBox,>%at%< >%ac%< Ops 19-03-24_17
	}
	; WinSet, AlwaysOnTop,On,% at
	send,{f5} ; dont want see the same error always so relaod it for next time
	WinWaitActive,,,5
	IfWinNotActive,
		Reload
	sleep,1000
	send,{tab 3}
	sleep,50
	send,^a
	sleep,50
	send,^c
	sleep,50
	;MsgBox, % clipboard
	/*
		Parse error: syntax error, unexpected ')', expecting ']' 
		in G:\Bitnami\wordpress-5.0.3-2\apps\wordpress\htdocs\wp-content\plugins\Antragsmanagement\vendor\composer\ClassLoader.php 
		on line 46
	*/
	if(!RegExMatch(clipboard,"i)Parse error.* in (?P<file>[^\n\s]+\.php).*? line (?P<line>\d+)",m_))
	{
		Sleep,3000
		Reload
	}
	msg =
	(
	%m_line%
	%m_file%
	)
	;MsgBox,% msg
	Suspend,On
	
	jump2file(ahkEditorTit,m_file)
	jump2line(ahkEditorTit,m_line)
	
	; WinActivate,% at
	
	
	;WinWaitClose,% at
	WinWaitNotActive,% at
	if(RegExMatch(at,"^\d+:")) ; feedbackMsgBox() often close byItself
		Pause,On
	
	Suspend,Off
}



jump2file(ahkEditorTit,m_file){
	WinActivateTry(ahkEditorTit,9)
	Suspend,On
	Send,^+n
	tooltip,WinWaitActive
	if(0){ ; not solution
		needle=Find in Path  ahk_class SunAwtDialog 
		SetTitleMatchMode,2
		WinWait,% needle
	}else ;workaround
		sleep,180
	tooltip,
	;Send,{AltDown}kk{AltUp}{tab}^a
	;Sleep,100
	sendByStrgV(m_file)
	;Send,%m_file%	
	Sleep,1250
	Send,{enter}
	Suspend,Off
}
findinpath(ahkEditorTit,m_file){
	WinActivateTry(ahkEditorTit,9)
	Send,^+f
	MsgBox, nakjdfaös asdf hasdk jfh
	tooltip,WinWaitActive
	if(0){ ; not solution
		needle=Find in Path  ahk_class SunAwtDialog 
		SetTitleMatchMode,2
		WinWait,% needle
	}else ;workaround
		WinWaitNotActive,% ahkEditorTit
	tooltip,
	Send,{AltDown}kk{AltUp}{tab}^a
	Sleep,100
	Send,%m_file%	
	Sleep,100
	ExitApp
	Send,{enter}
	
	
	; Send,{esc}
	; Sleep,9000
	
	
	Reload
	;{enter}
}

jump2line(ahkEditorTit,m_line){
	Suspend,On
	WinActivateTry(ahkEditorTit,9)
; ControlSend,,^g,% ahkEditorTit
	Suspend,On
	Send,^g
	tooltip,WinWaitActive
; for some reason active windw stays to:	global-IntelliSense-everywhere-Nightly-Build [G:\fre\git\github\global-IntelliSense-everywhere-Nightly-Build] - ...\Source\inc_ahk\gi\ReadActionList.inc.ahk [global-IntelliSense-everywhere-Nightly-Build] - IntelliJ IDEA (Administrator)
; but i coud wait for it like this:
	WinWait,Go to Line/Column ahk_class SunAwtDialog 
	tooltip,
	;Send,%m_line%
	sendByStrgV(m_line)
	;sleep,160
	;Pause,On
	Send,{enter}
	Suspend,Off
}


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk


#NoEnv
#InstallKeybdHook
#singleinstance force
SetBatchLines, -1
SetWinDelay, -1
SetTitleMatchMode, 2
SendMode Input

WS_EX_LAYOUTRTL := 0x00400000L
WS_EX_RTLREADING := 0x00002000L

Gui resulta: +ToolWindow
Gui resulta:Add, Button, x11 y127 w80 h23 +Default gGoogle, Google it 
Gui resulta:Add, Button, x424 y127 w80 h23 gArAgain, Try Arabic
Gui resulta:Add, Button, x216 y127 w80 h23 gCopy, Just Copy
Gui resulta:Font, s11.5 w30 c000000, Bookman Old Style
;Gui, resulta:Add, Button, W100 H25 Y50 X0 , Button A 

Gui resulta:Add, Edit, x13 y0 w481 h123 wrap center  vSearcho


global arabicLL := "ar"


;Gui resulta: +ToolWindow
;;Gui resulta:Add, Button,   gGoogle, Google it 
;Gui resulta:Add, Button,  gArAgain, Try Arabic
;Gui resulta:Add, Button,  gCopy, Just Copy
;Gui resulta:Font, s11.2 w30 c8000FF, Bookman Old Style

;Gui resulta:Add, Text , w45 h444 Wrap Center vSearcho 

SetTimer, waitForInput, 40





RedPen := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 5, "uint", 0xff)
	CoordMode Mouse, Screen

Gui, penGUIb:+Alwaysontop -Caption +LastFound +ToolWindow +E0x20 -DPIScale 

Gui, penGUIb:Color, 84446D
;WinSet, TransColor, 130




Search := ""

global PreStartMouseX := 0
global PreStartMouseY := 0
isEnabled:= false
isDragging := false

Esc:: reload GUI, destroy

OnMessage(0x14, "WM_ERASEBKGND")


waitForInput:

								;msgbox yoo

	f2btn := GetKeyState("F2", "P")
			if f2btn 
			{
	

				
					;if WinActive("‎ahk_exe chrome.exe") or WinActive("‎ahk_exe firefox.exe") or WinActive("‎- OneNote for Windows 10")
					{				
						
							isEnabled:= true
							;msgbox yoo
						
					}	
			}
			

return

Google:
{
	 Gui, Submit


	For i, u in toEncode		; check/replace loop for unsafe chars
		StringReplace, Searcho, Searcho, %	u, %	e[i], All
		;Run, http://www.google.com/search?q=%Searcho%
		Run chrome.exe --app="http://www.google.com/search?q=%Searcho%" 

		 ;Gui, resulta:cancel

RELOAD
}
return

ArAgain:
{

					;hBitmap := HBitmapFromScreen(x1, y1, x2-x1, y2-y1)
	
					pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
					;DllCall("DeleteObject", "Ptr", hBitmap)
					Search := ocr(pIRandomAccessStream, "ar", "ar")
					_Search := "hello a momnet ago"
					_Search := Search
					
					;_Search := reverseWordsOrder(Search)
					
					GuiControl , resulta: , Searcho, %_Search%
					
					;Gui resulta:Add, Edit, x13 y0 w481 h123  wrap center  vSearcho2
					 
					GuiControl, resulta: +e0x400000, Searcho
					GuiControl, resulta: +e0x2, Searcho
					
					;Guicontrol,, Hide, vSearcho
					
					;Gui, +e0x400000
						;GuiControl, +AltSubmit -g, MyListBox
					
					;clipboard := _Search
}
return

Copy:
{

 ;Gui, resulta:hide
 
 copiedreslt := "44"
; ControlGet ,copiedreslt ,  Searcho , SnapOCR
 ;ControlGet, copiedreslt, Enabled ,, resulta:Searcho, SnapOCR
 ;GuiControlGet, Searcho, resulta:
 
 Gui, Submit
 copiedreslt := Searcho
 
 clipboard := copiedreslt

 ;msgbox %copiedreslt%
 
 RELOAD
 
}
return

#if isEnabled
Lshift::

	if isEnabled
	{
	 MouseGetPos, xorigin, yorigin
	 SetTimer, rectangle, 10
	 
	 isEnabled := false
	 isDragging := true
	}
	isEnabled := false
	KeyWait LSHIFT
return








#if isDragging
LSHIFT up::
		if !isDragging 
			return
	
	isDragging := false
    SetTimer, rectangle, Off
	 Gui, penGUIb:hide
	 
	CoordMode Mouse, Screen
    MouseGetPos, x2, y2
    
    ; Allow dragging to the left of the click point.
    if (x2 < xorigin) {
        x1 := x2
        x2 := xorigin
    } else
        x1 := xorigin
    
    ; Allow dragging above the click point.
    if (y2 < yorigin) {
        y1 := y2
        y2 := yorigin
    } else
        y1 := yorigin
		
		
	  
	  
	hBitmap := HBitmapFromScreen(x1, y1, x2-x1, y2-y1)
	
	pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
	;DllCall("DeleteObject", "Ptr", hBitmap)
	Search := ocr(pIRandomAccessStream, "en", "en")
		_Search := "hello a momnet ago"
		_Search := Search
		
							
					
			;msgbox %_Search%
	
	if Search
	{
					GUI, resulta:Show,  AutoSize, SnapOCR
					GuiControl , resulta: , Searcho, %_Search%
					GuiControl, +E0x000000 -e0x400000, Searcho
					;clipboard := _Search
					
					SetTimer, closeOnLoseFocus ,-1

		
	}else 
		{
					;hBitmap := HBitmapFromScreen(x1, y1, x2-x1, y2-y1)
	
					pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
					;DllCall("DeleteObject", "Ptr", hBitmap)
					Search := ocr(pIRandomAccessStream, "ar", "ar")
					_Search := "hello a momnet ago"
					_Search := Search
					
					
					
						if Search
						{
							SetTimer, closeOnLoseFocus ,-1
											GUI, resulta:Show,  AutoSize, SnapOCR
					
							GuiControl , resulta: , Searcho, %_Search%
									
									;GuiControl, resulta:, +e0x400000, Searcho
							;clipboard := _Search

					
						}
		}
							
	
return

reverseWordsOrder(sentece)
{
	_sentece := sentece
	_sentece := StrSplit(_sentece, " ")
	i := _sentece.length()
	while(i > 0)
	{
		final .= _sentece[i] " "
		i--
	}
	
	return final
}


WM_ERASEBKGND(wParam, lParam)
{
    global x1, y1, x2, y2, RedPen
    Critical 50
    if A_Gui = 1
    {
			CoordMode Mouse, Screen
        ; Retrieve stock brush.
        blackBrush := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen := DllCall("SelectObject", "uint", wParam, "uint", RedPen)
        oldBrush := DllCall("SelectObject", "uint", wParam, "uint", blackBrush)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", x2-x1, "int", y2-y1)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush)
        return 1
    }
}


rectangle:
		CoordMode Mouse, Screen
    MouseGetPos, x2, y2
	
    ; Has the mouse moved?
    if (x1 y1) = (x2 y2)
        return
    
    ; Allow dragging to the left of the click point.
    if (x2 < xorigin) {
        x1 := x2
        x2 := xorigin
    } else
        x1 := xorigin
    
    ; Allow dragging above the click point.
    if (y2 < yorigin) {
        y1 := y2
        y2 := yorigin
    } else
        y1 := yorigin
   
    Gui, penGUIb:Show, % "NA X" x1 " Y" y1 " W" x2-x1 " H" y2-y1
    Gui, penGUIb:+LastFound
	WinSet, TransColor, Purple 100 
    DllCall("RedrawWindow", "uint", WinExist(), "uint", 0, "uint", 0, "uint", 5)
	
	
return




ReplaceSystemCursors(IDC = "")
{
   static IMAGE_CURSOR := 2, SPI_SETCURSORS := 0x57
        , exitFunc := Func("ReplaceSystemCursors").Bind("")
        , SysCursors := { IDC_APPSTARTING: 32650
                        , IDC_ARROW      : 32512
                        , IDC_CROSS      : 32515
                        , IDC_HAND       : 32649
                        , IDC_HELP       : 32651
                        , IDC_IBEAM      : 32513
                        , IDC_NO         : 32648
                        , IDC_SIZEALL    : 32646
                        , IDC_SIZENESW   : 32643
                        , IDC_SIZENWSE   : 32642
                        , IDC_SIZEWE     : 32644
                        , IDC_SIZENS     : 32645 
                        , IDC_UPARROW    : 32516
                        , IDC_WAIT       : 32514 }
   if !IDC {
      DllCall("SystemParametersInfo", UInt, SPI_SETCURSORS, UInt, 0, UInt, 0, UInt, 0)
      OnExit(exitFunc, 0)
   }
   else  {
      hCursor := DllCall("LoadCursor", Ptr, 0, UInt, SysCursors[IDC], Ptr)
      for k, v in SysCursors  {
         hCopy := DllCall("CopyImage", Ptr, hCursor, UInt, IMAGE_CURSOR, Int, 0, Int, 0, UInt, 0, Ptr)
         DllCall("SetSystemCursor", Ptr, hCopy, UInt, v)
      }
      OnExit(exitFunc)
   }
}





HBitmapFromScreen(X, Y, W, H) {
   HDC := DllCall("GetDC", "Ptr", 0, "UPtr")
   HBM := DllCall("CreateCompatibleBitmap", "Ptr", HDC, "Int", W, "Int", H, "UPtr")
   PDC := DllCall("CreateCompatibleDC", "Ptr", HDC, "UPtr")
   DllCall("SelectObject", "Ptr", PDC, "Ptr", HBM)
   DllCall("BitBlt", "Ptr", PDC, "Int", 0, "Int", 0, "Int", W, "Int", H
                   , "Ptr", HDC, "Int", X, "Int", Y, "UInt", 0x00CC0020)
   DllCall("DeleteDC", "Ptr", PDC)
   DllCall("ReleaseDC", "Ptr", 0, "Ptr", HDC)
   Return HBM
}

HBitmapToRandomAccessStream(hBitmap) {
   static IID_IRandomAccessStream := "{905A0FE1-BC53-11DF-8C49-001E4FC686DA}"
        , IID_IPicture            := "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
        , PICTYPE_BITMAP := 1
        , BSOS_DEFAULT   := 0
        
   DllCall("Ole32\CreateStreamOnHGlobal", "Ptr", 0, "UInt", true, "PtrP", pIStream, "UInt")
   
   VarSetCapacity(PICTDESC, sz := 8 + A_PtrSize*2, 0)
   NumPut(sz, PICTDESC)
   NumPut(PICTYPE_BITMAP, PICTDESC, 4)
   NumPut(hBitmap, PICTDESC, 8)
   riid := CLSIDFromString(IID_IPicture, GUID1)
   DllCall("OleAut32\OleCreatePictureIndirect", "Ptr", &PICTDESC, "Ptr", riid, "UInt", false, "PtrP", pIPicture, "UInt")
   ; IPicture::SaveAsFile
   DllCall(NumGet(NumGet(pIPicture+0) + A_PtrSize*15), "Ptr", pIPicture, "Ptr", pIStream, "UInt", true, "UIntP", size, "UInt")
   riid := CLSIDFromString(IID_IRandomAccessStream, GUID2)
   DllCall("ShCore\CreateRandomAccessStreamOverStream", "Ptr", pIStream, "UInt", BSOS_DEFAULT, "Ptr", riid, "PtrP", pIRandomAccessStream, "UInt")
   ObjRelease(pIPicture)
   ObjRelease(pIStream)
   Return pIRandomAccessStream
}

CLSIDFromString(IID, ByRef CLSID) {
   VarSetCapacity(CLSID, 16, 0)
   if res := DllCall("ole32\CLSIDFromString", "WStr", IID, "Ptr", &CLSID, "UInt")
      throw Exception("CLSIDFromString failed. Error: " . Format("{:#x}", res))
   Return &CLSID
}


ocr(file, lang := "FirstFromAvailableLanguages", languageCheck := "ar")
{
   static OcrEngineStatics, OcrEngine, MaxDimension, LanguageFactory, Language, CurrentLanguage, BitmapDecoderStatics, GlobalizationPreferencesStatics
   if (OcrEngineStatics = "")
   {
      CreateClass("Windows.Globalization.Language", ILanguageFactory := "{9B0252AC-0C27-44F8-B792-9793FB66C63E}", LanguageFactory)
      CreateClass("Windows.Graphics.Imaging.BitmapDecoder", IBitmapDecoderStatics := "{438CCB26-BCEF-4E95-BAD6-23A822E58D01}", BitmapDecoderStatics)
      CreateClass("Windows.Media.Ocr.OcrEngine", IOcrEngineStatics := "{5BFFA85A-3384-3540-9940-699120D428A8}", OcrEngineStatics)
      DllCall(NumGet(NumGet(OcrEngineStatics+0)+6*A_PtrSize), "ptr", OcrEngineStatics, "uint*", MaxDimension)   ; MaxImageDimension
   }
   if (file = "ShowAvailableLanguages")
   {
      if (GlobalizationPreferencesStatics = "")
         CreateClass("Windows.System.UserProfile.GlobalizationPreferences", IGlobalizationPreferencesStatics := "{01BF4326-ED37-4E96-B0E9-C1340D1EA158}", GlobalizationPreferencesStatics)
      DllCall(NumGet(NumGet(GlobalizationPreferencesStatics+0)+9*A_PtrSize), "ptr", GlobalizationPreferencesStatics, "ptr*", LanguageList)   ; get_Languages
      DllCall(NumGet(NumGet(LanguageList+0)+7*A_PtrSize), "ptr", LanguageList, "int*", count)   ; count
      loop % count
      {
         DllCall(NumGet(NumGet(LanguageList+0)+6*A_PtrSize), "ptr", LanguageList, "int", A_Index-1, "ptr*", hString)   ; get_Item
         DllCall(NumGet(NumGet(LanguageFactory+0)+6*A_PtrSize), "ptr", LanguageFactory, "ptr", hString, "ptr*", LanguageTest)   ; CreateLanguage
         DllCall(NumGet(NumGet(OcrEngineStatics+0)+8*A_PtrSize), "ptr", OcrEngineStatics, "ptr", LanguageTest, "int*", bool)   ; IsLanguageSupported
         if (bool = 1)
         {
            DllCall(NumGet(NumGet(LanguageTest+0)+6*A_PtrSize), "ptr", LanguageTest, "ptr*", hText)
            buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
            text .= StrGet(buffer, "UTF-16") "`n"
         }
         ObjRelease(LanguageTest)
      }
      ObjRelease(LanguageList)
	  
	  
      return text
   }
   if (lang != CurrentLanguage) or (lang = "FirstFromAvailableLanguages")
   {
      if (OcrEngine != "")
      {
         ObjRelease(OcrEngine)
         if (CurrentLanguage != "FirstFromAvailableLanguages")
            ObjRelease(Language)
      }
      if (lang = "FirstFromAvailableLanguages")
         DllCall(NumGet(NumGet(OcrEngineStatics+0)+10*A_PtrSize), "ptr", OcrEngineStatics, "ptr*", OcrEngine)   ; TryCreateFromUserProfileLanguages
      else
      {
         CreateHString(lang, hString)
         DllCall(NumGet(NumGet(LanguageFactory+0)+6*A_PtrSize), "ptr", LanguageFactory, "ptr", hString, "ptr*", Language)   ; CreateLanguage
         DeleteHString(hString)
         DllCall(NumGet(NumGet(OcrEngineStatics+0)+9*A_PtrSize), "ptr", OcrEngineStatics, ptr, Language, "ptr*", OcrEngine)   ; TryCreateFromLanguage
      }
      if (OcrEngine = 0)
      {
         msgbox Can not use language "%lang%" for OCR, please install language pack.
         ExitApp
      }
      CurrentLanguage := lang
   }
   IRandomAccessStream := file
   DllCall(NumGet(NumGet(BitmapDecoderStatics+0)+14*A_PtrSize), "ptr", BitmapDecoderStatics, "ptr", IRandomAccessStream, "ptr*", BitmapDecoder)   ; CreateAsync
   WaitForAsync(BitmapDecoder)
   BitmapFrame := ComObjQuery(BitmapDecoder, IBitmapFrame := "{72A49A1C-8081-438D-91BC-94ECFC8185C6}")
   DllCall(NumGet(NumGet(BitmapFrame+0)+12*A_PtrSize), "ptr", BitmapFrame, "uint*", width)   ; get_PixelWidth
   DllCall(NumGet(NumGet(BitmapFrame+0)+13*A_PtrSize), "ptr", BitmapFrame, "uint*", height)   ; get_PixelHeight
   if (width > MaxDimension) or (height > MaxDimension)
   {
      msgbox Image is to big - %width%x%height%.`nIt should be maximum - %MaxDimension% pixels
      ExitApp
   }
   BitmapFrameWithSoftwareBitmap := ComObjQuery(BitmapDecoder, IBitmapFrameWithSoftwareBitmap := "{FE287C9A-420C-4963-87AD-691436E08383}")
   DllCall(NumGet(NumGet(BitmapFrameWithSoftwareBitmap+0)+6*A_PtrSize), "ptr", BitmapFrameWithSoftwareBitmap, "ptr*", SoftwareBitmap)   ; GetSoftwareBitmapAsync
   WaitForAsync(SoftwareBitmap)
   DllCall(NumGet(NumGet(OcrEngine+0)+6*A_PtrSize), "ptr", OcrEngine, ptr, SoftwareBitmap, "ptr*", OcrResult)   ; RecognizeAsync
   WaitForAsync(OcrResult)
   DllCall(NumGet(NumGet(OcrResult+0)+6*A_PtrSize), "ptr", OcrResult, "ptr*", LinesList)   ; get_Lines
   DllCall(NumGet(NumGet(LinesList+0)+7*A_PtrSize), "ptr", LinesList, "int*", count)   ; count
   loop % count
   {
      DllCall(NumGet(NumGet(LinesList+0)+6*A_PtrSize), "ptr", LinesList, "int", A_Index-1, "ptr*", OcrLine)
      DllCall(NumGet(NumGet(OcrLine+0)+7*A_PtrSize), "ptr", OcrLine, "ptr*", hText) 
      buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
	  
      newTextLine := StrGet(buffer, "UTF-16") ""
	  
	  if (languageCheck == arabicLL)
		{

			newTextLine := reverseWordsOrder(newTextLine)
		}
		
		text .= newTextLine
		
		
		if (count != A_Index)
		{
		text .= "`n"
		}
		
		
		;msgbox %count%
		
			
      ObjRelease(OcrLine)
   }
   Close := ComObjQuery(IRandomAccessStream, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
   DllCall(NumGet(NumGet(Close+0)+6*A_PtrSize), "ptr", Close)   ; Close
   ObjRelease(Close)
   Close := ComObjQuery(SoftwareBitmap, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
   DllCall(NumGet(NumGet(Close+0)+6*A_PtrSize), "ptr", Close)   ; Close
   ObjRelease(Close)
   ObjRelease(IRandomAccessStream)
   ObjRelease(BitmapDecoder)
   ObjRelease(BitmapFrame)
   ObjRelease(BitmapFrameWithSoftwareBitmap)
   ObjRelease(SoftwareBitmap)
   ObjRelease(OcrResult)
   ObjRelease(LinesList)
   return text
}



CreateClass(string, interface, ByRef Class)
{
   CreateHString(string, hString)
   VarSetCapacity(GUID, 16)
   DllCall("ole32\CLSIDFromString", "wstr", interface, "ptr", &GUID)
   result := DllCall("Combase.dll\RoGetActivationFactory", "ptr", hString, "ptr", &GUID, "ptr*", Class)
   if (result != 0)
   {
      if (result = 0x80004002)
         msgbox No such interface supported
      else if (result = 0x80040154)
         msgbox Class not registered
      else
         msgbox error: %result%
      ExitApp
   }
   DeleteHString(hString)
}

CreateHString(string, ByRef hString)
{
    DllCall("Combase.dll\WindowsCreateString", "wstr", string, "uint", StrLen(string), "ptr*", hString)
}

DeleteHString(hString)
{
   DllCall("Combase.dll\WindowsDeleteString", "ptr", hString)
}

WaitForAsync(ByRef Object)
{
   AsyncInfo := ComObjQuery(Object, IAsyncInfo := "{00000036-0000-0000-C000-000000000046}")
   loop
   {
      DllCall(NumGet(NumGet(AsyncInfo+0)+7*A_PtrSize), "ptr", AsyncInfo, "uint*", status)   ; IAsyncInfo.Status
      if (status != 0)
      {
         if (status != 1)
         {
            DllCall(NumGet(NumGet(AsyncInfo+0)+8*A_PtrSize), "ptr", AsyncInfo, "uint*", ErrorCode)   ; IAsyncInfo.ErrorCode
            msgbox AsyncInfo status error: %ErrorCode%
            ExitApp
         }
         ObjRelease(AsyncInfo)
         break
      }
      sleep 10
   }
   DllCall(NumGet(NumGet(Object+0)+8*A_PtrSize), "ptr", Object, "ptr*", ObjectResult)   ; GetResults
   ObjRelease(Object)
   Object := ObjectResult
}



toEncode :=	[" ","%", """", "#", "&"
 , "/", ":", ";", "<"z
 , "=", ">", "?", "@"
 , "[", "\", "]", "^"
 , "``", "{", "|", "}", "~"]

e :=	["+","%25", "%22", "%23", "%26"
 , "%2F", "%3A", "%3B", "%3C"
 , "%3D", "%3E", "%3F", "%40"
 , "%5B", "%5C", "%5D", "%5E"
 , "%60", "%7B", "%7C", "%7D", "%7E"]
 
 
 
 closeOnLoseFocus:
WinWaitNotActive, SnapOCR

reload

;msgbox what??

return


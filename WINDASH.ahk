#Requires AutoHotkey v2.0

; GUIS ============================================================================================================


; cmd attribute set GUI----------------------------------------------------------------------------------------V

folderpath := "null" ; sets the folder path to null

iconpath := "null" ; sets the folder Icon path to null

;creates a GUI called "cmdgui" that has the title: "file icon setter"
cmdgui := Gui("","file icon setter")

folderpathedit := cmdgui.Add("Edit", "w250", "Path to folder")

;adds a button to the cmd GUI at x+5 y+5 that says "path"
folderpathbutton := cmdgui.Add("Button", "x+5 y5 w80 h25", "path")

;creates a textbox that says: path to icon
foldericonedit := cmdgui.Add("Edit", "w250 x10", "Path to icon")

;adds a button to the cmd GUI at x+5 y+5 that says "path"
iconpathbutton := cmdgui.Add("Button", "x+5 w80 h25", "path")

;adds a button to the cmd GUI at x10 y30 that says "OK"
OK := cmdgui.Add("Button", "Default w80 x10 y60", "OK") 



;executes "choosefolderpath" function, passing 2 values to it, when the button is pressed
folderpathbutton.OnEvent('Click', choosefolderpath) 


iconpathbutton.OnEvent('Click', chooseiconpath)


OK.OnEvent('Click', okclicked) 


; CMD GUI functions

chooseiconpath(*) {
    iconpath := FileSelect("","Select a folder")
    foldericonedit.Text := iconpath
}


choosefolderpath(*) {
    folderpath := FileSelect("D","Select a folder")
    folderpathedit.Text := folderpath
}



okclicked(*) {
    folderpath := folderpathedit.Text
    iconpath := foldericonedit.Text
    SoundPlay(A_ScriptDir "/Sounds/Beep.wav")
    if FileExist(folderpath "/desktop.ini") {

        if (MsgBox("it seems that this folder already has configerations. Do you wish to proceed?", "Windash", "YesNo") == "Yes") {
            generategui()
        } else {
            SoundPlay(A_ScriptDir "/Sounds/Beep.wav")
            cmdgui.Hide()
            MsgBox("operation canceled.","Windash")
        }
    } else {
        generategui()
    }
}

generategui() {
    folderpath := folderpathedit.Text
    iconpath := foldericonedit.Text
    ;attributes the folder that needs an icon
    cmdgui.Hide()

    FileSetAttrib("S", folderpath,"D")

    
    ;creates desktop.ini file with path to icon
    if (FileExist(folderpath "\desktop.ini")) {
    FileDelete(folderpath "\desktop.ini")
    }
    FileAppend("[.ShellClassInfo]`nIconResource=", folderpath "/desktop.ini")
    FileAppend(iconpath, folderpath "/desktop.ini")
    FileAppend(",0", folderpath "/desktop.ini")
    FileSetAttrib("H", folderpath "\desktop.ini","F")
}


; Dashboard GUI------------------------------------------------------------------------------------------------V

Dashboard := Gui("-Resize -MaximizeBox -Caption","QC Dashboard")
w := 0, h := 0
Dashboard.BackColor := "212121"

seperator := 150
offset := 75 / 2

;item declarations

; button row one

; add icon button
addicon := Dashboard.Add('Picture',"x" offset " y" offset " w100 h100","Icons/NEW_FOLDER_ICON.png")

;placeholder
DB2 := Dashboard.Add('Picture', "x" (1 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB3 := Dashboard.Add('Picture', "x" (2 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB4 := Dashboard.Add('Picture', "x" (3 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB5 := Dashboard.Add('Picture', "x" (4 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB6 := Dashboard.Add('Picture', "x" (5 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB7 := Dashboard.Add('Picture', "x" (6 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB8 := Dashboard.Add('Picture', "x" (7 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB9 := Dashboard.Add('Picture', "x" (8 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")

;placeholder
DB10 := Dashboard.Add('Picture', "x" (9 * seperator) + offset " y" (0 * seperator) + offset " w100 h100", "Icons/Placeholder.png")





closedash := Dashboard.Add('Picture', "x" (9 * seperator) + offset " y" (4 * seperator) + offset " w100 h100", "Icons/CLOSE_DASH_GUI.png")


;item uses
closedash.OnEvent("Click",  closedashgui)

addicon.OnEvent("Click" , openicongui)

; GUI button functions ========================================================================================================================

perbutton() {
    Dashboard.Hide()
    SoundPlay(A_ScriptDir "/Sounds/Boop.wav")
}

;item use functions

closedashgui(*) {
    Dashboard.Hide()
    SoundPlay(A_ScriptDir "/Sounds/Beep.wav")
}


openicongui(*) {
    perbutton()
    cmdgui.Show()
}




;hotkeys


;shows the dashboard when print-screen is pressed
PrintScreen::{
    ;if a window with the title bar "QC Dashboard" doesn't exist
    if (!WinExist("QC Dashboard")) {
        Dashboard.Show("x0 y0 w" A_ScreenWidth " h" A_ScreenHeight)
    }
}



;functions



;logs file contents of a directory
log_file_contents(directory) {
    FileAppend(FileRead(directory),
    A_ScriptDir "/logs/log (" String(FormatTime(A_Now,"h.m.ss d_M_yyyy")) ").log")
}


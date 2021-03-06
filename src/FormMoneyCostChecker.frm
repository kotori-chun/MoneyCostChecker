VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormMoneyCostChecker 
   Caption         =   "UserForm1"
   ClientHeight    =   5820
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   7755
   OleObjectBlob   =   "FormMoneyCostChecker.frx":0000
   StartUpPosition =   1  'I[i[ tH[Ì
End
Attribute VB_Name = "FormMoneyCostChecker"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Rem --------------------------------------------------------------------------------
Rem
Rem  @module        FormMoneyCostChecker
Rem
Rem  @description   Time is money.
Rem                 ïcÉ©¯Ä¢éRXgðJEg·éc[
Rem
Rem  @update        2020/05/15
Rem
Rem  @author        @KotorinChunChun (GitHub / Twitter)
Rem
Rem  @license       MIT (http://www.opensource.org/licenses/mit-license.php)
Rem
Rem --------------------------------------------------------------------------------
Rem
Rem  @note
Rem     âè_FÒW@\AÛ¶@\AgåoOAvªÔªK·¬
Rem
Rem --------------------------------------------------------------------------------

Option Explicit

Const WIDTH_DEFAULT = 400
Const HEIGHT_MIN = 160
Const HEIGHT_MAX = 320

Const SPIN_DEFAULT_VALUE = 50

Private IsClosing As Boolean
Private TotalCost_ As Double

#If VBA7 Then
    Private Declare PtrSafe Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)
#Else
    Private Declare Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)
#End If

Private Sub Update\èlï()
    Dim ïc\èÔ As Date
    ïc\èÔ = I¹ú - Jnú
    ToggleButton_StartEnd.Enabled = (ïc\èÔ > 0)
    
    Dim \èlï As Long
    \èlï = bP¿ * (ïc\èÔ * 24 * 60 * 60)
    
    Label_PlanPrice.Caption = _
        "@ïc\èÔF" & Format(ïc\èÔ, "hh:mm") & _
        "@\èlïF" & Format(\èlï, "0,000") & "~"
End Sub

Private Sub TextBox_EndDate_Change(): Call Update\èlï: End Sub
Private Sub TextBox_StartDate_Change(): Call Update\èlï: End Sub
Private Sub TextBox_EndTime_Change(): Call Update\èlï: End Sub
Private Sub TextBox_StartTime_Change(): Call Update\èlï: End Sub

Private Sub ListBox1_DblClick(ByVal Cancel As MSForms.ReturnBoolean)
    Call ListItemEdit
End Sub

Private Function GetðEP¿(ByRef ðE, ByRef P¿) As Boolean
    ðE = InputBox("ðE", "", ðE)
    If ðE = "" Then Exit Function
    
    P¿ = InputBox("lï", "", P¿)
    If P¿ = "" Then Exit Function
    If Not IsNumStr(P¿) Then Exit Function
    
    GetðEP¿ = True
End Function

Private Sub ListItemEdit()
    Dim colItems As Object 'Dictionary
    Set colItems = ListBox_GetSelectedItemsDictionary(ListBox1)
    
    Dim rowIndex
    For Each rowIndex In colItems.Keys
        Dim ðE: ðE = colItems(rowIndex)(0)
        Dim P¿: P¿ = colItems(rowIndex)(1)
        If GetðEP¿(ðE, P¿) Then
            ListBox1.List(rowIndex, 0) = ðE
            ListBox1.List(rowIndex, 1) = P¿
        End If
    Next
End Sub

Private Sub CommandButton_Add_Click()
    Dim ðE: ðE = "ÙÉáçç³ñ"
    Dim P¿: P¿ = "1000"
    Dim l: l = "0"
    If Not GetðEP¿(ðE, P¿) Then Exit Sub
    
    Dim item: item = Array(ðE, P¿, l)
    Call ListBox_AddItem(ListBox1, item)
End Sub

Private Sub ListItemCountUp(add As Long)
    Dim colItems As Object 'Dictionary
    Set colItems = ListBox_GetSelectedItemsDictionary(ListBox1)
    
    Dim rowIndex
    For Each rowIndex In colItems.Keys
        ListBox1.List(rowIndex, 2) = WorksheetFunction.Max(0, colItems(rowIndex)(2) + add)
    Next
    
    Call Update\èlï
End Sub

Private Sub CommandButton_Minus_Click(): Call ListItemCountUp(-1): End Sub
Private Sub CommandButton_Plus_Click(): Call ListItemCountUp(1): End Sub

Private Sub SpinButton_MemberCount_Change()
    Call ListItemCountUp(SpinButton_MemberCount.Value - SPIN_DEFAULT_VALUE)
    SpinButton_MemberCount.Value = SPIN_DEFAULT_VALUE
End Sub

Private Property Get TotalCost() As Double: TotalCost = TotalCost_: End Property
Private Property Let TotalCost(set_cost As Double)
    TotalCost_ = set_cost
    CommandButton_Reset.Visible = (TotalCost_ > 0)
    Label_lï.Caption = Format(TotalCost_, "#,##0") & "~"
End Property
Private Sub TotalCost_Add(add_cost As Double)
    TotalCost = TotalCost + add_cost
End Sub

Private Sub CommandButton_Reset_Click()
    TotalCost = 0
End Sub

Private Property Get bP¿() As Double
    Dim ret As Double
    Dim data: data = ListBox1.List
    Dim i As Long
    For i = LBound(data) To UBound(data)
        ret = ret + (data(i, 1) / 60 / 60 * data(i, 2))
    Next
    bP¿ = ret
End Property

Private Sub ToggleButton_StartEnd_Click()
    ConfigCtrlEnabled = False
    Dim ïc\èÔ As Date
    ïc\èÔ = I¹ú - Jnú
    
    Dim OiFúl As Long: OiFúl = Label_lï.ForeColor
    Dim wiFúl As Long: wiFúl = Label_lï.BackColor
    
    'JnÒ¿
    Do
        If Jnú < Now() Then Exit Do
        
        Dim JnÜÅcè As Date
        JnÜÅcè = Jnú - Now()

        Label_bZ[W.Caption = "ïcJnÜÅcè : " & JnÜÅcè
        
        Call Sleep(100)
        DoEvents
    Loop
    
    'Jnã
    Do
        If Not ToggleButton_StartEnd.Value Then Exit Do
        If IsClosing Then Exit Do
        
        Dim oßÔ As Date
        oßÔ = Now() - Jnú
'        oßÔ = CDate("1:00:00")

        Dim cèÔ As Date
        cèÔ = I¹ú - Now()
        
        Label_bZ[W.Caption = "oßÔ :  " & Format(oßÔ, "hh:mm:ss") & _
                                    "@b : " & Format(bP¿, "0.00") & "~" & _
                                    "@ïcI¹ÜÅcè : " & cèÔ
        
        '10ªðÁ½çFðØèÖ¦éá
'        Label_lï.ForeColor = IIf(cèÔ < (1 / 24 / 60 * 10), vbRed, vbBlack)
        'i»¦É¶ÄFðtF[hC³¹éá
        Dim i»¦ As Long
        i»¦ = CLng(CDbl(oßÔ) / CDbl(ïc\èÔ) * 100)
        If i»¦ <= 100 Then
            Label_lï.ForeColor = GetFadeColor(OiFúl, vbRed, i»¦)
        Else
            If Label_lï.BackColor = wiFúl Then
                Label_lï.ForeColor = vbWhite
                Label_lï.BackColor = vbRed
            Else
                Label_lï.ForeColor = vbRed
                Label_lï.BackColor = wiFúl
            End If
        End If
        
        Call TotalCost_Add(bP¿ / 5)
        Call Sleep(200)
        DoEvents
    Loop
    Label_lï.ForeColor = OiFúl
    Label_lï.BackColor = wiFúl
    ConfigCtrlEnabled = True
End Sub

Private Property Let ConfigCtrlEnabled(set_enabled As Boolean)
    
    CommandButton_Reset.Enabled = set_enabled

    TextBox_EndDate.Enabled = set_enabled
    TextBox_EndTime.Enabled = set_enabled

    TextBox_StartDate.Enabled = set_enabled
    TextBox_StartTime.Enabled = set_enabled
    
    ListBox1.Enabled = set_enabled
    CommandButton_Add.Enabled = set_enabled
    SpinButton_MemberCount.Enabled = set_enabled
    
End Property

Private Property Get Jnú() As Date
    Static LastJnú
    On Error Resume Next
    Jnú = CDate(TextBox_StartDate.Text & " " & TextBox_StartTime.Text & ":00")
    On Error GoTo 0
    If Jnú = 0 Then
        Jnú = LastJnú
        TextBox_StartDate.BackColor = vbRed
        TextBox_StartTime.BackColor = vbRed
    Else
        LastJnú = Jnú
        TextBox_StartDate.BackColor = vbWhite
        TextBox_StartTime.BackColor = vbWhite
    End If
End Property
Private Property Let Jnú(dt As Date)
    TextBox_StartDate.Text = Format(dt, "yyyy/mm/dd")
End Property
Private Property Let JnÔ(dt As Date)
    TextBox_StartTime.Text = Format(dt, "hh:mm")
End Property

Private Property Get I¹ú() As Date
    Static LastI¹ú
    On Error Resume Next
    TextBox_EndTime.Text = StrConv(TextBox_EndTime.Text, vbNarrow)
    I¹ú = CDate(TextBox_EndDate.Text & " " & TextBox_EndTime.Text & ":00")
    On Error GoTo 0
    If I¹ú = 0 Then
        I¹ú = LastI¹ú
        TextBox_EndDate.BackColor = vbRed
        TextBox_EndTime.BackColor = vbRed
    Else
        LastI¹ú = I¹ú
        TextBox_EndDate.BackColor = vbWhite
        TextBox_EndTime.BackColor = vbWhite
    End If
End Property
Private Property Let I¹ú(dt As Date)
    TextBox_EndDate.Text = Format(dt, "yyyy/mm/dd")
End Property
Private Property Let I¹Ô(dt As Date)
    TextBox_EndTime.Text = Format(dt, "hh:mm")
End Property

Private Sub ToggleButton_ÅOÊ_Click()
    UserForm_TopMost Me, ToggleButton_ÅOÊ.Value
End Sub

Private Sub ToggleButton_Ýè\¦_Click(): UserForm_æÊTCYÝè: End Sub
Private Sub SpinButton_Zoom_Change(): Call UserForm_æÊTCYÝè: End Sub
Private Property Get æÊ{¦() As Double
    æÊ{¦ = SpinButton_Zoom.Value / SPIN_DEFAULT_VALUE
End Property
Private Sub UserForm_æÊTCYÝè()
    Me.Width = WIDTH_DEFAULT * æÊ{¦
    Me.Height = IIf(ToggleButton_Ýè\¦.Value, HEIGHT_MAX * æÊ{¦, HEIGHT_MIN * æÊ{¦)
    Me.Zoom = 100 * æÊ{¦
End Sub

Private Sub UserForm_Initialize()
    Me.Caption = "ïcð__±¯éÌð~ß³¹æ¤I"
    Label_bZ[W.Caption = ""

    CommandButton_Reset.Visible = False
    ToggleButton_ÅOÊ.Value = False
    ToggleButton_Ýè\¦.Value = True
    With ListBox1
        .ColumnCount = 3
        .ColumnWidths = "50;30;30"
    End With
    
    ListBox_AddItem ListBox1, Array("·", "6000", "0")
    ListBox_AddItem ListBox1, Array("Û·", "5000", "0")
    ListBox_AddItem ListBox1, Array("W·", "4000", "0")
    ListBox_AddItem ListBox1, Array("Ðõ", "3000", "0")
    
    SpinButton_MemberCount.Value = SPIN_DEFAULT_VALUE
    SpinButton_Zoom.Value = SPIN_DEFAULT_VALUE
    
    Jnú = Now()
    I¹ú = DateAdd("h", 1, Now())
    JnÔ = Now()
    I¹Ô = DateAdd("h", 1, Now())
    
#If DEF_EXCEL Then
    Excel.Application.Visible = False
#ElseIf DEF_WORD Then
    Word.Application.Visible = False
#End If
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
    IsClosing = True
#If DEF_EXCEL Then
    Excel.Application.Visible = True
#ElseIf DEF_WORD Then
    Word.Application.Visible = True
#End If
End Sub



object Form1: TForm1
  Left = 763
  Top = 443
  BorderStyle = bsToolWindow
  Caption = 'Form1'
  ClientHeight = 387
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object SpeedButton1: TSpeedButton
    Left = 72
    Top = 40
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton2: TSpeedButton
    Left = 160
    Top = 40
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton3: TSpeedButton
    Left = 248
    Top = 40
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton4: TSpeedButton
    Left = 72
    Top = 128
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton5: TSpeedButton
    Left = 160
    Top = 128
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton6: TSpeedButton
    Left = 248
    Top = 128
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton7: TSpeedButton
    Left = 72
    Top = 216
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton8: TSpeedButton
    Left = 160
    Top = 216
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object SpeedButton9: TSpeedButton
    Left = 248
    Top = 216
    Width = 50
    Height = 50
    OnClick = SpeedButton1Click
    OnMouseEnter = SpeedButton6MouseEnter
  end
  object Label1: TLabel
    Left = 32
    Top = 312
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object RadioButton1: TRadioButton
    Left = 344
    Top = 152
    Width = 113
    Height = 17
    Caption = 'Sente'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = RadioButton2Click
  end
  object RadioButton2: TRadioButton
    Left = 344
    Top = 200
    Width = 113
    Height = 17
    Caption = 'Gote'
    TabOrder = 1
    OnClick = RadioButton2Click
  end
end

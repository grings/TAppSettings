unit Main.View;

interface

uses
{$REGION '  Import: Winapi''s .. '}
  Winapi.Windows
, Winapi.Messages
{$ENDREGION}
{$REGION '  Import: System''s .. '}
, System.SysUtils
, System.Variants
, System.Classes
{$ENDREGION}
{$REGION '  Import: Vcl''s .. '}
, Vcl.Graphics
, Vcl.Controls
, Vcl.Forms
, Vcl.Dialogs
, Vcl.StdCtrls
, Vcl.ExtCtrls
{$ENDREGION}

  ;

type
  TMainView = class(TForm)
    Pnl_Status: TPanel;
    Lbl_Test: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  MainView: TMainView;

implementation

{$R *.dfm}

end.

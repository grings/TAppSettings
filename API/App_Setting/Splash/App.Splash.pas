unit App.Splash;

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
//, Vcl.Controls
, Vcl.Forms
, Vcl.Dialogs
, Vcl.ExtCtrls
, Vcl.StdCtrls
, Vcl.ComCtrls
{$ENDREGION}

, App.Settings.Interfaces
, Controls.Hack, Vcl.Controls
  ;

type

  TApp_Splash = class(TForm, I_Splash)
  {$REGION '  components .. '}
    Lbl_Log: TLabel;
    Pnl_Top: TPanel;
    Pnl_Bottom: TPanel;
    Pnl_Right: TPanel;
    Pnl_Left: TPanel;
    ProgressBar_Extract: TProgressBar;
    Lbl_Progress: TLabel;
    Timer_Ready: TTimer;
  {$ENDREGION}

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer_ReadyTimer(Sender: TObject);
  private
    [weak]
    fParent: I_AppSettings;
    { Private declarations }
  protected
    function Log_Ctrl: TControl;
    function Progress_Ctrl: TControl;
    function Progress_Bar: TProgressBar;
    function Show_Splash: I_Splash;
    function UpdateUI: I_Splash;
    function &End(aWithClose: Boolean = False): I_AppSettings;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; aParent: I_AppSettings = nil); reintroduce; overload;
    destructor Destroy; override;
    class function New(aOwner: TComponent; aParent: I_AppSettings): I_Splash;
  end;

//var
//  ViewSplash: TViewSplash;

implementation

{$R *.dfm}

var
  _Ready:Boolean = False;

{ TViewSplash }

{$REGION '  [constructor||destructor] .. '}
constructor TApp_Splash.Create(aOwner: TComponent; aParent: I_AppSettings = nil);
begin inherited Create(aOwner);

  fParent := nil;

  if Assigned(aParent) then
    fParent := aParent;
end;

class function TApp_Splash.New(aOwner: TComponent; aParent: I_AppSettings): I_Splash;
begin
  Result := Self.Create(aOwner, aParent);
end;

destructor TApp_Splash.Destroy;
begin
//
  inherited;
end;
{$ENDREGION}

procedure TApp_Splash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TApp_Splash.FormShow(Sender: TObject);
begin
  while not _Ready do
    Application.ProcessMessages;
end;

function TApp_Splash.Log_Ctrl: TControl;
begin
  Result := TControl(Lbl_Log);
end;

function TApp_Splash.Progress_Bar: TProgressBar;
begin
  Result := ProgressBar_Extract;
end;

function TApp_Splash.Progress_Ctrl: TControl;
begin
  Result := TControl(Lbl_Progress);
end;

function TApp_Splash.Show_Splash: I_Splash;
begin
  Result := Self;

  Self.Show;
end;

procedure TApp_Splash.Timer_ReadyTimer(Sender: TObject);
begin
  Timer_Ready.Enabled := False;
  _Ready := True;

end;

function TApp_Splash.UpdateUI: I_Splash;
begin
  Result := Self;

  UPdate;
end;

function TApp_Splash.&End(aWithClose: Boolean): I_AppSettings;
begin
  Result := fParent;

  if aWithClose then
    Close;
end;

end.

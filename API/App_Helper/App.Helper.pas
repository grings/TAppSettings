unit App.Helper;

interface

uses
  System.SysUtils // Use Of [Exception] ..
, VCL.Forms       // Use Of [TApplication] ..
//
, App.Settings.Interfaces
  ;

type
  TApp_CustomException = class
  private
    procedure Custom_Exception(aSender: TObject; aEx: Exception);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TApplicationHelper = class helper for TApplication
  private
    function Get_ApSettings: I_AppSettings;
  public
    property Settings: I_AppSettings read Get_ApSettings;
  end;

var
  MyApp: TApplication absolute Application;

implementation

uses
  System.UITypes // Use Of [TMsgDlgType||TMsgDlgBtn] ..
, VCL.Dialogs
//
, App.Settings
;

var
  Global_Custom_Exception: TApp_CustomException = nil;
//
  Global_AppSettings   : I_AppSettings;

{ TAppBehaviors }

{$REGION '  [APP Assign Custom Exception] .. '}
procedure TApp_CustomException.Custom_Exception(aSender: TObject; aEx: Exception);
begin
  MessageDlg(aEx.Message, System.UITypes.TMsgDlgType.mtError, [System.UITypes.TMsgDlgBtn.mbOK], 0);
end;

constructor TApp_CustomException.Create;
begin
  ReportMemoryLeaksOnShutdown := True;
  MyApp.OnException           := Custom_Exception;
end;

destructor TApp_CustomException.Destroy;
begin
  inherited;
end;
{$ENDREGION}

{ TApplicationHelper }

{$REGION '  [ APP Helpers ] .. '}
function TApplicationHelper.Get_ApSettings: I_AppSettings;
begin
  if not Assigned(Global_AppSettings) then
    Global_AppSettings := TAppSettings.New; //(Self);

  Result := Global_AppSettings;
end;
{$ENDREGION}

initialization
  Global_Custom_Exception := TApp_CustomException.Create;
  Global_AppSettings := nil;

finalization
  Global_Custom_Exception.Free;

end.

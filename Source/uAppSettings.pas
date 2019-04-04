unit uAppSettings;

interface

uses
  Classes, SysUtils, Graphics, Forms, PngImageList, BigIni, Variants;

type
  TSaveComponent = class(TComponent)
  private
    FFileName: string;
  public
    constructor Create(AFileName:string);
    destructor Destroy;
    procedure ReadFromFile;
    procedure SaveToFile;
  end;


  TAppSettings = class(TComponent)
  private
    FUserConfigFile: string;
    FApplicationName: string;
    FApplicationVersionNo: string;
    ConfigDat: string;
    FOfficeName: string;
    FOfficeAddress: string;
    FReadOnlyFieldColor: TColor;
    FIDHighGeneratorName: string;
    FIDHigh: Integer;
    FIDNextHigh: Integer;
    FIDLow: Integer;
    //todo: implement an index based 'last number'
    FLastNoInvoice: String;
    FLastNoCollection: string;
    FLastInvBatchNo: string;
    FLastNoSalesCredit: string;
    FServer: string;
    FDatabase: string;
    FPngImageList: TPngImageList;
    FCompanyName: string;
    FLastInvDateUsed: TDateTime;
    FVersionClient: Integer;
    FVersionSalesRep: Integer;
    FVersionTown: integer;
    FVersionCollector: integer;
    FGlobalTempPKID: Integer;

  private
    function GetDatabase: string;
    function GetGlobalTempPKID: Integer;
  public
    constructor Create;
    destructor Destroy;
    procedure SaveConfig;
    procedure ReadConfig;
  published
    //todo: create include file for project-specific properties
    property UserConfigFile: string read FUserConfigFile write FUserConfigFile;
    property ApplicationName: string read FApplicationName write FApplicationName;
    property ApplicationVersionNo: string read FApplicationVersionNo write FApplicationVersionNo;
    property OfficeName: string read FOfficeName write FOfficeName;
    property OfficeAddress: string read FOfficeAddress write FOfficeAddress;
    property ReadOnlyFieldColor: TColor read FReadOnlyFieldColor write FReadOnlyFieldColor;
    property IDHighGeneratorName: string read FIDHighGeneratorName write FIDHighGeneratorName;
    property IDHigh: Integer read FIDHigh write FIDHigh;
    property IDNextHigh: Integer read FIDNextHigh write FIDNextHigh;
    property IDLow: Integer read FIDLow write FIDLow;
    property LastNoInvoice: string read FLastNoInvoice write FLastNoInvoice;
    property LastNoCollection: string read FLastNoCollection write FLastNoCollection;
    property LastNoSalesCredit: string read FLastNoSalesCredit write FLastNoSalesCredit;
    property Server: string read FServer write FServer;
    property Database: string read GetDatabase write FDatabase;
    property PngImageList: TPngImageList read FPngImageList write FPngImageList;
    property CompanyName: string read fcompanyname write fcompanyname;
    property LastInvBatchNo: string read FLastInvBatchNo write FLastInvBatchNo;
    property LastInvDateUsed: TDateTime read FLastInvDateUsed write FLastInvDateUsed;
    property VersionClient: integer read FVersionClient write FVersionClient;
    property VersionSalesRep: Integer read FVersionSalesRep write FVersionSalesRep;
    property VersionTown: Integer read FVersionTown write FVersionTown;
    property VersionCollector: integer read FVersionCollector write FVersionCollector;
    property GlobalTempPKID: Integer read GetGlobalTempPKID write FGlobalTempPKID;
  end;

  function ComponentToString(Component: TComponent): string;



var
  AppSettings: TAppSettings;

const
  APP_NAME = 'Agribusiness Invoicing';
  APP_VERSION_NO  = '1.1';

implementation



{ TAppSetting }

constructor TAppSettings.Create;
begin
  ConfigDat := ExtractFilePath(ParamStr(0)) + 'config.cfg';
end;

destructor TAppSettings.Destroy;
begin
  AppSettings.PngImageList := nil;
  SaveConfig;
end;

function TAppSettings.GetDatabase: string;
var
  fn : string;
begin
  fn := FUserConfigFile;
  if FDatabase = '' then
  with TBiggerIniFile.Create(fn) do
  try
    FServer   := ReadString('data','server','localhost');
    FDatabase := ReadString('data','database',chr(0));
  finally
    Free;
  end;
  Result := FDatabase;
end;

function TAppSettings.GetGlobalTempPKID: Integer;
begin
  if FGlobalTempPKID > -1 then
    FGlobalTempPKID := Low(Integer)
  else
    Inc(FGlobalTempPKID);
  Result := FGlobalTempPKID;
end;

procedure TAppSettings.ReadConfig;
begin
  if fileexists(ConfigDat) then
  try
    Self := TAppSettings(ReadComponentResFile(ConfigDat, Self));
  except

  end;

  FReadOnlyFieldColor := clScrollBar;
  FIDHighGeneratorName := 'GEN_HIGHVALUE_ID';
  if FLastNoInvoice = '' then
    FLastNoInvoice := '0';
  if FCompanyName = '' then
    FCompanyName := 'Meljay Agribusiness Corporation';
  if LastInvDateUsed = 0 then FLastInvDateUsed := Date;

  FServer := '';
  FDatabase := '';
  FUserConfigFile := ChangeFileExt(ParamStr(0),'.ini') ;
  FApplicationName := APP_NAME;
  FApplicationVersionNo := APP_VERSION_NO;
  Name := 'AppSettings';

  Application.Title := AppSettings.FApplicationName +' - '+ AppSettings.FCompanyName

end;

procedure TAppSettings.SaveConfig;
begin
  WriteComponentResFile(ConfigDat,Self);
end;

{-----------------------------------------------------------------------------
  Algoritmo: ComponentToString
  Comentarios: From Delphi5 Help- WriteComponent,TStream
  Returns a string representation of a component (like in .dfm files)
-----------------------------------------------------------------------------}
function ComponentToString(Component: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;


{ TSaveComponent }

constructor TSaveComponent.Create(AFileName: string);
begin
  FFileName := AFileName;
  Self.ReadFromFile;
end;

destructor TSaveComponent.Destroy;
begin
  SaveToFile;
end;

procedure TSaveComponent.ReadFromFile;
begin
  if fileexists(FFileName) then
  try
    Self := TSaveComponent(ReadComponentResFile(FFileName, Self));
  except
  end;
end;

procedure TSaveComponent.SaveToFile;
begin
  WriteComponentResFile(FFileName,Self);
end;

initialization
  AppSettings := TAppSettings.Create;
  // delete the saved appsetting in the config.cfg to see changes
  AppSettings.ReadConfig;


finalization
  AppSettings.Destroy;


end.

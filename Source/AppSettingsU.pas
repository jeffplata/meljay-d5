unit AppSettingsU;

interface

uses
  Classes, SysUtils, Graphics, Forms, PngImageList, BigIni, Variants, SqlExpr,
  PngImage, DB;

type

  TLastValueItem = class(TCollectionItem)
  private
    FFullFieldName: string;
    FFieldName: string;
    FValue: Variant;
  published
    property FullFieldName: string read FFullFieldName write FFullFieldName;
    property FieldName: string read FFieldName write FFieldName;
    property Value: Variant read FValue write FValue;
  end;

  TLastValues = class(TCollection)
  private
    FOwner: TComponent;
    function GetItems(Index: Integer): TLastValueItem;
    procedure SetItems(Index: Integer; const Value: TLastValueItem);
  public
    constructor Create(const AOwner: TComponent);
    function AddItem(Fieldname, FullFieldName: string; Value: Variant):
        TLastValueItem;
    function GetOwner: TPersistent;
    function RestoreItem(FullFieldName: string = ''): Variant;
    procedure SaveItem(Fieldname: string; Dataset: TDataset; FullFieldName: string
        = '');
    property Items[Index: Integer]: TLastValueItem read GetItems write SetItems;
        default;
  published

  end;

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
    FDefCollectingOfficer: string;
    FCompanyName: string;
    FConnection: TSQLConnection;
    FOfficeName: string;
    FOfficeAddress: string;
    FReadOnlyFieldColor: TColor;
    FIDHighGeneratorName: string;
    FIDHigh: Integer;
    FIDNextHigh: Integer;
    FIDLow: Integer;
    FServer: string;
    FDatabase: string;
    FDataFolder: string;
    FDefCashInBankAccount: string;
    FDefCollectionAccount: string;
    FPngImageList: TPngImageList;
    FGlobalTempPKID: Integer;
    FLastCSVDataset: TDataSet;
    FLastCSVDatasetFields: string;
    FLastCSVFileName: string;
    FLastDBGridUsed: TComponent;
    //application-specific properties
    FLastNoLoan: string;
    FLastReportName: string;
    FLastTmpFileName: string;
    FLastValues: TLastValues;
    FLocalTempPKColItem: LongWord;
    FLowestTempID: LongWord;
    FOfficeAddress2: string;

    function GetCredentialsCached: Boolean;
    function GetDatabase: string;
    function GetServer: string;
    function GetDataFolder: string;
    function GetFullDataBaseName: string;
    function GetGlobalTempPKID: Integer;
    function GetPngImages(Index: Integer): TPngObject;
  public
    constructor Create;
    destructor Destroy;
    function GetReportName(const ReportName: string): string;
    procedure SaveConfig(AComponent: TComponent);
    procedure ReadConfig;
    property Connection: TSQLConnection read FConnection write FConnection;
    property CredentialsCached: Boolean read GetCredentialsCached;
    property DataFolder: string read GetDataFolder write FDataFolder;
    property FullDataBaseName: string read GetFullDataBaseName;
    property LastCSVDataset: TDataSet read FLastCSVDataset write FLastCSVDataset;
    property LastCSVDatasetFields: string read FLastCSVDatasetFields write
        FLastCSVDatasetFields;
    property LastDBGridUsed: TComponent read FLastDBGridUsed write FLastDBGridUsed;
    property LowestTempID: LongWord read FLowestTempID write FLowestTempID;
    property PngImages[Index: Integer]: TPngObject read GetPngImages;
  published
    //todo: create include file for project-specific properties
    property UserConfigFile: string read FUserConfigFile write FUserConfigFile;
    property ApplicationName: string read FApplicationName write FApplicationName;
    property ApplicationVersionNo: string read FApplicationVersionNo write FApplicationVersionNo;
    property CompanyName: string read fcompanyname write fcompanyname;
    property OfficeName: string read FOfficeName write FOfficeName;
    property OfficeAddress: string read FOfficeAddress write FOfficeAddress;
    property OfficeAddress2: string read FOfficeAddress2 write FOfficeAddress2;
    property ReadOnlyFieldColor: TColor read FReadOnlyFieldColor write FReadOnlyFieldColor;
    property IDHighGeneratorName: string read FIDHighGeneratorName write FIDHighGeneratorName;
    property IDHigh: Integer read FIDHigh write FIDHigh;
    property IDNextHigh: Integer read FIDNextHigh write FIDNextHigh;
    property IDLow: Integer read FIDLow write FIDLow;
    property Server: string read GetServer write FServer;
    property Database: string read GetDatabase write FDatabase;
    property PngImageList: TPngImageList read FPngImageList write FPngImageList;
    property GlobalTempPKID: Integer read GetGlobalTempPKID write FGlobalTempPKID;

    //application-specific properties
    property LastNoLoan: string read FLastNoLoan write FLastNoLoan;
    property LastCSVFileName: string read FLastCSVFileName write FLastCSVFileName;
    property LastTmpFileName: string read FLastTmpFileName write FLastTmpFileName;
    property LocalTempPKColItem: LongWord read FLocalTempPKColItem write
        FLocalTempPKColItem;
    property DefCollectionAccount: string read FDefCollectionAccount write
        FDefCollectionAccount;
    property DefCashInBankAccount: string read FDefCashInBankAccount write
        FDefCashInBankAccount;
    property DefCollectingOfficer: string read FDefCollectingOfficer write
        FDefCollectingOfficer;
    property LastReportName: string read FLastReportName write FLastReportName;
    property LastValues: TLastValues read FLastValues write FLastValues;

  end;

  function ComponentToString(Component: TComponent): string;



var
  AppSettings: TAppSettings;

const
  COMPANY_NAME = 'Meljay Agri-business';
  APP_NAME = 'Agri-business';
  APP_VERSION_NO  = '0.9.0';
  CSIDL_LOCAL_APPDATA        = $001C;  // non roaming,
                                       // user\Local Settings\Application Data
  CSIDL_PERSONAL             = $0005;  // My Documents

implementation

uses
  Misc;



{ TAppSetting }

constructor TAppSettings.Create;
begin
  FLastValues := TLastValues.Create(Self);
  ConfigDat := DataFolder +'config.cfg';  //todo: config file to name of application exe
  //ConfigDat := GetSpecialFolderPath(CSIDL_PERSONAL) + '\config.cfg'; //all_users/app_data
  //ConfigDat := ExtractFilePath(ParamStr(0)) + 'config.cfg';
end;

destructor TAppSettings.Destroy;
begin
  //AppSettings.PngImageList := nil;
  SaveConfig(Self);
  FLastValues.Free;
end;

function TAppSettings.GetCredentialsCached: Boolean;
begin
  Result := FileExists(FDataFolder+'seminar.jib') ;
end;

function TAppSettings.GetDatabase: string;
var
  fn : string;
begin
  fn := FUserConfigFile;
  if (FDatabase = '') then
  with TBiggerIniFile.Create(fn) do
  try
    FDatabase := ReadString('data','database',chr(0));
  finally
    Free;
  end;
  Result := FDatabase;
end;

function TAppSettings.GetServer: string;
var
  fn : string;
begin
  fn := FUserConfigFile;
  if (FServer = '') then
  with TBiggerIniFile.Create(fn) do
  try
    FServer   := ReadString('data','server','localhost');
  finally
    Free;
  end;
  Result := FServer;
end;

function TAppSettings.GetDataFolder: string;
begin
  FDataFolder := GetSpecialFolderPath(CSIDL_PERSONAL)+'\Agri-business\';
  Result := FDataFolder;
end;

function TAppSettings.GetFullDataBaseName: string;
begin
  Result := AppSettings.Server+':'+AppSettings.Database;
end;

function TAppSettings.GetGlobalTempPKID: Integer;
begin
  if FGlobalTempPKID > -1 then
    FGlobalTempPKID := Low(Integer)
  else
    Inc(FGlobalTempPKID);
  Result := FGlobalTempPKID;
end;

function TAppSettings.GetPngImages(Index: Integer): TPngObject;
begin
  Result := FPngImageList.PngImages[index].PngImage;
end;

function TAppSettings.GetReportName(const ReportName: string): string;
begin
  FLastReportName := ReportName;
  Result := ExtractFilePath(ParamStr(0))+'reports\'+ReportName+'.fr3';
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

  FServer := '';
  FDatabase := '';
  //FUserConfigFile := ChangeFileExt(ParamStr(0),'.ini') ;
  FUserConfigFile := DataFolder + ChangeFileExt(ExtractFileName(Application.ExeName),'.ini') ;
  FCompanyName := COMPANY_NAME;
  FApplicationName := APP_NAME;
  FApplicationVersionNo := APP_VERSION_NO;
  Name := 'AppSettings';
  FLowestTempID := 2147400000;

  Application.Title := AppSettings.FApplicationName +' - '+ AppSettings.FCompanyName ;

  if not fileexists(ConfigDat) then begin
    ForceDirectories(DataFolder);
    AppSettings.SaveConfig(Self);
  end;

end;

procedure TAppSettings.SaveConfig(AComponent: TComponent);
begin
//  WriteComponentResFile(ConfigDat,Self);
//  WriteComponentResFile(ConfigDat,AppSettings);
  WriteComponentResFile(ConfigDat, AComponent);
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

constructor TLastValues.Create(const AOwner: TComponent);
begin
  inherited Create(TLastValueItem);
  FOwner := AOwner;
end;

function TLastValues.AddItem(Fieldname, FullFieldName: string; Value: Variant):
    TLastValueItem;
var
  NewItem: TLastValueItem;
begin
  NewItem := TLastValueItem.Create(Self);
  NewItem.FieldName := Fieldname;
  if FullFieldName = '' then
    NewItem.FullFieldName := Fieldname
  else
    NewItem.FullFieldName := FullFieldName;
  NewItem.Value := Value;
  Result := NewItem;
end;

function TLastValues.GetItems(Index: Integer): TLastValueItem;
begin
  Result := TLastValueItem( inherited Items[Index] );
end;

function TLastValues.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TLastValues.RestoreItem(FullFieldName: string = ''): Variant;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Self.Count-1 do
  begin
    if SameText(Items[i].FullFieldName, FullFieldName) then begin
      Result := Items[i].Value;
      Break;
    end;
  end;
end;

procedure TLastValues.SaveItem(Fieldname: string; Dataset: TDataset;
    FullFieldName: string = '');
var
  FieldNameToSearch: string;
  i: Integer;
  matched: Boolean;
begin
  FieldNameToSearch := FullFieldName;
  if FieldNameToSearch = '' then
    FieldNameToSearch := Fieldname;
  matched := False;
  for i := 0 to Self.Count-1 do
  begin
    if SameText(Items[i].FullFieldName, FieldNameToSearch) then begin
      Items[i].Value := Dataset.fieldbyname(FieldName).Value;
      matched := True;
      Break;
    end;
  end;
  if not matched then
    AddItem(Fieldname,FullFieldName,
      Dataset.fieldbyname(Fieldname).Value);
end;

procedure TLastValues.SetItems(Index: Integer; const Value: TLastValueItem);
begin
  Items[Index] := Value;
end;

initialization
  AppSettings := TAppSettings.Create;
  // delete the saved appsetting in the config.cfg to see changes
  AppSettings.ReadConfig;


//finalization
//  AppSettings.Destroy;
//  AppSettings.SaveConfig;


end.



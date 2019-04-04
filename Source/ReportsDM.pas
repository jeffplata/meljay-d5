unit ReportsDM;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr, frxClass,
  frxDBSet, MainDM, Forms, frxExportXLS;

type
  TdmReports = class(TDataModule)
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    frxXLSExport1: TfrxXLSExport;
    procedure DataModuleCreate(Sender: TObject);
  private
    ActiveUsers: TDMUsers;
  public
    class procedure Open( DMUser: TDMUser );
    class procedure Close( DMUser: TDMUser );
  end;

var
  dmReports: TdmReports;

implementation



{$R *.dfm}

class procedure TdmReports.Close(DMUser: TDMUser);
begin
  if Assigned(dmReports) then
  with dmReports do
  begin
    if DMUser in ActiveUsers then
      ActiveUsers := ActiveUsers - [DMUser];
    if ActiveUsers = [] then
    begin
      FreeAndNil(dmReports);
    end;
  end;
end;

procedure TdmReports.DataModuleCreate(Sender: TObject);
begin
//  frxReport1.EngineOptions.UseGlobalDataSetList := false;

end;

class procedure TdmReports.Open(DMUser: TDMUser);
begin
  if not Assigned(dmReports) then
    dmReports := TdmReports.Create(Application);
  with dmReports do
    if not (DMUser in ActiveUsers) then
      ActiveUsers := ActiveUsers + [DMUser];
end;

end.

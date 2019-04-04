unit tableid_datamodule;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, kbmMemCSVStreamFormat, uib, uibdataset,
  Dialogs, kbmMemBinaryStreamFormat, DBClient, Provider, MidasLib;

type
  TdmTableID = class(TDataModule)
    UIBDataSet1: TUIBDataSet;
    TableIDmt: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    LocalFileName: string;
    procedure TableID_Open;
    procedure TableID_Close;
    procedure TableID_Init;
    procedure TableID_CheckOpen;
    function GetNewHighID( aTable: string ): Integer;
  public
    { Public declarations }
    function NextID(aTable: string): Integer;
    procedure CommitID(aTable: string);
    procedure RollbackID(aTable: string);
  end;

var
  dmTableID: TdmTableID;

const
  MAX_LOWID = 999999;

implementation

uses main_datamodule;


{$R *.dfm}

procedure TdmTableID.CommitID(aTable: string);
begin 
  TableID_CheckOpen;
  with TableIDmt do begin
    if Locate('TBL_NAME','_R_'+aTable,[]) then begin
      Delete;
    end {else
      raise Exception.Create('[Func CommitID] Invalid table name: '+aTable);
}  end;
end;

procedure TdmTableID.DataModuleCreate(Sender: TObject);
begin
  LocalFileName := 'TableID.mt';
  TableID_Init;
end;

procedure TdmTableID.DataModuleDestroy(Sender: TObject);
begin
  TableID_Close;
end;

function TdmTableID.GetNewHighID(aTable: string): Integer;
var
  nextHigh: Integer;
  canEditTable: Boolean;
begin
  TableID_CheckOpen;
  Result := -1;
  with UIBDataSet1 do begin
    SQL.Clear;
    SQL.Add('select * from HIGHGEN_GETNEWID('''+aTable+''')');
    Open;
    nextHigh := Fields[0].AsInteger;
    Close;
  end;
  if nextHigh > 0 then begin
    with TableIDmt do begin
      canEditTable := True;
      if aTable<>FieldByName('TBL_NAME').AsString then
        canEditTable := Locate('TBL_NAME',aTable,[]);
      if canEditTable then begin
        Edit;
        FieldByName('NEXT_HIGH_VALUE').AsInteger := nextHigh;
        Post;
      end;
    end;
    Result := nextHigh;
  end;
end;

function TdmTableID.NextID(aTable: string): Integer;
var
  aSourceRec: Variant;
  LastLowID, NewLowID, HighID, NextHighID : Integer;
begin
  TableID_CheckOpen;
  Result := -1;
  with TableIDmt do begin
    if Locate('TBL_NAME',aTable,[]) then begin
      try
        aSourceRec := TableIDmt['HIGH_VALUE;NEXT_HIGH_VALUE;LAST_LOW'];
        LastLowID :=  FieldByName('LAST_LOW').AsInteger;
        HighID :=     FieldByName('HIGH_VALUE').AsInteger;
        NextHighID := FieldByName('NEXT_HIGH_VALUE').AsInteger;
        if LastLowID >= MAX_LOWID then
          begin
            NewLowID := 1;
            //NextHighID = -1, unlikely here as it shld be resolved in init
            if NextHighID = -1 then
              NextHighID := GetNewHighID(aTable);
            HighID := NextHighID;
            NextHighID := -1;
          end
        else
          NewLowID := LastLowID +1;

        Result := HighID * (MAX_LOWID + 1) + NewLowID;

        if aTable<>FieldByName('TBL_NAME').AsString then
          Locate('TBL_NAME',aTable,[]);
        Edit;
        FieldByName('LAST_LOW').AsInteger :=        NewLowID;
        FieldByName('HIGH_VALUE').AsInteger :=      HighID;
        FieldByName('NEXT_HIGH_VALUE').AsInteger := NextHighID;
        Post;
        if not Locate('TBL_NAME','_R_'+aTable,[]) then
        //create a restorepoint
        begin
          Insert;
          TableIDmt['HIGH_VALUE;NEXT_HIGH_VALUE;LAST_LOW'] := aSourceRec;
          TableIDmt['TBL_NAME'] := '_R_'+aTable;
          Post;
        end;
      except
        Result := -1;
        raise;
      end;
    end else
      raise Exception.Create('[Func NextID] Invalid table name: '+aTable);
  end;
end;

procedure TdmTableID.RollbackID(aTable: string);
var
  aSourceRec: Variant;
begin
  TableID_CheckOpen;
  with TableIDmt do begin
    if Locate('TBL_NAME','_R_'+aTable,[]) then begin
      aSourceRec := TableIDmt['HIGH_VALUE;NEXT_HIGH_VALUE;LAST_LOW'];
      Delete;
      if Locate('TBL_NAME',aTable,[]) then begin
        Edit;
        TableIDmt['HIGH_VALUE;NEXT_HIGH_VALUE;LAST_LOW'] := aSourceRec;
        Post;
      end;
    end {else
      raise Exception.Create('[Func RollbackID] Invalid table name: '+aTable);
}  end;
end;

procedure TdmTableID.TableID_CheckOpen;
begin
  if not TableIDmt.Active then
    raise Exception.Create('Cannot perform operation. TableID is closed.');
end;

procedure TdmTableID.TableID_Close;
begin
  TableIDmt.SaveToFile(LocalFileName,dfXML);
  TableIDmt.Close;
end;

procedure TdmTableID.TableID_Init;
begin
  TableIDmt.Active := False;
  TableID_Open;
  with TableIDmt do
  begin
    //clear out uncommited transactions
    Filter := 'TBL_NAME LIKE ''_R_%''';
    Filtered := True;
    First;
    while not Eof do begin
      Delete;
      Next;
    end;

    // get new high values from db is required
    Filter := 'NEXT_HIGH_VALUE < 0';
    Filtered := True;
    First;
    while not Eof do begin
      GetNewHighID(FieldByName('TBL_NAME').AsString);
      Next;
    end;

    Filtered := False;
    First;
    TableIDmt.SaveToFile(LocalFileName,dfXML);
  end;
end;

{
//*********kbmmemtable code
procedure TdmTableID.TableID_Open;
begin
  if not TableIDmt.Active then
  begin
    if FileExists(LocalFileName) then
      TableIDmt.LoadFromFile(LocalFileName)
    else begin
      TableIDmt.CreateTable;
      with UIBDataSet1 do begin
        SQL.Clear;
        SQL.Add('select * from HIGHGEN_GETALL');
        Open;
      end;
      TableIDmt.LoadFromDataSet(TDataSet(uibdataset1),[]);
      uibdataset1.Close;
    end;
    TableIDmt.Open;
  end;
end;
}

//********clientdataset code
procedure TdmTableID.TableID_Open;
begin
  if not TableIDmt.Active then
  begin
    if FileExists(LocalFileName) then
      TableIDmt.LoadFromFile(LocalFileName)
    else begin
      with UIBDataSet1 do begin
        SQL.Clear;
        SQL.Add('select TBL_NAME, HIGH_VALUE, NEXT_HIGH_VALUE, 0 LAST_LOW '+
                'from HIGHGEN_GETALL');
      end;
      TableIDmt.Open;
    end;
  end;
end;

end.

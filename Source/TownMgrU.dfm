inherited fmTownMgr: TfmTownMgr
  Width = 375
  Caption = 'Towns/City Manager'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TBDock1: TTBDock
    Width = 367
  end
  inherited DBGrid1: TDBGrid
    Width = 367
    Columns = <
      item
        Expanded = False
        FieldName = 'TOWN_ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOWN'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROVINCE'
        Visible = True
      end>
  end
  inherited ActionList1: TActionList
    inherited AddAction: TAction
      OnExecute = AddActionExecute
    end
    inherited EditAction: TAction
      OnExecute = EditActionExecute
    end
    inherited DeleteAction: TAction
      OnExecute = DeleteActionExecute
    end
  end
end

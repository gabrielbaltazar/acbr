object DM: TDM
  Height = 480
  Width = 640
  object cdsPolling: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 24
    object cdsPollingeventID: TStringField
      FieldName = 'eventID'
      Size = 50
    end
    object cdsPollingeventType: TStringField
      FieldName = 'eventType'
      Size = 50
    end
    object cdsPollingorderID: TStringField
      FieldName = 'orderID'
      Size = 50
    end
    object cdsPollingorderURL: TStringField
      FieldName = 'orderURL'
      Size = 255
    end
    object cdsPollingcreatedAt: TDateTimeField
      FieldName = 'createdAt'
    end
    object cdsPollingsourceAppID: TStringField
      FieldName = 'sourceAppID'
      Size = 50
    end
  end
  object dtsPolling: TDataSource
    DataSet = cdsPolling
    Left = 56
    Top = 80
  end
  object cdsOrder: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 24
    object cdsOrderuniqueID: TStringField
      FieldName = 'uniqueID'
      Size = 50
    end
    object cdsOrderID: TStringField
      FieldName = 'ID'
      Size = 50
    end
    object cdsOrdertype: TStringField
      FieldName = 'type'
      Size = 50
    end
    object cdsOrderdisplayID: TStringField
      FieldName = 'displayID'
      Size = 50
    end
    object cdsOrdercreatedAt: TDateTimeField
      FieldName = 'createdAt'
    end
    object cdsOrderorderTiming: TStringField
      FieldName = 'orderTiming'
      Size = 50
    end
    object cdsOrdermerchantID: TStringField
      DisplayWidth = 100
      FieldName = 'merchantID'
      Size = 50
    end
    object cdsOrdermerchantName: TStringField
      FieldName = 'merchantName'
      Size = 50
    end
  end
  object dtsOrder: TDataSource
    DataSet = cdsOrder
    Left = 152
    Top = 80
  end
end

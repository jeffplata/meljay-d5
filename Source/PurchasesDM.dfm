�
 TDMPURCHASES 0�  TPF0TdmPurchasesdmPurchasesOldCreateOrderLeft� ToprHeight#Width� TSQLDataSetSQLDataSet1CommandText�SELECT TXN_ID, TXN_DATE, TXN_NUMBER
     , TXN_DUEDATE
     , TXN_DAYSDUE
     , TXN_AMOUNT
     , TXN_AMOUNTPAID
     , TXN_PARTICULARS
     , CLIENT_ID
     , AGENT_ID
     , TXN_TYPE_CID
FROM TXNMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left,Top  TDataSetProviderdspPurchasesDataSetSQLDataSet1Left,TopH  TClientDataSetcdsPurchases
Aggregates Params ProviderNamedspPurchasesLeft,Topx  TClientDataSetcdsPurchases_Edit
Aggregates Params ProviderNamedspPurchasesLeft,Top�    
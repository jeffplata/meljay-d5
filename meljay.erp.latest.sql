/********************* ROLES **********************/

/********************* UDFS ***********************/

/****************** GENERATORS ********************/

CREATE GENERATOR GEN_AGENT_ID;
CREATE GENERATOR GEN_CLIENT_GROUP_ID;
CREATE GENERATOR GEN_CLIENT_ID;
CREATE GENERATOR GEN_HIGHVALUE_ID;
CREATE GENERATOR GEN_PRODUCT_ID;
CREATE GENERATOR GEN_PRODUCT_TYPE_ID;
CREATE GENERATOR GEN_TXN_DETAIL_ID;
CREATE GENERATOR GEN_TXN_ID;
CREATE GENERATOR VER_CLIENT;
CREATE GENERATOR VER_COLLECTOR;
CREATE GENERATOR VER_SALESREP;
CREATE GENERATOR VER_TOWN;
/******************** DOMAINS *********************/

CREATE DOMAIN DM_CID
 AS varchar(6)
 COLLATE NONE;
CREATE DOMAIN DM_CID_PK
 AS varchar(6)
 NOT NULL
 COLLATE NONE;
CREATE DOMAIN DM_ID
 AS integer
;
CREATE DOMAIN DM_ID_PK
 AS integer
 NOT NULL
;
CREATE DOMAIN DM_MONEY
 AS numeric(15,2)
;
/******************* PROCEDURES ******************/

SET TERM ^ ;
CREATE PROCEDURE SEL_CLIENT
RETURNS (
    CLIENT_ID integer,
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN_ID integer,
    PHONE varchar(60),
    AGENT_ID integer,
    CLIENT_TYPE char(2),
    COMPLETEADDRESS varchar(121),
    TOWNPROVINCE varchar(81),
    CLIENTTYPEDESC varchar(40),
    AGENTNAME varchar(20) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_COLLECTION (
    P_START_DATE date,
    P_END_DATE date,
    P_CLIENT_ID integer,
    P_COLLECTOR_ID integer,
    P_COL_TYPE char(3),
    P_COL_NUMBER varchar(15),
    P_UNAPPLIEDONLY integer )
RETURNS (
    COL_ID integer,
    COL_NUMBER varchar(15),
    COL_DATE date,
    COL_TYPE char(3),
    COL_REF varchar(15),
    COL_AMOUNT numeric(15,2),
    COL_AMOUNTAPPLIED numeric(15,2),
    COL_DESCRIPTION varchar(50),
    CLIENT_ID integer,
    AGENT_ID integer,
    COLLECTOR_ID integer,
    PMT_REF varchar(15),
    PMT_TYPE varchar(15),
    CLIENTNAME varchar(40),
    COLLECTORNAME varchar(40),
    UNAPPLIEDAMOUNT numeric(15,0) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_INVOICE
RETURNS (
    TXN_ID integer,
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_PERIOD varchar(10),
    TXN_DAYSDUE smallint,
    TXN_DUEDATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    SALESCREDIT numeric(15,2),
    TXN_PARTICULARS varchar(255),
    TXN_TYPE_CID varchar(6),
    CLIENT_ID integer,
    AGENT_ID integer,
    TOWN_ID integer,
    CLIENTNAME varchar(40),
    AGENTNAME varchar(40),
    TOWNPROVINCE varchar(82) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_SALES_CREDIT (
    P_START_DATE date,
    P_END_DATE date,
    P_CLIENT_ID integer,
    P_SALES_CR_NUMBER varchar(15) )
RETURNS (
    SALES_CR_ID integer,
    SALES_CR_NUMBER varchar(15),
    SALES_CR_DATE date,
    SALES_CR_AMOUNT numeric(15,2),
    CLIENT_ID integer,
    CLIENTNAME varchar(40) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_SALES_CREDIT_LINES
RETURNS (
    SALES_CR_LINES_ID integer,
    SALES_CR_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTY numeric(18,2),
    SALES_DOC_NO varchar(15),
    COST_UNIT numeric(18,2),
    COST_TOTAL numeric(18,2),
    PRICE_UNIT numeric(18,2),
    PRICETOTAL numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_UNPAID_INVOICES
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    CLIENT_ID integer,
    TXN_TYPE_CID DM_CID,
    AGENT_ID integer )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    CLIENT_ID integer,
    TXN_TYPE_CID DM_CID,
    AGENT_ID integer )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_BALANCES (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer,
    A_PROVINCE varchar(40) )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    PAYMENTS numeric(15,2),
    BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_BALANCES_BYSR (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer,
    A_PROVINCE varchar(40) )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    PAYMENTS numeric(15,2),
    BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_CUS_STATEMENT (
    CLIENT_ID integer )
RETURNS (
    TXN_TYPE char(3),
    TXN_NUMBER varchar(10),
    TXN_DATE date,
    TXN_CHARGES numeric(18,2),
    TXN_PAYMENT numeric(18,2),
    TXN_RETURNS numeric(18,2),
    TXN_AFFIDAVIT numeric(18,2),
    TXN_DISCOUNT numeric(18,2),
    RUN_TOTAL numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_INV_OVERDUE (
    ASOFDATE date )
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_DUEDATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    CLIENT_ID integer,
    CLIENT_NAME varchar(40),
    DAYS_OVERDUE integer,
    BALANCE numeric(15,2),
    AGE integer )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PRODUCTION (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    TXN_BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD (
    PERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    AGENT_ID integer,
    SALES_REP_NAME varchar(40),
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PROD_SUMM_BYSR (
    APERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    AGENT_ID integer,
    SALES_REP_NAME varchar(40),
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PROD_SUMM_BYTEAM (
    APERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2),
    PERIOD varchar(10) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

/******************** TABLES **********************/

CREATE TABLE AGENT
(
  AGENT_ID integer NOT NULL,
  AGENT_NAME varchar(40) NOT NULL,
  ADDRESS varchar(90),
  PHONE_NUMBERS varchar(90),
  AREA varchar(40),
  CONSTRAINT INTEG_38 PRIMARY KEY (AGENT_ID),
  CONSTRAINT UNQ_AGENT_1 UNIQUE (AGENT_NAME)
);
CREATE TABLE CLIENT
(
  CLIENT_ID integer NOT NULL,
  CLIENT_NAME varchar(40) NOT NULL,
  STREET_ADDRESS varchar(40),
  ADDRESS varchar(40),
  TOWN_ID integer,
  PHONE varchar(60),
  AGENT_ID integer,
  CLIENT_TYPE char(2) NOT NULL,
  CONSTRAINT PK_CLIENT PRIMARY KEY (CLIENT_ID)
);
CREATE TABLE CLIENT_GROUP
(
  CLIENT_GROUP_ID integer NOT NULL,
  GROUP_NAME varchar(30) NOT NULL,
  CONSTRAINT PK_CLIENT_GROUP PRIMARY KEY (CLIENT_GROUP_ID),
  CONSTRAINT UNQ1_CLIENT_GROUP UNIQUE (GROUP_NAME)
);
CREATE TABLE COLLECTION
(
  COL_ID DM_ID NOT NULL,
  COL_NUMBER varchar(15) NOT NULL,
  COL_DATE date NOT NULL,
  COL_TYPE char(3) NOT NULL,
  COL_REF varchar(15),
  COL_AMOUNT numeric(15,2) DEFAULT 0 NOT NULL,
  COL_AMOUNTAPPLIED DM_MONEY DEFAULT 0 NOT NULL,
  COL_DESCRIPTION varchar(50),
  CLIENT_ID DM_ID NOT NULL,
  AGENT_ID DM_ID NOT NULL,
  PMT_REF varchar(15),
  PMT_TYPE varchar(15),
  COLLECTOR_ID integer NOT NULL,
  CONSTRAINT PK_COLLECTION_0 PRIMARY KEY (COL_ID)
);
CREATE TABLE COLLECTION_DETAIL
(
  COL_DETAIL_ID DM_ID_PK,
  COL_ID DM_ID NOT NULL,
  TXN_NUMBER varchar(15) NOT NULL,
  TXN_DATE date,
  COL_DETAIL_AMTPAID DM_MONEY,
  AFFIDAVIT_AMT numeric(15,2),
  DISCOUNT numeric(15,2),
  CONSTRAINT PK_COLLECTION_DETAIL_0 PRIMARY KEY (COL_DETAIL_ID)
);
CREATE GLOBAL TEMPORARY TABLE COLLECTION_MD_GTT
(
  MASTER_ID integer NOT NULL,
  CLIENT_ADDRESS varchar(15) NOT NULL
)
ON COMMIT PRESERVE ROWS;
CREATE TABLE PRODUCT
(
  PRODUCT_ID integer NOT NULL,
  PRODUCT_NAME varchar(40) NOT NULL,
  PRODUCT_TYPE_ID integer DEFAULT 0 NOT NULL,
  PRICE numeric(15,2),
  CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_ID),
  CONSTRAINT UNQ_PRODUCT_0 UNIQUE (PRODUCT_NAME)
);
CREATE TABLE PRODUCT_TYPE
(
  PRODUCT_TYPE_ID integer NOT NULL,
  TYPE_NAME varchar(40) NOT NULL,
  CONSTRAINT PK_PRODUCT_TYPE PRIMARY KEY (PRODUCT_TYPE_ID),
  CONSTRAINT UNQ1_PRODUCT_TYPE UNIQUE (TYPE_NAME)
);
CREATE TABLE SALES_CREDIT
(
  SALES_CR_ID integer NOT NULL,
  SALES_CR_NUMBER varchar(15),
  SALES_CR_DATE date,
  SALES_CR_AMOUNT numeric(15,2),
  CLIENT_ID integer NOT NULL,
  CONSTRAINT PK_SALES_CREDIT_0 PRIMARY KEY (SALES_CR_ID)
);
CREATE TABLE SALES_CREDIT_LINES
(
  SALES_CR_LINES_ID integer NOT NULL,
  SALES_CR_ID integer NOT NULL,
  PRODUCT_ID integer NOT NULL,
  QTY numeric(18,2),
  SALES_DOC_NO varchar(15),
  COST_UNIT numeric(18,2),
  COST_TOTAL numeric(18,2),
  PRICE_UNIT numeric(18,2),
  PRICE_TOTAL numeric(18,2),
  CONSTRAINT PK_SALES_CREDIT_LINES_0 PRIMARY KEY (SALES_CR_LINES_ID)
);
CREATE GLOBAL TEMPORARY TABLE SALES_CREDIT_MD_GTT
(
  MASTER_ID integer NOT NULL,
  CLIENT_ADDRESS varchar(15) NOT NULL
)
ON COMMIT PRESERVE ROWS;
CREATE TABLE TOWN
(
  TOWN_ID integer NOT NULL,
  TOWN varchar(40),
  PROVINCE varchar(40),
  CONSTRAINT PK_TOWN_0 PRIMARY KEY (TOWN_ID),
  CONSTRAINT UNQ_TOWN_LOCATION UNIQUE (TOWN,PROVINCE)
);
CREATE TABLE TXN
(
  TXN_ID integer NOT NULL,
  TXN_NUMBER varchar(15) NOT NULL,
  TXN_DATE date DEFAULT 'NOW' NOT NULL,
  TXN_PERIOD varchar(10) NOT NULL,
  TXN_DAYSDUE smallint,
  TXN_DUEDATE date,
  TXN_AMOUNT numeric(15,2) NOT NULL,
  TXN_DOWNPAYMENT numeric(15,2) NOT NULL,
  TXN_AMOUNTPAID numeric(15,2) NOT NULL,
  TXN_PARTICULARS varchar(255),
  TXN_TYPE_CID varchar(6) NOT NULL,
  CLIENT_ID integer NOT NULL,
  AGENT_ID integer NOT NULL,
  TOWN_ID integer,
  LASTCHANGED timestamp,
  CONSTRAINT PK_TXN PRIMARY KEY (TXN_ID),
  CONSTRAINT UNQ_TXN_TXN_NUMBER UNIQUE (TXN_NUMBER)
);
CREATE TABLE TXN_DETAIL
(
  TXN_DETAIL_ID integer NOT NULL,
  TXN_ID integer NOT NULL,
  PRODUCT_ID integer NOT NULL,
  QTYIN numeric(18,2),
  QTYOUT numeric(18,2),
  COST_UNIT numeric(18,2),
  COST_TOTAL numeric(18,2),
  PRICE_UNIT numeric(18,2),
  PRICE_TOTAL numeric(18,2),
  CONSTRAINT PK_TXN_DETAIL PRIMARY KEY (TXN_DETAIL_ID)
);
CREATE TABLE TXN_TYPE
(
  TXN_TYPE_CID varchar(6) NOT NULL,
  TYPE_NAME varchar(20) NOT NULL,
  DIRECTION smallint DEFAULT 0 NOT NULL,
  CONSTRAINT PK_TXN_TYPE PRIMARY KEY (TXN_TYPE_CID)
);
/********************* VIEWS **********************/

CREATE VIEW VW_PAYMENTS (TXN_NUMBER, TXN_AMOUNT, CASH, AFFIDAVIT, DISCOUNT, SALES_RET)
AS    
SELECT I.TXN_NUMBER, I.TXN_AMOUNT, I.TXN_DOWNPAYMENT+C.CASH CASH, C.AFFIDAVIT, C.DISCOUNT, R.SALES_RET
FROM TXN I
JOIN (select TXN_NUMBER, 
             sum(CASE WHEN COL_TYPE='CAS' THEN COL_DETAIL_AMTPAID ELSE 0 END) CASH,
             sum(CASE WHEN COL_TYPE='AFF' THEN COL_DETAIL_AMTPAID ELSE 0 END) AFFIDAVIT,
             sum(CASE WHEN COL_TYPE='DIS' THEN COL_DETAIL_AMTPAID ELSE 0 END) DISCOUNT
        from (select TXN_NUMBER, COL_TYPE, COL_DETAIL_AMTPAID 
              from COLLECTION_DETAIL D1
              join COLLECTION P1 ON P1.COL_ID=D1.COL_ID
              union all select TXN_NUMBER, '   ', 0 from TXN
              
            ) group by TXN_NUMBER
     ) C on C.TXN_NUMBER=I.TXN_NUMBER
JOIN (select TXN_NUMBER, sum(PRICE_TOTAL) SALES_RET
        from (select SALES_DOC_NO TXN_NUMBER, PRICE_UNIT * QTY AS PRICE_TOTAL
                from SALES_CREDIT_LINES RET2
                join SALES_CREDIT RET1 on RET1.SALES_CR_ID=RET2.SALES_CR_ID
                union all select TXN_NUMBER, 0 from TXN
                
             ) group by TXN_NUMBER
     ) R on R.TXN_NUMBER=I.TXN_NUMBER

;
CREATE VIEW VW_PRODUCTION (TXN_PERIOD, TXN_ID, TXN_DATE, TXN_NUMBER, TXN_AMOUNT, TXN_DOWNPAYMENT, TXN_BALANCE, CLIENT_NAME, STREET_ADDRESS, ADDRESS, TOWN, PROVINCE, SALES_REP, TXN_DETAIL_ID, PRODUCT_ID, PRODUCTNAME, QTYOUT)
AS  
select 
      i.TXN_PERIOD
    , i.TXN_ID
    , i.TXN_DATE
    , i.TXN_NUMBER
    , i.TXN_AMOUNT
    , i.TXN_DOWNPAYMENT
    , (i.TXN_AMOUNT-i.TXN_DOWNPAYMENT-i.TXN_AMOUNTPAID) TXN_BALANCE
    , c.CLIENT_NAME 
    , c.STREET_ADDRESS
    , c.ADDRESS
    , t.TOWN
    , t.PROVINCE
    , a.CLIENT_NAME SALES_REP
    , d.TXN_DETAIL_ID
    , PRODUCT_ID
    , (select p.PRODUCT_NAME from PRODUCT p
       where p.PRODUCT_ID = d.PRODUCT_ID) PRODUCTNAME
    , d.QTYOUT
           
    from TXN_DETAIL d
    join TXN i on (i.TXN_ID=d.TXN_ID)
    join TOWN t on (t.TOWN_ID=i.TOWN_ID)
    /*
    join (select cc.CLIENT_ID, cc.CLIENT_NAME, cc.STREET_ADDRESS, cc.ADDRESS, ca.CLIENT_NAME as SALES_REP
            from CLIENT cc
            join CLIENT ca on ca.CLIENT_ID=cc.AGENT_ID
            */
    join CLIENT a on a.CLIENT_ID=i.AGENT_ID
    join (select cc.CLIENT_ID, cc.CLIENT_NAME, cc.STREET_ADDRESS, cc.ADDRESS
            from CLIENT cc
         ) c on c.CLIENT_ID=i.CLIENT_ID

;
/******************* EXCEPTIONS *******************/

CREATE EXCEPTION NO_DELETE_DATA_IN_USE
'Can''t delete; data in use.';
CREATE EXCEPTION NO_DELETE_SYSTEM_DATA
'Cannot change or delete system data.';
/******************** TRIGGERS ********************/

SET TERM ^ ;
CREATE TRIGGER AGENT_BI FOR AGENT ACTIVE
BEFORE insert POSITION 0
AS
BEGIN
  IF ((NEW.AGENT_ID IS NULL) OR (NEW.AGENT_ID < 0)) THEN
    NEW.AGENT_ID = GEN_ID(GEN_AGENT_ID,1);
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER AGENT_BUD0 FOR AGENT ACTIVE
BEFORE update OR delete POSITION 0
AS 
BEGIN 
  if (OLD.AGENT_ID = 0) then
    exception no_delete_system_data; 
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER CLIENT_BD_SALESREP FOR CLIENT ACTIVE
BEFORE delete POSITION 0
AS
BEGIN
  if (old.CLIENT_TYPE = 'SR') then
    if (exists (select 1 from client a
        where a.AGENT_ID = old.CLIENT_ID)) then
      exception no_delete_data_in_use;
      
  if (old.CLIENT_TYPE = 'CO') then
    if (exists (select 1 from COLLECTION c
        where c.COLLECTOR_ID = old.CLIENT_ID)) then
      exception no_delete_data_in_use;
    
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER CLIENT_BI FOR CLIENT ACTIVE
BEFORE insert POSITION 0
as
begin
  if ((new.client_id is null) or (new.client_id < 0))  then
    new.client_id = gen_id(gen_client_id,1);
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER CLIENT_BIUD FOR CLIENT ACTIVE
BEFORE insert OR update OR delete POSITION 0
AS
declare x integer;
BEGIN
  if (inserting) then
  begin
    if (new.CLIENT_TYPE='SR') then x = gen_id(VER_SALESREP,1);
    if (new.CLIENT_TYPE='CO') then x = gen_id(VER_COLLECTOR,1);
    else x = gen_id(VER_CLIENT,1);
  end
  else if (updating) then
  begin
    if ((new.CLIENT_TYPE='SR') or (old.CLIENT_TYPE='SR')) then
      x = gen_id(VER_SALESREP,1);
    if ((new.CLIENT_TYPE='CU') or (old.CLIENT_TYPE='CU')) then
      x = gen_id(VER_CLIENT,1);
    if ((new.CLIENT_TYPE='DI') or (old.CLIENT_TYPE='DI')) then
      x = gen_id(VER_CLIENT,1);
    if ((new.CLIENT_TYPE='CO') or (old.CLIENT_TYPE='CO')) then
      x = gen_id(VER_COLLECTOR,1);
  end
  if (deleting) then
  begin
    if (old.CLIENT_TYPE='SR') then x = gen_id(VER_SALESREP,1);
    if (old.CLIENT_TYPE='CO') then x = gen_id(VER_COLLECTOR,1);
    else x = gen_id(VER_CLIENT,1);
  end
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER CLIENT_GROUP_BI FOR CLIENT_GROUP ACTIVE
BEFORE insert POSITION 0
as
begin
  if ((new.client_group_id is null) or (NEW.CLIENT_GROUP_ID < 0))  then
    new.client_group_id = gen_id(gen_client_group_id,1);
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER CLIENT_GROUP_BUD0 FOR CLIENT_GROUP ACTIVE
BEFORE update OR delete POSITION 0
AS
begin
  if (OLD.client_group_id = 0) then
    exception no_delete_system_data;
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER COLLECTION_DETAIL_BID FOR COLLECTION_DETAIL ACTIVE
BEFORE insert OR delete POSITION 0
AS
BEGIN
  if (inserting) then
    update TXN 
    set TXN_AMOUNTPAID=TXN_AMOUNTPAID+new.COL_DETAIL_AMTPAID
    where TXN_NUMBER = new.TXN_NUMBER;
  else if (deleting) then
    update TXN 
    set TXN_AMOUNTPAID=TXN_AMOUNTPAID-old.COL_DETAIL_AMTPAID
    where TXN_NUMBER = old.TXN_NUMBER;  
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER PRODUCT_BI FOR PRODUCT ACTIVE
BEFORE insert POSITION 0
as
begin
  if ((new.product_id is null) or (NEW.product_id < 0))  then
    new.product_id = gen_id(gen_product_id,1);
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER PRODUCT_TYPE_BI FOR PRODUCT_TYPE ACTIVE
BEFORE insert POSITION 0
AS
BEGIN
  IF ((NEW.PRODUCT_TYPE_ID IS NULL) or (new.PRODUCT_TYPE_ID < 0)) THEN
    NEW.PRODUCT_TYPE_ID = GEN_ID(GEN_PRODUCT_TYPE_ID,1);
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER PRODUCT_TYPE_BUD0 FOR PRODUCT_TYPE ACTIVE
BEFORE update OR delete POSITION 0
AS
begin
  if (old.PRODUCT_TYPE_ID = 0) then
    exception no_delete_system_data;
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER TOWN_BIUD FOR TOWN ACTIVE
BEFORE insert OR update OR delete POSITION 0
AS
declare x integer;
BEGIN
      x = gen_id(VER_TOWN,1);
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER TXN_BI FOR TXN ACTIVE
BEFORE insert POSITION 0
as
begin
  if ((new.TXN_id is null) or (NEW.TXN_id < 0))  then
    new.TXN_id = gen_id(gen_txn_id,1);
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER TXN_BIU FOR TXN ACTIVE
BEFORE insert OR update POSITION 0
AS
BEGIN
  NEW.LASTCHANGED = 'NOW';
END^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER TXN_DETAIL_BI FOR TXN_DETAIL ACTIVE
BEFORE insert POSITION 0
as
begin
  if ((new.txn_detail_id is null) or (NEW.txn_detail_id <0))  then
    new.txn_detail_id = gen_id(gen_txn_detail_id,1);
end^
SET TERM ; ^
SET TERM ^ ;
CREATE TRIGGER TXN_DETAIL_BIUD FOR TXN_DETAIL ACTIVE
BEFORE insert OR update OR delete POSITION 0
AS
declare variable ATXN_ID integer;
BEGIN
  if (deleting) then atxn_id = old.TXN_ID;
  else atxn_id = new.TXN_ID;
  UPDATE TXN
     SET LASTCHANGED = 'NOW'
   WHERE TXN_ID = :ATXN_ID;
END

^
SET TERM ; ^

SET TERM ^ ;
ALTER PROCEDURE SEL_CLIENT
RETURNS (
    CLIENT_ID integer,
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN_ID integer,
    PHONE varchar(60),
    AGENT_ID integer,
    CLIENT_TYPE char(2),
    COMPLETEADDRESS varchar(121),
    TOWNPROVINCE varchar(81),
    CLIENTTYPEDESC varchar(40),
    AGENTNAME varchar(20) )
AS
BEGIN
    FOR SELECT 
        a.CLIENT_ID, 
        a.CLIENT_NAME, 
        a.STREET_ADDRESS, 
        a.ADDRESS, 
        a.TOWN_ID, 
        a.PHONE, 
        a.AGENT_ID, 
        a.CLIENT_TYPE,
        (select town_province from TOWN t
         where t.TOWN_ID=a.TOWN_ID) townprovince,
        case a.client_type
          when 'CU' then 'Customer'
          when 'SR' then 'Sales Rep'
          when 'DI' then 'Distributor'
          when 'CO' then 'Collector'
          else '<Unknown>'
        end clienttypedesc,
        (select CLIENT_NAME from CLIENT ag
         where ag.CLIENT_ID=a.AGENT_ID) AGENTNAME
    FROM CLIENT a
        
    INTO 
        CLIENT_ID, 
        CLIENT_NAME, 
        STREET_ADDRESS, 
        ADDRESS, 
        TOWN_ID, 
        PHONE, 
        AGENT_ID, 
        CLIENT_TYPE,
        townprovince,
        clienttypedesc,
        agentname 
    DO
    BEGIN
        COMPLETEADDRESS = coalesce(STREET_ADDRESS||' ','')||
          coalesce(ADDRESS||' ','')||coalesce(townprovince,'');
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SEL_COLLECTION (
    P_START_DATE date,
    P_END_DATE date,
    P_CLIENT_ID integer,
    P_COLLECTOR_ID integer,
    P_COL_TYPE char(3),
    P_COL_NUMBER varchar(15),
    P_UNAPPLIEDONLY integer )
RETURNS (
    COL_ID integer,
    COL_NUMBER varchar(15),
    COL_DATE date,
    COL_TYPE char(3),
    COL_REF varchar(15),
    COL_AMOUNT numeric(15,2),
    COL_AMOUNTAPPLIED numeric(15,2),
    COL_DESCRIPTION varchar(50),
    CLIENT_ID integer,
    AGENT_ID integer,
    COLLECTOR_ID integer,
    PMT_REF varchar(15),
    PMT_TYPE varchar(15),
    CLIENTNAME varchar(40),
    COLLECTORNAME varchar(40),
    UNAPPLIEDAMOUNT numeric(15,0) )
AS
declare client_address varchar(15);
BEGIN
    client_address = rdb$get_context('SYSTEM','CLIENT_ADDRESS');
    delete from COLLECTION_MD_GTT 
     where client_address = :client_address;       

    FOR SELECT 
        a.COL_ID, 
        a.COL_NUMBER, 
        a.COL_DATE, 
        a.COL_TYPE, 
        a.COL_REF, 
        a.COL_AMOUNT, 
        a.COL_AMOUNTAPPLIED, 
        a.COL_DESCRIPTION, 
        a.CLIENT_ID, 
        a.AGENT_ID,
        a.COLLECTOR_ID, 
        a.PMT_REF, 
        a.PMT_TYPE,
        (select CLIENT_NAME from CLIENT c
         where c.CLIENT_ID = a.CLIENT_ID) CLIENTNAME,
        (select CLIENT_NAME from CLIENT c
         where c.CLIENT_ID = a.COLLECTOR_ID) COLLECTORNAME
    FROM COLLECTION a
    
    where (:p_start_date is null 
           or a.COL_DATE between :p_start_date and :p_end_date
          ) and
          (:p_client_id is null
           or a.CLIENT_ID = :p_client_id
          ) and 
          (:p_collector_id is null
           or a.COLLECTOR_ID = :p_collector_id
          ) and 
          (:p_col_type is null 
           or a.COL_TYPE = :p_col_type
          ) and
          (:p_col_number is null
           or a.COL_NUMBER containing :p_col_number
          ) and 
          (:p_unappliedonly is null
           or (COL_AMOUNT-COL_AMOUNTAPPLIED > 0)
          ) 
    order by CLIENTNAME      
    INTO 
        COL_ID, 
        COL_NUMBER, 
        COL_DATE, 
        COL_TYPE, 
        COL_REF, 
        COL_AMOUNT, 
        COL_AMOUNTAPPLIED, 
        COL_DESCRIPTION, 
        CLIENT_ID, 
        AGENT_ID, 
        COLLECTOR_ID,
        PMT_REF, 
        PMT_TYPE,
        CLIENTNAME,
        COLLECTORNAME 
    DO
    BEGIN
        UnappliedAmount = COL_AMOUNT - COL_AMOUNTAPPLIED;
        insert into COLLECTION_MD_GTT 
          values(:COL_ID,:client_address);
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SEL_INVOICE
RETURNS (
    TXN_ID integer,
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_PERIOD varchar(10),
    TXN_DAYSDUE smallint,
    TXN_DUEDATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    SALESCREDIT numeric(15,2),
    TXN_PARTICULARS varchar(255),
    TXN_TYPE_CID varchar(6),
    CLIENT_ID integer,
    AGENT_ID integer,
    TOWN_ID integer,
    CLIENTNAME varchar(40),
    AGENTNAME varchar(40),
    TOWNPROVINCE varchar(82) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SEL_SALES_CREDIT (
    P_START_DATE date,
    P_END_DATE date,
    P_CLIENT_ID integer,
    P_SALES_CR_NUMBER varchar(15) )
RETURNS (
    SALES_CR_ID integer,
    SALES_CR_NUMBER varchar(15),
    SALES_CR_DATE date,
    SALES_CR_AMOUNT numeric(15,2),
    CLIENT_ID integer,
    CLIENTNAME varchar(40) )
AS
declare client_address varchar(15);
BEGIN
    client_address = rdb$get_context('SYSTEM','CLIENT_ADDRESS');
    delete from SALES_CREDIT_MD_GTT 
     where client_address = :client_address;
     
    FOR SELECT 
        a.SALES_CR_ID, 
        a.SALES_CR_NUMBER, 
        a.SALES_CR_DATE, 
        a.SALES_CR_AMOUNT, 
        a.CLIENT_ID,
        c.CLIENT_NAME
    FROM SALES_CREDIT a
    join CLIENT c on c.CLIENT_ID=a.CLIENT_ID
    
    where (:p_start_date is null 
           or a.SALES_CR_DATE between :p_start_date and :p_end_date
          ) and
          (:p_client_id is null
           or a.CLIENT_ID = :p_client_id
          ) and 
          (:P_SALES_CR_NUMBER is null
           or a.SALES_CR_NUMBER containing :P_SALES_CR_NUMBER
          )    
    INTO 
        SALES_CR_ID, 
        SALES_CR_NUMBER, 
        SALES_CR_DATE, 
        SALES_CR_AMOUNT, 
        CLIENT_ID,
        CLIENTNAME 
    DO
    BEGIN
        insert into SALES_CREDIT_MD_GTT 
          values(:SALES_CR_ID,:client_address);
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SEL_SALES_CREDIT_LINES
RETURNS (
    SALES_CR_LINES_ID integer,
    SALES_CR_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTY numeric(18,2),
    SALES_DOC_NO varchar(15),
    COST_UNIT numeric(18,2),
    COST_TOTAL numeric(18,2),
    PRICE_UNIT numeric(18,2),
    PRICETOTAL numeric(18,2) )
AS
BEGIN
    FOR SELECT 
        a.SALES_CR_LINES_ID, 
        a.SALES_CR_ID, 
        a.PRODUCT_ID,
        p.PRODUCT_NAME, 
        a.QTY, 
        a.SALES_DOC_NO, 
        a.COST_UNIT, 
        a.COST_TOTAL, 
        a.PRICE_UNIT, 
        a.QTY * a.PRICE_UNIT
    FROM SALES_CREDIT_LINES a
    join PRODUCT p on p.PRODUCT_ID = a.PRODUCT_ID
    join SALES_CREDIT_MD_GTT scg 
      on scg.MASTER_ID = a.SALES_CR_ID
        and scg.CLIENT_ADDRESS = rdb$get_context('SYSTEM','CLIENT_ADDRESS')
    INTO 
        SALES_CR_LINES_ID, 
        SALES_CR_ID, 
        PRODUCT_ID, 
        PRODUCTNAME,
        QTY, 
        SALES_DOC_NO, 
        COST_UNIT, 
        COST_TOTAL, 
        PRICE_UNIT, 
        PRICETOTAL 
    DO
    BEGIN
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SEL_UNPAID_INVOICES
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    CLIENT_ID integer,
    TXN_TYPE_CID DM_CID,
    AGENT_ID integer )
AS
BEGIN
    FOR SELECT 
        a.TXN_NUMBER, 
        a.TXN_DATE,  
        a.TXN_AMOUNT, 
        a.TXN_AMOUNTPAID, 
        a.TXN_DOWNPAYMENT,
        a.CLIENT_ID,
        a.TXN_TYPE_CID,
        a.AGENT_ID
    FROM TXN a
    where txn_type_cid = 'INV' and
       (((txn_amount - txn_amountpaid - txn_downpayment) > 0) 
       and (txn_amount <> 0))
     order by txn_date, txn_number
    INTO 
        TXN_NUMBER, 
        TXN_DATE, 
        TXN_AMOUNT, 
        TXN_AMOUNTPAID, 
        TXN_DOWNPAYMENT,
        CLIENT_ID,
        TXN_TYPE_CID,
        AGENT_ID 
    DO
    BEGIN
        TXN_AMOUNTPAID = TXN_AMOUNTPAID+TXN_DOWNPAYMENT;
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    CLIENT_ID integer,
    TXN_TYPE_CID DM_CID,
    AGENT_ID integer )
AS
BEGIN
    FOR SELECT 
        a.TXN_NUMBER, 
        a.TXN_DATE,  
        a.TXN_AMOUNT, 
        a.TXN_AMOUNTPAID, 
        a.TXN_DOWNPAYMENT,
        a.CLIENT_ID,
        a.TXN_TYPE_CID,
        a.AGENT_ID
    FROM TXN a
    INTO 
        TXN_NUMBER, 
        TXN_DATE, 
        TXN_AMOUNT, 
        TXN_AMOUNTPAID, 
        TXN_DOWNPAYMENT,
        CLIENT_ID,
        TXN_TYPE_CID,
        AGENT_ID 
    DO
    BEGIN
        TXN_AMOUNTPAID = TXN_AMOUNTPAID+TXN_DOWNPAYMENT;
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_BALANCES (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer,
    A_PROVINCE varchar(40) )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    PAYMENTS numeric(15,2),
    BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_BALANCES_BYSR (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer,
    A_PROVINCE varchar(40) )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    PAYMENTS numeric(15,2),
    BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
BEGIN SUSPEND; END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_CUS_STATEMENT (
    CLIENT_ID integer )
RETURNS (
    TXN_TYPE char(3),
    TXN_NUMBER varchar(10),
    TXN_DATE date,
    TXN_CHARGES numeric(18,2),
    TXN_PAYMENT numeric(18,2),
    TXN_RETURNS numeric(18,2),
    TXN_AFFIDAVIT numeric(18,2),
    TXN_DISCOUNT numeric(18,2),
    RUN_TOTAL numeric(18,2) )
AS
BEGIN
  RUN_TOTAL = 0;
  FOR select 
    'INV' TxnType
    ,i.TXN_NUMBER
    ,i.TXN_DATE
    ,i.TXN_AMOUNT
    ,i.TXN_DOWNPAYMENT
    ,0
    ,0
    ,0
    from txn i
    where i.CLIENT_ID = :CLIENT_ID

    union all

    select 
    'PMT' TxnType
    ,r.COL_NUMBER
    ,r.COL_DATE
    ,0
    ,r.COL_AMOUNT
    ,0
    ,0
    ,0
    from COLLECTION r
    where  r.CLIENT_ID = :CLIENT_ID and R.COL_TYPE='CAS'

    union all
    
    select 
    'RET' TxnType
    ,sc.SALES_CR_NUMBER
    ,sc.SALES_CR_DATE
    ,0
    ,0
    ,sc.SALES_CR_AMOUNT
    ,0
    ,0
    from SALES_CREDIT sc
    where  sc.CLIENT_ID = :CLIENT_ID    
    
    union all
    
    select 
    'AFF' TxnType
    ,a.COL_NUMBER
    ,a.COL_DATE
    ,0
    ,0
    ,0
    ,a.COL_AMOUNT
    ,0
    from COLLECTION a
    where  a.CLIENT_ID = :CLIENT_ID and a.COL_TYPE='AFF'

    union all
    
    select 
    'DIS' TxnType
    ,D.COL_NUMBER
    ,D.COL_DATE
    ,0
    ,0
    ,0
    ,0
    ,D.COL_AMOUNT
    from COLLECTION D
    where  D.CLIENT_ID = :CLIENT_ID and D.COL_TYPE='DIS'

    order by 3, 2

    into :TXN_TYPE,
         :TXN_NUMBER,
         :TXN_DATE,
         :TXN_CHARGES,
         :TXN_PAYMENT,
         :TXN_RETURNS,
         :TXN_AFFIDAVIT,
         :TXN_DISCOUNT
    DO
    begin
      RUN_TOTAL = RUN_TOTAL + TXN_CHARGES - TXN_PAYMENT - TXN_RETURNS - TXN_AFFIDAVIT - TXN_DISCOUNT;
      SUSPEND;
    END
      
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_INV_OVERDUE (
    ASOFDATE date )
RETURNS (
    TXN_NUMBER varchar(15),
    TXN_DATE date,
    TXN_DUEDATE date,
    TXN_AMOUNT numeric(15,2),
    TXN_AMOUNTPAID numeric(15,2),
    CLIENT_ID integer,
    CLIENT_NAME varchar(40),
    DAYS_OVERDUE integer,
    BALANCE numeric(15,2),
    AGE integer )
AS
BEGIN
    FOR SELECT 
        a.TXN_NUMBER, 
        a.TXN_DATE, 
        a.TXN_DUEDATE, 
        a.TXN_AMOUNT, 
        a.TXN_AMOUNTPAID, 
        a.CLIENT_ID,
        (SELECT CLIENT_NAME  from CLIENT C
         where C.CLIENT_ID=a.CLIENT_ID) AS CLIENT_NAME
    FROM TXN a
    where ((TXN_AMOUNT-TXN_AMOUNTPAID) > 0)
      and (TXN_DATE <= :ASOFDATE) 
    INTO 
        TXN_NUMBER, 
        TXN_DATE, 
        TXN_DUEDATE, 
        TXN_AMOUNT, 
        TXN_AMOUNTPAID, 
        CLIENT_ID,
        CLIENT_NAME 
    DO
    BEGIN
        DAYS_OVERDUE = (ASOFDATE - TXN_DUEDATE);
        if (DAYS_OVERDUE < 0) then 
          DAYS_OVERDUE = 0;
        if (DAYS_OVERDUE > 90) then AGE = 99;
        else if (DAYS_OVERDUE > 60) then AGE = 90;
        else if (DAYS_OVERDUE > 30) then AGE = 60;
        else if (DAYS_OVERDUE > 0) then AGE = 30;
        else AGE = 0;
        BALANCE = coalesce(TXN_AMOUNT - TXN_AMOUNTPAID,0);
        SUSPEND;
    END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_PRODUCTION (
    PERIOD_BATCH varchar(10),
    A_PRODUCT_ID integer )
RETURNS (
    TXN_PERIOD varchar(10),
    TXN_ID integer,
    TXN_DATE date,
    TXN_NUMBER varchar(15),
    TXN_AMOUNT numeric(15,2),
    TXN_DOWNPAYMENT numeric(15,2),
    TXN_BALANCE numeric(15,2),
    CLIENT_NAME varchar(40),
    STREET_ADDRESS varchar(40),
    ADDRESS varchar(40),
    TOWN varchar(40),
    PROVINCE varchar(40),
    SALES_REP varchar(40),
    TXN_DETAIL_ID integer,
    PRODUCT_ID integer,
    PRODUCTNAME varchar(40),
    QTYOUT numeric(18,2) )
AS
declare variable old_txn_number varchar(15);
BEGIN
  if (period_batch is null) then
    period_batch = '';
  old_txn_number = 'xxx';
  for select 
    TXN_PERIOD
    , TXN_ID 
    , TXN_DATE 
    , TXN_NUMBER 
    , TXN_AMOUNT 
    , TXN_DOWNPAYMENT 
    , TXN_BALANCE 
    , CLIENT_NAME 
    , STREET_ADDRESS
    , ADDRESS
    , TOWN 
    , PROVINCE 
    , SALES_REP
    , TXN_DETAIL_ID 
    , PRODUCT_ID 
    , PRODUCTNAME 
    , QTYOUT 

    FROM VW_PRODUCTION       
    where TXN_PERIOD starting :period_batch and  PRODUCT_ID = :A_product_id

  into 
    : TXN_PERIOD
    , :TXN_ID 
    , :TXN_DATE 
    , :TXN_NUMBER 
    , :TXN_AMOUNT 
    , :TXN_DOWNPAYMENT 
    , :TXN_BALANCE 
    , :CLIENT_NAME 
    , :STREET_ADDRESS
    , :ADDRESS 
    , :TOWN 
    , :PROVINCE 
    , :SALES_REP
    , :TXN_DETAIL_ID 
    , :PRODUCT_ID 
    , :PRODUCTNAME 
    , :QTYOUT

  do
  begin
    if (old_txn_number <> txn_number) then old_txn_number = txn_number;
    else begin
      txn_date = null;
      txn_amount = null;
      txn_downpayment = null;
      txn_balance = null;
      client_name = null;
      sales_rep = null;
    end
    suspend;
  end
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD (
    PERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    AGENT_ID integer,
    SALES_REP_NAME varchar(40),
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2) )
AS
BEGIN
    for select 
        sqt.agent_id,
        sr.CLIENT_NAME,
        t.PROVINCE, 
        t.TOWN,
        sqt.tqty,
        INV.TINVAMT,
        INV.TDOWNPMT,
        (INV.TINVAMT-INV.TDOWNPMT) balance
    from (select i.AGENT_ID, i.town_id, product_id, sum(QTYOUT) tqty  
            from TXN_DETAIL id
            join TXN i on i.TXN_ID=id.TXN_ID
            join TOWN l on l.TOWN_ID=i.TOWN_ID
           where product_id = :PRODUCT_ID 
           group by agent_id, l.PROVINCE, town_id, product_id
         ) sqt
    join (select AGENT_ID, txn.TOWN_ID, SUM(TXN_AMOUNT) tinvamt,
                 sum(TXN_DOWNPAYMENT) tdownpmt
            from TXN 
            join TOWN on town.TOWN_ID=txn.TOWN_ID
           where TXN_PERIOD starting :PERIOD
           group by AGENT_ID, town.PROVINCE, txn.TOWN_ID
         ) inv on (inv.AGENT_ID=sqt.AGENT_ID)
              and (inv.TOWN_ID=sqt.TOWN_ID)
    join TOWN t on (t.TOWN_ID=sqt.TOWN_ID)
    join CLIENT sr on (sr.CLIENT_ID=sqt.AGENT_ID) 
    order by sr.CLIENT_NAME, t.PROVINCE, t.TOWN
    into 
       :AGENT_ID ,
       :SALES_REP_NAME ,
       :PROVINCE ,
       :TOWN ,
       :QTY ,
       :INVAMT ,
       :DOWNPMT ,
       :BALANCE 
    do 
    begin
       suspend;
    end
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_PROD_SUMM_BYSR (
    APERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    AGENT_ID integer,
    SALES_REP_NAME varchar(40),
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2) )
AS
BEGIN
  FOR select 
             AGENT_ID
           , SALES_REP_NAME
           , PROVINCE
           , TOWN
           , inv.QTY
           , inv.INVAMOUNT
           , inv.DOWNPAYMENT
           , inv.BALANCE
      from ( select 
                i.TXN_PERIOD
              , i.AGENT_ID
              , i.TOWN_ID
              , qty.QTY
              , totals.INVAMOUNT
              , totals.DOWNPAYMENT
              , totals.BALANCE
              , ( select CLIENT_NAME from CLIENT c
                  where c.CLIENT_ID = i.AGENT_ID
                ) SALES_REP_NAME
              , ( select TOWN from TOWN t
                  where t.TOWN_ID = i.TOWN_ID
                ) TOWN
              , ( select PROVINCE from TOWN t
                  where t.TOWN_ID = i.TOWN_ID
                ) PROVINCE
            from TXN i 
            join ( select 
                    AGENT_ID
                  , TOWN_ID
                  , max(i.TXN_ID) TXN_ID
                  , sum(i.TXN_AMOUNT) INVAMOUNT
                  , sum(i.TXN_DOWNPAYMENT) DOWNPAYMENT
                  , sum(i.TXN_AMOUNT - i.TXN_DOWNPAYMENT) BALANCE
                 from TXN i
                 where i.TXN_PERIOD starting :APERIOD
                 group by 1,2 
                 ) totals on totals.txn_id = i.TXN_ID
            join ( select
                   m.AGENT_ID
                   , m.TOWN_ID
                   , max(m.TXN_ID) TXN_ID
                   , sum(c.QTYOUT) QTY
                   from TXN_DETAIL c 
                   join TXN m on m.TXN_ID = C.TXN_ID
                   where c.PRODUCT_ID = :PRODUCT_ID
                   and m.TXN_PERIOD starting :APERIOD
                   group by 1,2
                 ) qty on qty.TXN_ID =  i.TXN_ID
        ) inv       
      where inv.TXN_PERIOD starting :APERIOD
      order by SALES_REP_NAME, PROVINCE, TOWN
    into 
       :AGENT_ID,
       :SALES_REP_NAME,
       :PROVINCE ,
       :TOWN ,
       :QTY ,
       :INVAMT ,
       :DOWNPMT ,
       :BALANCE 
    do 
    begin
       suspend;
    end
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE SP_TXN_PROD_SUMM_BYTEAM (
    APERIOD varchar(10),
    PRODUCT_ID integer )
RETURNS (
    PROVINCE varchar(40),
    TOWN varchar(40),
    QTY integer,
    INVAMT numeric(15,2),
    DOWNPMT numeric(15,2),
    BALANCE numeric(15,2),
    PERIOD varchar(10) )
AS
BEGIN
  FOR select 
             PROVINCE
           , TOWN
           , inv.QTY
           , inv.INVAMOUNT
           , inv.DOWNPAYMENT
           , inv.BALANCE
      from ( select 
                i.TXN_PERIOD
              , i.TOWN_ID
              , qty.QTY
              , totals.INVAMOUNT
              , totals.DOWNPAYMENT
              , totals.BALANCE
              , ( select TOWN from TOWN t
                  where t.TOWN_ID = i.TOWN_ID
                ) TOWN
              , ( select PROVINCE from TOWN t
                  where t.TOWN_ID = i.TOWN_ID
                ) PROVINCE
            from TXN i 
            join ( select 
                    TXN_PERIOD
                  , TOWN_ID
                  , max(i.TXN_ID) TXN_ID
                  , sum(i.TXN_AMOUNT) INVAMOUNT
                  , sum(i.TXN_DOWNPAYMENT) DOWNPAYMENT
                  , sum(i.TXN_AMOUNT - i.TXN_DOWNPAYMENT) BALANCE
                 from TXN i
                 group by 1,2 
                 ) totals on totals.txn_id = i.TXN_ID
            join ( select
                   m.TXN_PERIOD
                   , m.TOWN_ID
                   , max(m.TXN_ID) TXN_ID
                   , sum(c.QTYOUT) QTY
                   from TXN_DETAIL c 
                   join TXN m on m.TXN_ID = C.TXN_ID
                   where c.PRODUCT_ID = :PRODUCT_ID
                   group by 1,2
                 ) qty on qty.TXN_ID =  i.TXN_ID
                   
        ) inv       
      where inv.TXN_PERIOD = :APERIOD
      order by PROVINCE, TOWN
    into 
       :PROVINCE ,
       :TOWN ,
       :QTY ,
       :INVAMT ,
       :DOWNPMT ,
       :BALANCE 
    do 
    begin
       suspend;
    end
END^
SET TERM ; ^


ALTER TABLE CLIENT ADD CONSTRAINT FK_CLIENT_0
  FOREIGN KEY (TOWN_ID) REFERENCES TOWN (TOWN_ID) ON UPDATE CASCADE ON DELETE NO ACTION;
ALTER TABLE CLIENT ADD CONSTRAINT CHK_CLIENT_TYPE
  check (CLIENT_TYPE in ('CU','SR','DI','CO'));
ALTER TABLE COLLECTION ADD CONSTRAINT FK_COLLECTION_0
  FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;
ALTER TABLE COLLECTION ADD CONSTRAINT CHK_COLLECTION_0
  CHECK(col_type IN ('CAS','AFF','DIS'));
ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT FK_COLLECTION_DETAIL_0
  FOREIGN KEY (COL_ID) REFERENCES COLLECTION (COL_ID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT FK_COLLECTION_DETAIL_1
  FOREIGN KEY (TXN_NUMBER) REFERENCES TXN (TXN_NUMBER) ON UPDATE CASCADE;
ALTER TABLE PRODUCT ADD CONSTRAINT FK_PRODUCT_1
  FOREIGN KEY (PRODUCT_TYPE_ID) REFERENCES PRODUCT_TYPE (PRODUCT_TYPE_ID) ON UPDATE CASCADE;
ALTER TABLE SALES_CREDIT ADD CONSTRAINT FK_SALES_CREDIT_0
  FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;
ALTER TABLE SALES_CREDIT_LINES ADD CONSTRAINT FK_SALES_CREDIT_LINES_0
  FOREIGN KEY (SALES_CR_ID) REFERENCES SALES_CREDIT (SALES_CR_ID) ON UPDATE CASCADE;
ALTER TABLE SALES_CREDIT_LINES ADD CONSTRAINT FK_SALES_CREDIT_LINES_1
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ON UPDATE CASCADE;
ALTER TABLE TOWN ADD TOWN_PROVINCE COMPUTED BY (iif(town is null,'',town)||
                   iif((town is null) or (province is null),'',' ')||
                   iif(province is null,'',province));
ALTER TABLE TOWN ADD CONSTRAINT CHK_TOWN_ATLEASTONE
  check ((TOWN IS NOT NULL) OR (PROVINCE IS NOT NULL));
ALTER TABLE TXN ADD CONSTRAINT FK_TXN_1
  FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;
ALTER TABLE TXN ADD CONSTRAINT FK_TXN_2
  FOREIGN KEY (TXN_TYPE_CID) REFERENCES TXN_TYPE (TXN_TYPE_CID) ON UPDATE CASCADE;
ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_1
  FOREIGN KEY (TXN_ID) REFERENCES TXN (TXN_ID) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_2
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ON UPDATE CASCADE;
UPDATE RDB$TRIGGERS set
  RDB$DESCRIPTION = 'AGENT_ID and COLLECTOR_ID are not covered by Foreign Keys'
  where RDB$TRIGGER_NAME = 'CLIENT_BD_SALESREP';
GRANT EXECUTE
 ON PROCEDURE SEL_CLIENT TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SEL_COLLECTION TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SEL_INVOICE TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SEL_SALES_CREDIT TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SEL_SALES_CREDIT_LINES TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SEL_UNPAID_INVOICES TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_BALANCES TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_BALANCES_BYSR TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_CUS_STATEMENT TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_INV_OVERDUE TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_PRODUCTION TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_PROD_SUMM_BYSR TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE SP_TXN_PROD_SUMM_BYTEAM TO  SYSDBA;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON AGENT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON CLIENT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON CLIENT_GROUP TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON COLLECTION TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON COLLECTION_DETAIL TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON COLLECTION_MD_GTT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON PRODUCT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON PRODUCT_TYPE TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON SALES_CREDIT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON SALES_CREDIT_LINES TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON SALES_CREDIT_MD_GTT TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON TOWN TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON TXN TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON TXN_DETAIL TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON TXN_TYPE TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON VW_PAYMENTS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON VW_PRODUCTION TO  SYSDBA WITH GRANT OPTION;


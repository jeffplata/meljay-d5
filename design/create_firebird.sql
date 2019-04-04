/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v6.0.0                     */
/* Target DBMS:           Firebird 2                                      */
/* Project file:          Project1.dez                                    */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2014-08-17 22:59                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Sequences                                                              */
/* ---------------------------------------------------------------------- */

CREATE GENERATOR GEN_CLIENT_ID;
SET GENERATOR GEN_CLIENT_ID TO 0;

CREATE GENERATOR GEN_PRODUCT_ID;
SET GENERATOR GEN_PRODUCT_ID TO 0;

CREATE GENERATOR GEN_TXN_ID;
SET GENERATOR GEN_TXN_ID TO 0;

CREATE GENERATOR GEN_TXN_DETAIL_ID;
SET GENERATOR GEN_TXN_DETAIL_ID TO 0;

CREATE GENERATOR GEN_HIGHVALUE_ID;
SET GENERATOR GEN_HIGHVALUE_ID TO 0;

CREATE GENERATOR GEN_PRODUCT_TYPE_ID;
SET GENERATOR GEN_PRODUCT_TYPE_ID TO 0;

CREATE GENERATOR GEN_AGENT_ID;
SET GENERATOR GEN_AGENT_ID TO 0;

CREATE GENERATOR GEN_CLIENT_GROUP_ID;
SET GENERATOR GEN_CLIENT_GROUP_ID TO 0;

CREATE GENERATOR VER_CLIENT;
SET GENERATOR VER_CLIENT TO 0;

CREATE GENERATOR VER_SALESREP;
SET GENERATOR VER_SALESREP TO 0;

CREATE GENERATOR VER_TOWN;
SET GENERATOR VER_TOWN TO 0;

CREATE GENERATOR VER_COLLECTOR;
SET GENERATOR VER_COLLECTOR TO 0;

/* ---------------------------------------------------------------------- */
/* Domains                                                                */
/* ---------------------------------------------------------------------- */

CREATE DOMAIN DM_MONEY AS NUMERIC(15,2) COLLATE NONE;

CREATE DOMAIN DM_CID_PK AS VARCHAR(6) CHARACTER SET NONE COLLATE NONE;

CREATE DOMAIN DM_ID_PK AS INTEGER COLLATE NONE;

CREATE DOMAIN DM_CID AS VARCHAR(6) CHARACTER SET NONE COLLATE NONE;

CREATE DOMAIN DM_ID AS INTEGER COLLATE NONE;

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "AGENT"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE AGENT (
    AGENT_ID INTEGER NOT NULL,
    AGENT_NAME VARCHAR(40) CHARACTER SET NONE NOT NULL COLLATE NONE,
    ADDRESS VARCHAR(90) CHARACTER SET NONE COLLATE NONE,
    PHONE_NUMBERS VARCHAR(90) CHARACTER SET NONE COLLATE NONE,
    AREA VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
    CONSTRAINT INTEG_38 PRIMARY KEY (AGENT_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "CLIENT"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE CLIENT (
    CLIENT_ID INTEGER NOT NULL,
    CLIENT_NAME VARCHAR(40) CHARACTER SET NONE NOT NULL COLLATE NONE,
    STREET_ADDRESS VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
    ADDRESS VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
    TOWN_ID INTEGER,
    PHONE VARCHAR(60) CHARACTER SET NONE COLLATE NONE,
    AGENT_ID INTEGER,
    CLIENT_TYPE CHAR(2) CHARACTER SET NONE NOT NULL COLLATE NONE,
    CONSTRAINT PK_CLIENT PRIMARY KEY (CLIENT_ID),
    CONSTRAINT CHK_CLIENT_TYPE CHECK (CLIENT_TYPE in ('CU','SR','DI','CO'))
);

/* ---------------------------------------------------------------------- */
/* Add table "CLIENT_GROUP"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE CLIENT_GROUP (
    CLIENT_GROUP_ID INTEGER NOT NULL,
    GROUP_NAME VARCHAR(30) CHARACTER SET NONE NOT NULL COLLATE NONE,
    CONSTRAINT PK_CLIENT_GROUP PRIMARY KEY (CLIENT_GROUP_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "COLLECTION"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE COLLECTION (
    COL_ID DM_ID NOT NULL COLLATE NONE,
    COL_NUMBER VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE,
    COL_DATE DATE NOT NULL,
    COL_TYPE CHAR(3) CHARACTER SET NONE NOT NULL COLLATE NONE,
    COL_REF VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
    COL_AMOUNT NUMERIC(15,2) DEFAULT 0 NOT NULL,
    COL_AMOUNTAPPLIED DM_MONEY DEFAULT 0 NOT NULL,
    COL_DESCRIPTION VARCHAR(50) CHARACTER SET NONE COLLATE NONE,
    CLIENT_ID DM_ID NOT NULL COLLATE NONE,
    AGENT_ID DM_ID NOT NULL COLLATE NONE,
    PMT_REF VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
    PMT_TYPE VARCHAR(15),
    COLLECTOR_ID INTEGER NOT NULL,
    CONSTRAINT PK_COLLECTION_0 PRIMARY KEY (COL_ID),
    CONSTRAINT CHK_COLLECTION_0 CHECK (col_type IN ('CAS','AFF','DIS'))
);

/* ---------------------------------------------------------------------- */
/* Add table "COLLECTION_DETAIL"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE COLLECTION_DETAIL (
    COL_DETAIL_ID DM_ID_PK NOT NULL COLLATE NONE,
    COL_ID DM_ID NOT NULL COLLATE NONE,
    TXN_NUMBER VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE,
    TXN_DATE DATE,
    COL_DETAIL_AMTPAID DM_MONEY,
    AFFIDAVIT_AMT NUMERIC(15,2),
    DISCOUNT NUMERIC(15,2),
    CONSTRAINT PK_COLLECTION_DETAIL_0 PRIMARY KEY (COL_DETAIL_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "COLLECTION_MD_GTT"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE COLLECTION_MD_GTT (
    MASTER_ID INTEGER NOT NULL,
    CLIENT_ADDRESS VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE
);

/* ---------------------------------------------------------------------- */
/* Add table "PRODUCT"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE PRODUCT (
    PRODUCT_ID INTEGER NOT NULL,
    PRODUCT_NAME VARCHAR(40) CHARACTER SET NONE NOT NULL COLLATE NONE,
    PRODUCT_TYPE_ID INTEGER DEFAULT 0 NOT NULL,
    PRICE NUMERIC(15,2),
    CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "PRODUCT_TYPE"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE PRODUCT_TYPE (
    PRODUCT_TYPE_ID INTEGER NOT NULL,
    TYPE_NAME VARCHAR(40) CHARACTER SET NONE NOT NULL COLLATE NONE,
    CONSTRAINT PK_PRODUCT_TYPE PRIMARY KEY (PRODUCT_TYPE_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "SALES_CREDIT"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE SALES_CREDIT (
    SALES_CR_ID INTEGER NOT NULL,
    SALES_CR_NUMBER VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
    SALES_CR_DATE DATE,
    SALES_CR_AMOUNT NUMERIC(15,2),
    CLIENT_ID INTEGER NOT NULL,
    CONSTRAINT PK_SALES_CREDIT_0 PRIMARY KEY (SALES_CR_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "SALES_CREDIT_LINES"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE SALES_CREDIT_LINES (
    SALES_CR_LINES_ID INTEGER NOT NULL,
    SALES_CR_ID INTEGER NOT NULL,
    PRODUCT_ID INTEGER NOT NULL,
    QTY NUMERIC(18,2),
    SALES_DOC_NO VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
    COST_UNIT NUMERIC(18,2),
    COST_TOTAL NUMERIC(18,2),
    PRICE_UNIT NUMERIC(18,2),
    PRICE_TOTAL NUMERIC(18,2),
    CONSTRAINT PK_SALES_CREDIT_LINES_0 PRIMARY KEY (SALES_CR_LINES_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "SALES_CREDIT_MD_GTT"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE SALES_CREDIT_MD_GTT (
    MASTER_ID INTEGER NOT NULL,
    CLIENT_ADDRESS VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE
);

/* ---------------------------------------------------------------------- */
/* Add table "TOWN"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE TOWN (
    TOWN_ID INTEGER NOT NULL,
    TOWN VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
    PROVINCE VARCHAR(40) CHARACTER SET NONE COLLATE NONE,
    TOWN_PROVINCE COMPUTED BY (iif(town is null,'',town)||
                   iif((town is null) or (province is null),'',' ')||
                   iif(province is null,'',province)),
    CONSTRAINT PK_TOWN_0 PRIMARY KEY (TOWN_ID),
    CONSTRAINT CHK_TOWN_ATLEASTONE CHECK ((TOWN IS NOT NULL) OR (PROVINCE IS NOT NULL))
);

/* ---------------------------------------------------------------------- */
/* Add table "TXN"                                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE TXN (
    TXN_ID INTEGER NOT NULL,
    TXN_NUMBER VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE,
    TXN_DATE DATE DEFAULT NOW NOT NULL,
    TXN_PERIOD VARCHAR(10) CHARACTER SET NONE NOT NULL COLLATE NONE,
    TXN_DAYSDUE SMALLINT,
    TXN_DUEDATE DATE,
    TXN_AMOUNT NUMERIC(15,2) NOT NULL,
    TXN_DOWNPAYMENT NUMERIC(15,2) NOT NULL,
    TXN_AMOUNTPAID NUMERIC(15,2) NOT NULL,
    TXN_PARTICULARS VARCHAR(255) CHARACTER SET NONE COLLATE NONE,
    TXN_TYPE_CID VARCHAR(6) CHARACTER SET NONE NOT NULL COLLATE NONE,
    CLIENT_ID INTEGER NOT NULL,
    AGENT_ID INTEGER NOT NULL,
    TOWN_ID INTEGER,
    LASTCHANGED TIMESTAMP,
    CONSTRAINT PK_TXN PRIMARY KEY (TXN_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "TXN_DETAIL"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE TXN_DETAIL (
    TXN_DETAIL_ID INTEGER NOT NULL,
    TXN_ID INTEGER NOT NULL,
    PRODUCT_ID INTEGER NOT NULL,
    QTYIN NUMERIC(18,2),
    QTYOUT NUMERIC(18,2),
    COST_UNIT NUMERIC(18,2),
    COST_TOTAL NUMERIC(18,2),
    PRICE_UNIT NUMERIC(18,2),
    PRICE_TOTAL NUMERIC(18,2),
    CONSTRAINT PK_TXN_DETAIL PRIMARY KEY (TXN_DETAIL_ID)
);

/* ---------------------------------------------------------------------- */
/* Add table "TXN_MD_GTT"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE TXN_MD_GTT (
    MASTER_ID INTEGER NOT NULL,
    CLIENT_ADDRESS VARCHAR(15) CHARACTER SET NONE NOT NULL COLLATE NONE
);

/* ---------------------------------------------------------------------- */
/* Add table "TXN_TYPE"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE TXN_TYPE (
    TXN_TYPE_CID VARCHAR(6) CHARACTER SET NONE NOT NULL COLLATE NONE,
    TYPE_NAME VARCHAR(20) CHARACTER SET NONE NOT NULL COLLATE NONE,
    DIRECTION SMALLINT DEFAULT 0 NOT NULL,
    CONSTRAINT PK_TXN_TYPE PRIMARY KEY (TXN_TYPE_CID)
);

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE CLIENT ADD CONSTRAINT FK_CLIENT_0 
    FOREIGN KEY (TOWN_ID) REFERENCES TOWN (TOWN_ID) ON UPDATE CASCADE;

ALTER TABLE COLLECTION ADD CONSTRAINT FK_COLLECTION_0 
    FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;

ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT FK_COLLECTION_DETAIL_0 
    FOREIGN KEY (COL_ID) REFERENCES COLLECTION (COL_ID) ON DELETE CASCADE ON UPDATE CASCADE;

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

ALTER TABLE TXN ADD CONSTRAINT FK_TXN_2 
    FOREIGN KEY (TXN_TYPE_CID) REFERENCES TXN_TYPE (TXN_TYPE_CID) ON UPDATE CASCADE;

ALTER TABLE TXN ADD CONSTRAINT FK_TXN_1 
    FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;

ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_1 
    FOREIGN KEY (TXN_ID) REFERENCES TXN (TXN_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_2 
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ON UPDATE CASCADE;

/* ---------------------------------------------------------------------- */
/* Views                                                                  */
/* ---------------------------------------------------------------------- */

CREATE VIEW VW_PRODUCTION
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
         ) c on c.CLIENT_ID=i.CLIENT_ID;

CREATE VIEW VW_PAYMENTS
AS 
SELECT I.TXN_NUMBER, I.TXN_AMOUNT, I.TXN_DOWNPAYMENT+C.CASH CASH, C.AFFIDAVIT, C.DISCOUNT, R.RETURN
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
JOIN (select TXN_NUMBER, sum(PRICE_TOTAL) "RETURN"
        from (select SALES_DOC_NO TXN_NUMBER, PRICE_UNIT * QTY AS PRICE_TOTAL
                from SALES_CREDIT_LINES RET2
                join SALES_CREDIT RET1 on RET1.SALES_CR_ID=RET2.SALES_CR_ID
                union all select TXN_NUMBER, 0 from TXN
                
             ) group by TXN_NUMBER
     ) R on R.TXN_NUMBER=I.TXN_NUMBER;

/* ---------------------------------------------------------------------- */
/* Procedures                                                             */
/* ---------------------------------------------------------------------- */

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_INV_OVERDUE
(ASOFDATE DATE )
RETURNS (TXN_NUMBER VARCHAR(15), TXN_DATE DATE , TXN_DUEDATE DATE , TXN_AMOUNT NUMERIC(15,2), TXN_AMOUNTPAID NUMERIC(15,2), CLIENT_ID INTEGER , CLIENT_NAME VARCHAR(40), DAYS_OVERDUE INTEGER , BALANCE NUMERIC(15,2), AGE INTEGER )

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PRODUCTION
(PERIOD_BATCH VARCHAR(10), A_PRODUCT_ID INTEGER )
RETURNS (TXN_PERIOD VARCHAR(10), TXN_ID INTEGER , TXN_DATE DATE , TXN_NUMBER VARCHAR(15), TXN_AMOUNT NUMERIC(15,2), TXN_DOWNPAYMENT NUMERIC(15,2), TXN_BALANCE NUMERIC(15,2), CLIENT_NAME VARCHAR(40), STREET_ADDRESS VARCHAR(40), ADDRESS VARCHAR(40), TOWN VARCHAR(40), PROVINCE VARCHAR(40), SALES_REP VARCHAR(40), TXN_DETAIL_ID INTEGER , PRODUCT_ID INTEGER , PRODUCTNAME VARCHAR(40), QTYOUT NUMERIC(18,2))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_BALANCES
(PERIOD_BATCH VARCHAR(10), A_PRODUCT_ID INTEGER , A_PROVINCE VARCHAR(40))
RETURNS (TXN_PERIOD VARCHAR(10), TXN_ID INTEGER , TXN_DATE DATE , TXN_NUMBER VARCHAR(15), TXN_AMOUNT NUMERIC(15,2), PAYMENTS NUMERIC(15,2), BALANCE NUMERIC(15,2), CLIENT_NAME VARCHAR(40), STREET_ADDRESS VARCHAR(40), ADDRESS VARCHAR(40), TOWN VARCHAR(40), PROVINCE VARCHAR(40), SALES_REP VARCHAR(40), TXN_DETAIL_ID INTEGER , PRODUCT_ID INTEGER , PRODUCTNAME VARCHAR(40), QTYOUT NUMERIC(18,2))

AS
declare variable old_txn_number varchar(15);
BEGIN
  if (period_batch is null) then period_batch = '';
  if (a_province is null) then a_province = '';
  old_txn_number = 'xxx';
  for select 
    TXN_PERIOD
    , TXN_ID 
    , TXN_DATE 
    , TXN_NUMBER 
    , TXN_AMOUNT 
    , (SELECT CASH+AFFIDAVIT+DISCOUNT+"RETURN" FROM VW_PAYMENTS P
       WHERE P.TXN_NUMBER=I.TXN_NUMBER) PAYMENTS 
--    , TXN_BALANCE 
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

    FROM VW_PRODUCTION I      
    where ((TXN_PERIOD starting :period_batch) or (TXN_PERIOD < :period_batch)) and  PRODUCT_ID = :A_product_id
          and PROVINCE containing :A_PROVINCE

  into 
    : TXN_PERIOD
    , :TXN_ID 
    , :TXN_DATE 
    , :TXN_NUMBER 
    , :TXN_AMOUNT 
    , :PAYMENTS
--    , :TXN_BALANCE 
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
    balance = txn_amount - payments;
    if (old_txn_number <> txn_number) then old_txn_number = txn_number;
    else begin
      txn_date = null;
      txn_amount = null;
      payments = null;
      balance = null;
      client_name = null;
      sales_rep = null;
    end
    if (balance <> 0) then
      suspend;
  end
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_CUS_STATEMENT
(CLIENT_ID INTEGER )
RETURNS (TXN_TYPE CHAR(3), TXN_NUMBER VARCHAR(10), TXN_DATE DATE , TXN_CHARGES NUMERIC(18,2), TXN_PAYMENT NUMERIC(18,2), TXN_RETURNS NUMERIC(18,2), TXN_AFFIDAVIT NUMERIC(18,2), TXN_DISCOUNT NUMERIC(18,2), RUN_TOTAL NUMERIC(18,2))

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
      
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_COLLECTION
(P_START_DATE DATE , P_END_DATE DATE , P_CLIENT_ID INTEGER , P_COLLECTOR_ID INTEGER , P_COL_TYPE CHAR(3), P_COL_NUMBER VARCHAR(15), P_UNAPPLIEDONLY INTEGER )
RETURNS (COL_ID INTEGER , COL_NUMBER VARCHAR(15), COL_DATE DATE , COL_TYPE CHAR(3), COL_REF VARCHAR(15), COL_AMOUNT NUMERIC(15,2), COL_AMOUNTAPPLIED NUMERIC(15,2), COL_DESCRIPTION VARCHAR(50), CLIENT_ID INTEGER , AGENT_ID INTEGER , COLLECTOR_ID INTEGER , PMT_REF VARCHAR(15), PMT_TYPE VARCHAR(15), CLIENTNAME VARCHAR(40), COLLECTORNAME VARCHAR(40), UNAPPLIEDAMOUNT NUMERIC(15))

AS
declare variable client_address varchar(15);
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
           or (COL_AMOUNT-COL_AMOUNTAPPLIED <> 0)
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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_BALANCES_BYSR
(PERIOD_BATCH VARCHAR(10), A_PRODUCT_ID INTEGER , A_PROVINCE VARCHAR(40))
RETURNS (TXN_PERIOD VARCHAR(10), TXN_ID INTEGER , TXN_DATE DATE , TXN_NUMBER VARCHAR(15), TXN_AMOUNT NUMERIC(15,2), PAYMENTS NUMERIC(15,2), BALANCE NUMERIC(15,2), CLIENT_NAME VARCHAR(40), STREET_ADDRESS VARCHAR(40), ADDRESS VARCHAR(40), TOWN VARCHAR(40), PROVINCE VARCHAR(40), SALES_REP VARCHAR(40), TXN_DETAIL_ID INTEGER , PRODUCT_ID INTEGER , PRODUCTNAME VARCHAR(40), QTYOUT NUMERIC(18,2))

AS
declare variable old_txn_number varchar(15);
declare variable target_code varchar(4);
BEGIN
  if (period_batch is null) then period_batch = '';
  target_code = substring(period_batch from 7);

  old_txn_number = 'xxx';
  for select 
    TXN_PERIOD
    , TXN_ID 
    , TXN_DATE 
    , TXN_NUMBER 
    , TXN_AMOUNT 
    , (SELECT CASH+AFFIDAVIT+DISCOUNT+"RETURN" FROM VW_PAYMENTS P
       WHERE P.TXN_NUMBER=I.TXN_NUMBER) PAYMENTS 
--    , TXN_BALANCE 
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

    FROM VW_PRODUCTION I      
    where ((TXN_PERIOD = :period_batch) or ((TXN_PERIOD < :period_batch) and (substring(TXN_PERIOD from 7)=:target_code) )) 
      and  PRODUCT_ID = :A_product_id

  into 
    : TXN_PERIOD
    , :TXN_ID 
    , :TXN_DATE 
    , :TXN_NUMBER 
    , :TXN_AMOUNT 
    , :PAYMENTS
--    , :TXN_BALANCE 
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
    balance = txn_amount - payments;
    if (old_txn_number <> txn_number) then old_txn_number = txn_number;
    else begin
      txn_date = null;
      txn_amount = null;
      payments = null;
      balance = null;
      client_name = null;
      sales_rep = null;
    end
    if (balance <> 0) then
      suspend;
  end
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_CLIENT
RETURNS (CLIENT_ID INTEGER , CLIENT_NAME VARCHAR(40), STREET_ADDRESS VARCHAR(40), ADDRESS VARCHAR(40), TOWN_ID INTEGER , PHONE VARCHAR(60), AGENT_ID INTEGER , CLIENT_TYPE CHAR(2), COMPLETEADDRESS VARCHAR(121), TOWNPROVINCE VARCHAR(81), CLIENTTYPEDESC VARCHAR(40), AGENTNAME VARCHAR(20))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_SALES_CREDIT
(P_START_DATE DATE , P_END_DATE DATE , P_CLIENT_ID INTEGER , P_SALES_CR_NUMBER VARCHAR(15))
RETURNS (SALES_CR_ID INTEGER , SALES_CR_NUMBER VARCHAR(15), SALES_CR_DATE DATE , SALES_CR_AMOUNT NUMERIC(15,2), CLIENT_ID INTEGER , CLIENTNAME VARCHAR(40))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_INVOICE
(P_START_DATE DATE , P_END_DATE DATE , P_TXN_PERIOD VARCHAR(10), P_CLIENT_ID INTEGER , P_AGENT_ID INTEGER , P_TOWN_ID INTEGER , P_TXN_NUMBER VARCHAR(15))
RETURNS (TXN_ID INTEGER , TXN_NUMBER VARCHAR(15), TXN_DATE DATE , TXN_PERIOD VARCHAR(10), TXN_DAYSDUE SMALLINT , TXN_DUEDATE DATE , TXN_AMOUNT NUMERIC(15,2), TXN_DOWNPAYMENT NUMERIC(15,2), TXN_AMOUNTPAID NUMERIC(15,2), SALESCREDIT NUMERIC(15,2), BALANCE NUMERIC(15,2), TXN_PARTICULARS VARCHAR(255), TXN_TYPE_CID VARCHAR(6), CLIENT_ID INTEGER , AGENT_ID INTEGER , TOWN_ID INTEGER , CLIENTNAME VARCHAR(40), AGENTNAME VARCHAR(40), TOWNPROVINCE VARCHAR(82))

AS
declare variable CLIENT_ADDRESS varchar(15);
BEGIN
    client_address = rdb$get_context('SYSTEM','CLIENT_ADDRESS');
    delete from TXN_MD_GTT
     where client_address = :client_address;
    FOR SELECT 
        a.TXN_ID, 
        a.TXN_NUMBER, 
        a.TXN_DATE, 
        a.TXN_PERIOD, 
        a.TXN_DAYSDUE, 
        a.TXN_DUEDATE, 
        a.TXN_AMOUNT, 
        a.TXN_DOWNPAYMENT, 
        a.TXN_AMOUNTPAID, 
        P.CASH -TXN_DOWNPAYMENT + P.AFFIDAVIT + P.DISCOUNT + P.RETURN SALESCREDIT,
        a.TXN_PARTICULARS, 
        a.TXN_TYPE_CID, 
        a.CLIENT_ID, 
        a.AGENT_ID, 
        a.TOWN_ID
        , ( select CLIENT_NAME from CLIENT c 
            where c.CLIENT_ID = a.CLIENT_ID
          ) CLIENTNAME
        , ( select CLIENT_NAME from CLIENT sr 
            where sr.CLIENT_ID = a.AGENT_ID
          ) AGENTNAME
        , ( select TOWN_PROVINCE from TOWN t
            where t.TOWN_ID = a.TOWN_ID
          ) TOWNPROVINCE
    FROM TXN a
    JOIN VW_PAYMENTS P on P.TXN_NUMBER = a.TXN_NUMBER
    
    where (:p_start_date is null 
           or a.TXN_DATE between :p_start_date and :p_end_date
          ) and
          (:p_txn_period is null
           or (a.txn_period starting :p_txn_period)
          ) and
          (:p_txn_number is null
           or a.txn_number containing :p_txn_number
          ) and
          (:p_client_id is null
           or a.CLIENT_ID = :p_client_id
          ) and 
          (:p_agent_id is null
           or a.AGENT_ID = :p_agent_id
          ) and 
          (:p_town_id is null
           or (a.town_id = :p_town_id)
          ) 
    
    INTO 
        TXN_ID, 
        TXN_NUMBER, 
        TXN_DATE, 
        TXN_PERIOD, 
        TXN_DAYSDUE, 
        TXN_DUEDATE, 
        TXN_AMOUNT, 
        TXN_DOWNPAYMENT, 
        TXN_AMOUNTPAID, 
        SALESCREDIT,
        TXN_PARTICULARS, 
        TXN_TYPE_CID, 
        CLIENT_ID, 
        AGENT_ID, 
        TOWN_ID,
        CLIENTNAME,
        AGENTNAME,
        TOWNPROVINCE 
    DO
    BEGIN
        insert into txn_md_gtt
          values(:TXN_ID,:client_address);
         BALANCE = txn_amount - txn_downpayment - salescredit;
        SUSPEND;
    END
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_UNPAID_INVOICES
RETURNS (TXN_NUMBER VARCHAR(15), TXN_DATE DATE , TXN_AMOUNT NUMERIC(15,2), TXN_AMOUNTPAID NUMERIC(15,2), TXN_DOWNPAYMENT NUMERIC(15,2), CLIENT_ID INTEGER , TXN_TYPE_CID VARCHAR(6), AGENT_ID INTEGER )

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD
(PERIOD VARCHAR(10), PRODUCT_ID INTEGER )
RETURNS (AGENT_ID INTEGER , SALES_REP_NAME VARCHAR(40), PROVINCE VARCHAR(40), TOWN VARCHAR(40), QTY INTEGER , INVAMT NUMERIC(15,2), DOWNPMT NUMERIC(15,2), BALANCE NUMERIC(15,2))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_SALES_CREDIT_LINES
RETURNS (SALES_CR_LINES_ID INTEGER , SALES_CR_ID INTEGER , PRODUCT_ID INTEGER , PRODUCTNAME VARCHAR(40), QTY NUMERIC(18,2), SALES_DOC_NO VARCHAR(15), COST_UNIT NUMERIC(18,2), COST_TOTAL NUMERIC(18,2), PRICE_UNIT NUMERIC(18,2), PRICETOTAL NUMERIC(18,2))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SEL_INVOICE_DETAIL
RETURNS (TXN_DETAIL_ID INTEGER , TXN_ID INTEGER , PRODUCT_ID INTEGER , PRODUCTNAME VARCHAR(40), QTYIN NUMERIC(18,2), QTYOUT NUMERIC(18,2), COST_UNIT NUMERIC(18,2), COST_TOTAL NUMERIC(18,2), PRICE_UNIT NUMERIC(18,2), PRICETOTAL NUMERIC(18,2))

AS
begin
  for select txn_detail_id,
             txn_id,
             a.product_id,
             p.product_name,
             qtyin,
             qtyout,
             cost_unit,
             cost_total,
             price_unit,
             (qtyout * price_unit)
      from txn_detail a
      join product p on p.product_id = a.product_id
      join txn_md_gtt gtt
        on gtt.MASTER_ID = a.txn_id
          and gtt.CLIENT_ADDRESS = rdb$get_context('SYSTEM','CLIENT_ADDRESS')
      into :txn_detail_id,
           :txn_id,
           :product_id,
           :productname,
           :qtyin,
           :qtyout,
           :cost_unit,
           :cost_total,
           :price_unit,
           :pricetotal
  do
  begin
    suspend;
  end
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PROD_SUMM_BYTEAM
(APERIOD VARCHAR(10), PRODUCT_ID INTEGER )
RETURNS (PROVINCE VARCHAR(40), TOWN VARCHAR(40), QTY INTEGER , INVAMT NUMERIC(15,2), DOWNPMT NUMERIC(15,2), BALANCE NUMERIC(15,2), PERIOD VARCHAR(10))

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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE SP_TXN_PROD_SUMM_BYSR
(APERIOD VARCHAR(10), PRODUCT_ID INTEGER )
RETURNS (AGENT_ID INTEGER , SALES_REP_NAME VARCHAR(40), PROVINCE VARCHAR(40), TOWN VARCHAR(40), QTY INTEGER , INVAMT NUMERIC(15,2), DOWNPMT NUMERIC(15,2), BALANCE NUMERIC(15,2))

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
END ^
SET TERM ; ^

/* ---------------------------------------------------------------------- */
/* Triggers                                                               */
/* ---------------------------------------------------------------------- */

SET TERM ^ ;
CREATE TRIGGER AGENT_BI FOR AGENT
BEFORE INSERT
AS
BEGIN
  IF ((NEW.AGENT_ID IS NULL) OR (NEW.AGENT_ID < 0)) THEN
    NEW.AGENT_ID = GEN_ID(GEN_AGENT_ID,1);
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER AGENT_BUD0 FOR AGENT
BEFORE UPDATE OR DELETE
AS 
BEGIN 
  if (OLD.AGENT_ID = 0) then
    exception no_delete_system_data; 
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER CLIENT_BI FOR CLIENT
BEFORE INSERT
as
begin
  if ((new.CLIENT_id is null) or (new.CLIENT_id < 0))  then
    new.CLIENT_id = gen_id(gen_CLIENT_id,1);
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER CLIENT_BD_SALESREP FOR CLIENT
BEFORE DELETE
AS
BEGIN
  if (old.CLIENT_TYPE = 'SR') then
    if (exists (select 1 from CLIENT a
        where a.AGENT_ID = old.CLIENT_ID)) then
      exception no_delete_data_in_use;
      
  if (old.CLIENT_TYPE = 'CO') then
    if (exists (select 1 from COLLECTION c
        where c.COLLECTOR_ID = old.CLIENT_ID)) then
      exception no_delete_data_in_use;
    
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER CLIENT_BIUD FOR CLIENT
BEFORE INSERT OR UPDATE OR DELETE
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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER CLIENT_GROUP_BI FOR CLIENT_GROUP
BEFORE INSERT
as
begin
  if ((new.CLIENT_GROUP_id is null) or (NEW.CLIENT_GROUP_ID < 0))  then
    new.CLIENT_GROUP_id = gen_id(gen_CLIENT_GROUP_id,1);
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER CLIENT_GROUP_BUD0 FOR CLIENT_GROUP
BEFORE UPDATE OR DELETE
AS
begin
  if (OLD.CLIENT_GROUP_id = 0) then
    exception no_delete_system_data;
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER COLLECTION_DETAIL_BID FOR COLLECTION_DETAIL
BEFORE INSERT OR DELETE
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
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER PRODUCT_BI FOR PRODUCT
BEFORE INSERT
as
begin
  if ((new.PRODUCT_id is null) or (NEW.PRODUCT_id < 0))  then
    new.PRODUCT_id = gen_id(gen_PRODUCT_id,1);
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER PRODUCT_TYPE_BI FOR PRODUCT_TYPE
BEFORE INSERT
AS
BEGIN
  IF ((NEW.PRODUCT_TYPE_ID IS NULL) or (new.PRODUCT_TYPE_ID < 0)) THEN
    NEW.PRODUCT_TYPE_ID = GEN_ID(GEN_PRODUCT_TYPE_ID,1);
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER PRODUCT_TYPE_BUD0 FOR PRODUCT_TYPE
BEFORE UPDATE OR DELETE
AS
begin
  if (old.PRODUCT_TYPE_ID = 0) then
    exception no_delete_system_data;
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TOWN_BIUD FOR TOWN
BEFORE INSERT OR UPDATE OR DELETE
AS
declare x integer;
BEGIN
      x = gen_id(VER_TOWN,1);
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TXN_BI FOR TXN
BEFORE INSERT
as
begin
  if ((new.TXN_id is null) or (NEW.TXN_id < 0))  then
    new.TXN_id = gen_id(gen_TXN_id,1);
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TXN_BIU FOR TXN
BEFORE INSERT OR UPDATE
AS
BEGIN
  NEW.LASTCHANGED = 'NOW';
END ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TXN_DETAIL_BI FOR TXN_DETAIL
BEFORE INSERT
as
begin
  if ((new.TXN_DETAIL_id is null) or (NEW.TXN_DETAIL_id <0))  then
    new.TXN_DETAIL_id = gen_id(gen_TXN_DETAIL_id,1);
end ^
SET TERM ; ^

SET TERM ^ ;
CREATE TRIGGER TXN_DETAIL_BIUD FOR TXN_DETAIL
BEFORE INSERT OR UPDATE OR DELETE
AS
declare variable ATXN_ID integer;
BEGIN
  if (deleting) then atxn_id = old.TXN_ID;
  else atxn_id = new.TXN_ID;
  UPDATE TXN
     SET LASTCHANGED = 'NOW'
   WHERE TXN_ID = :ATXN_ID;
END ^
SET TERM ; ^

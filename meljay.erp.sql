SET SQL DIALECT 3;

CREATE DATABASE 'C:\dprojects\meljay\Data\MELJAY.ERP'
 USER 'sysdba' PASSWORD 'masterkey'
PAGE_SIZE 16384  DEFAULT CHARACTER SET NONE;

/* Server Version: WI-V6.3.5.18497 Firebird 2.1.  ODS Version: 11.1. */




CREATE DOMAIN DM_CID AS VARCHAR(6);

CREATE DOMAIN DM_CID_PK AS VARCHAR(6) NOT NULL;

CREATE DOMAIN DM_ID AS INTEGER;

CREATE DOMAIN DM_ID_PK AS INTEGER NOT NULL;

CREATE DOMAIN DM_MONEY AS NUMERIC(15,2);

CREATE TABLE AGENT(AGENT_ID INTEGER NOT NULL,
AGENT_NAME VARCHAR(40) NOT NULL,
ADDRESS VARCHAR(90),
PHONE_NUMBERS VARCHAR(90),
AREA VARCHAR(40));

CREATE TABLE CLIENT(CLIENT_ID INTEGER NOT NULL,
CLIENT_NAME VARCHAR(40) NOT NULL,
STREET_ADDRESS VARCHAR(40),
ADDRESS VARCHAR(40),
TOWN_ID INTEGER,
PHONE VARCHAR(60),
AGENT_ID INTEGER,
CLIENT_TYPE CHAR(2) NOT NULL);

CREATE TABLE CLIENT_GROUP(CLIENT_GROUP_ID INTEGER NOT NULL,
GROUP_NAME VARCHAR(30) NOT NULL);

CREATE TABLE COLLECTION(COL_ID DM_ID NOT NULL,
COL_NUMBER VARCHAR(15) NOT NULL,
COL_DATE DATE NOT NULL,
COL_TYPE CHAR(3) NOT NULL,
COL_REF VARCHAR(15),
COL_AMOUNT NUMERIC(15,2) DEFAULT 0 NOT NULL,
COL_AMOUNTAPPLIED DM_MONEY DEFAULT 0 NOT NULL,
COL_DESCRIPTION VARCHAR(50),
CLIENT_ID DM_ID NOT NULL,
AGENT_ID DM_ID NOT NULL,
PMT_REF VARCHAR(15),
PMT_TYPE VARCHAR(15),
COLLECTOR_ID INTEGER NOT NULL);

CREATE TABLE COLLECTION_DETAIL(COL_DETAIL_ID DM_ID_PK,
COL_ID DM_ID NOT NULL,
TXN_NUMBER VARCHAR(15) NOT NULL,
TXN_DATE DATE,
COL_DETAIL_AMTPAID DM_MONEY,
AFFIDAVIT_AMT NUMERIC(15,2),
DISCOUNT NUMERIC(15,2));

CREATE GLOBAL TEMPORARY TABLE COLLECTION_MD_GTT(MASTER_ID INTEGER NOT NULL,
CLIENT_ADDRESS VARCHAR(15) NOT NULL)
 ON COMMIT PRESERVE ROWS;

CREATE TABLE PRODUCT(PRODUCT_ID INTEGER NOT NULL,
PRODUCT_NAME VARCHAR(40) NOT NULL,
PRODUCT_TYPE_ID INTEGER DEFAULT 0 NOT NULL,
PRICE NUMERIC(15,2));

CREATE TABLE PRODUCT_TYPE(PRODUCT_TYPE_ID INTEGER NOT NULL,
TYPE_NAME VARCHAR(40) NOT NULL);

CREATE TABLE SALES_CREDIT(SALES_CR_ID INTEGER NOT NULL,
SALES_CR_NUMBER VARCHAR(15),
SALES_CR_DATE DATE,
SALES_CR_AMOUNT NUMERIC(15,2),
CLIENT_ID INTEGER NOT NULL);

CREATE TABLE SALES_CREDIT_LINES(SALES_CR_LINES_ID INTEGER NOT NULL,
SALES_CR_ID INTEGER NOT NULL,
PRODUCT_ID INTEGER NOT NULL,
QTY NUMERIC(18,2),
SALES_DOC_NO VARCHAR(15),
COST_UNIT NUMERIC(18,2),
COST_TOTAL NUMERIC(18,2),
PRICE_UNIT NUMERIC(18,2),
PRICE_TOTAL NUMERIC(18,2));

CREATE GLOBAL TEMPORARY TABLE SALES_CREDIT_MD_GTT(MASTER_ID INTEGER NOT NULL,
CLIENT_ADDRESS VARCHAR(15) NOT NULL)
 ON COMMIT PRESERVE ROWS;

CREATE TABLE TOWN(TOWN_ID INTEGER NOT NULL,
TOWN VARCHAR(40),
PROVINCE VARCHAR(40),
TOWN_PROVINCE COMPUTED BY (iif(town is null,'',town)||
                   iif((town is null) or (province is null),'',' ')||
                   iif(province is null,'',province)));

CREATE TABLE TXN(TXN_ID INTEGER NOT NULL,
TXN_NUMBER VARCHAR(15) NOT NULL,
TXN_DATE DATE DEFAULT 'NOW' NOT NULL,
TXN_PERIOD VARCHAR(10) NOT NULL,
TXN_DAYSDUE SMALLINT,
TXN_DUEDATE DATE,
TXN_AMOUNT NUMERIC(15,2) NOT NULL,
TXN_DOWNPAYMENT NUMERIC(15,2) NOT NULL,
TXN_AMOUNTPAID NUMERIC(15,2) NOT NULL,
TXN_PARTICULARS VARCHAR(255),
TXN_TYPE_CID VARCHAR(6) NOT NULL,
CLIENT_ID INTEGER NOT NULL,
AGENT_ID INTEGER NOT NULL,
TOWN_ID INTEGER,
LASTCHANGED TIMESTAMP);

CREATE TABLE TXN_DETAIL(TXN_DETAIL_ID INTEGER NOT NULL,
TXN_ID INTEGER NOT NULL,
PRODUCT_ID INTEGER NOT NULL,
QTYIN NUMERIC(18,2),
QTYOUT NUMERIC(18,2),
COST_UNIT NUMERIC(18,2),
COST_TOTAL NUMERIC(18,2),
PRICE_UNIT NUMERIC(18,2),
PRICE_TOTAL NUMERIC(18,2));

CREATE TABLE TXN_TYPE(TXN_TYPE_CID VARCHAR(6) NOT NULL,
TYPE_NAME VARCHAR(20) NOT NULL,
DIRECTION SMALLINT DEFAULT 0 NOT NULL);

/* INTEG_38 */
ALTER TABLE AGENT ADD PRIMARY KEY (AGENT_ID);

/* PK_CLIENT */
ALTER TABLE CLIENT ADD CONSTRAINT PK_CLIENT PRIMARY KEY (CLIENT_ID);

/* PK_CLIENT_GROUP */
ALTER TABLE CLIENT_GROUP ADD CONSTRAINT PK_CLIENT_GROUP PRIMARY KEY (CLIENT_GROUP_ID);

/* PK_COLLECTION_0 */
ALTER TABLE COLLECTION ADD CONSTRAINT PK_COLLECTION_0 PRIMARY KEY (COL_ID);

/* PK_COLLECTION_DETAIL_0 */
ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT PK_COLLECTION_DETAIL_0 PRIMARY KEY (COL_DETAIL_ID);

/* PK_PRODUCT */
ALTER TABLE PRODUCT ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_ID);

/* PK_PRODUCT_TYPE */
ALTER TABLE PRODUCT_TYPE ADD CONSTRAINT PK_PRODUCT_TYPE PRIMARY KEY (PRODUCT_TYPE_ID);

/* PK_SALES_CREDIT_0 */
ALTER TABLE SALES_CREDIT ADD CONSTRAINT PK_SALES_CREDIT_0 PRIMARY KEY (SALES_CR_ID);

/* PK_SALES_CREDIT_LINES_0 */
ALTER TABLE SALES_CREDIT_LINES ADD CONSTRAINT PK_SALES_CREDIT_LINES_0 PRIMARY KEY (SALES_CR_LINES_ID);

/* PK_TOWN_0 */
ALTER TABLE TOWN ADD CONSTRAINT PK_TOWN_0 PRIMARY KEY (TOWN_ID);

/* PK_TXN */
ALTER TABLE TXN ADD CONSTRAINT PK_TXN PRIMARY KEY (TXN_ID);

/* PK_TXN_DETAIL */
ALTER TABLE TXN_DETAIL ADD CONSTRAINT PK_TXN_DETAIL PRIMARY KEY (TXN_DETAIL_ID);

/* PK_TXN_TYPE */
ALTER TABLE TXN_TYPE ADD CONSTRAINT PK_TXN_TYPE PRIMARY KEY (TXN_TYPE_CID);

/* UNQ_AGENT_1 */
ALTER TABLE AGENT ADD CONSTRAINT UNQ_AGENT_1 UNIQUE (AGENT_NAME);

/* UNQ_PRODUCT_0 */
ALTER TABLE PRODUCT ADD CONSTRAINT UNQ_PRODUCT_0 UNIQUE (PRODUCT_NAME);

/* UNQ_TOWN_LOCATION */
ALTER TABLE TOWN ADD CONSTRAINT UNQ_TOWN_LOCATION UNIQUE (TOWN, PROVINCE);

/* UNQ_TXN_TXN_NUMBER */
ALTER TABLE TXN ADD CONSTRAINT UNQ_TXN_TXN_NUMBER UNIQUE (TXN_NUMBER);

/* UNQ1_CLIENT_GROUP */
ALTER TABLE CLIENT_GROUP ADD CONSTRAINT UNQ1_CLIENT_GROUP UNIQUE (GROUP_NAME);

/* UNQ1_PRODUCT_TYPE */
ALTER TABLE PRODUCT_TYPE ADD CONSTRAINT UNQ1_PRODUCT_TYPE UNIQUE (TYPE_NAME);

/* FK_CLIENT_0 */
ALTER TABLE CLIENT ADD CONSTRAINT FK_CLIENT_0 FOREIGN KEY (TOWN_ID) REFERENCES TOWN (TOWN_ID) ON UPDATE CASCADE;

/* FK_COLLECTION_0 */
ALTER TABLE COLLECTION ADD CONSTRAINT FK_COLLECTION_0 FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;

/* FK_COLLECTION_DETAIL_0 */
ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT FK_COLLECTION_DETAIL_0 FOREIGN KEY (COL_ID) REFERENCES COLLECTION (COL_ID) ON UPDATE CASCADE ON DELETE CASCADE;

/* FK_COLLECTION_DETAIL_1 */
ALTER TABLE COLLECTION_DETAIL ADD CONSTRAINT FK_COLLECTION_DETAIL_1 FOREIGN KEY (TXN_NUMBER) REFERENCES TXN (TXN_NUMBER) ON UPDATE CASCADE;

/* FK_PRODUCT_1 */
ALTER TABLE PRODUCT ADD CONSTRAINT FK_PRODUCT_1 FOREIGN KEY (PRODUCT_TYPE_ID) REFERENCES PRODUCT_TYPE (PRODUCT_TYPE_ID) ON UPDATE CASCADE;

/* FK_SALES_CREDIT_0 */
ALTER TABLE SALES_CREDIT ADD CONSTRAINT FK_SALES_CREDIT_0 FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;

/* FK_SALES_CREDIT_LINES_0 */
ALTER TABLE SALES_CREDIT_LINES ADD CONSTRAINT FK_SALES_CREDIT_LINES_0 FOREIGN KEY (SALES_CR_ID) REFERENCES SALES_CREDIT (SALES_CR_ID) ON UPDATE CASCADE;

/* FK_SALES_CREDIT_LINES_1 */
ALTER TABLE SALES_CREDIT_LINES ADD CONSTRAINT FK_SALES_CREDIT_LINES_1 FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ON UPDATE CASCADE;

/* FK_TXN_1 */
ALTER TABLE TXN ADD CONSTRAINT FK_TXN_1 FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) ON UPDATE CASCADE;

/* FK_TXN_2 */
ALTER TABLE TXN ADD CONSTRAINT FK_TXN_2 FOREIGN KEY (TXN_TYPE_CID) REFERENCES TXN_TYPE (TXN_TYPE_CID) ON UPDATE CASCADE;

/* FK_TXN_DETAIL_1 */
ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_1 FOREIGN KEY (TXN_ID) REFERENCES TXN (TXN_ID) ON UPDATE CASCADE ON DELETE CASCADE;

/* FK_TXN_DETAIL_2 */
ALTER TABLE TXN_DETAIL ADD CONSTRAINT FK_TXN_DETAIL_2 FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ON UPDATE CASCADE;

/* CHK_CLIENT_TYPE */
ALTER TABLE CLIENT ADD CONSTRAINT CHK_CLIENT_TYPE CHECK(CLIENT_TYPE in ('CU','SR','DI','CO'));

/* CHK_COLLECTION_0 */
ALTER TABLE COLLECTION ADD CONSTRAINT CHK_COLLECTION_0 CHECK(col_type IN ('CAS','AFF','DIS'));

/* CHK_TOWN_ATLEASTONE */
ALTER TABLE TOWN ADD CONSTRAINT CHK_TOWN_ATLEASTONE CHECK((TOWN IS NOT NULL) OR (PROVINCE IS NOT NULL));

CREATE EXCEPTION NO_DELETE_DATA_IN_USE 'Can''t delete; data in use.';

CREATE EXCEPTION NO_DELETE_SYSTEM_DATA 'Cannot change or delete system data.';


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

CREATE VIEW VW_PAYMENTS(
TXN_NUMBER,
TXN_AMOUNT,
CASH,
AFFIDAVIT,
DISCOUNT,
RETURN)
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

CREATE VIEW VW_PRODUCTION(
TXN_PERIOD,
TXN_ID,
TXN_DATE,
TXN_NUMBER,
TXN_AMOUNT,
TXN_DOWNPAYMENT,
TXN_BALANCE,
CLIENT_NAME,
STREET_ADDRESS,
ADDRESS,
TOWN,
PROVINCE,
SALES_REP,
TXN_DETAIL_ID,
PRODUCT_ID,
PRODUCTNAME,
QTYOUT)
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

SET TERM ^ ;

CREATE PROCEDURE SEL_CLIENT RETURNS(CLIENT_ID INTEGER,
CLIENT_NAME VARCHAR(40),
STREET_ADDRESS VARCHAR(40),
ADDRESS VARCHAR(40),
TOWN_ID INTEGER,
PHONE VARCHAR(60),
AGENT_ID INTEGER,
CLIENT_TYPE CHAR(2),
COMPLETEADDRESS VARCHAR(121),
TOWNPROVINCE VARCHAR(81),
CLIENTTYPEDESC VARCHAR(40),
AGENTNAME VARCHAR(20))
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
END
^

CREATE PROCEDURE SEL_COLLECTION(P_START_DATE DATE,
P_END_DATE DATE,
P_CLIENT_ID INTEGER,
P_COLLECTOR_ID INTEGER,
P_COL_TYPE CHAR(3),
P_COL_NUMBER VARCHAR(15),
P_UNAPPLIEDONLY INTEGER)
 RETURNS(COL_ID INTEGER,
COL_NUMBER VARCHAR(15),
COL_DATE DATE,
COL_TYPE CHAR(3),
COL_REF VARCHAR(15),
COL_AMOUNT NUMERIC(15,2),
COL_AMOUNTAPPLIED NUMERIC(15,2),
COL_DESCRIPTION VARCHAR(50),
CLIENT_ID INTEGER,
AGENT_ID INTEGER,
COLLECTOR_ID INTEGER,
PMT_REF VARCHAR(15),
PMT_TYPE VARCHAR(15),
CLIENTNAME VARCHAR(40),
COLLECTORNAME VARCHAR(40),
UNAPPLIEDAMOUNT NUMERIC(15))
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
END
^

CREATE PROCEDURE SEL_INVOICE RETURNS(TXN_ID INTEGER,
TXN_NUMBER VARCHAR(15),
TXN_DATE DATE,
TXN_PERIOD VARCHAR(10),
TXN_DAYSDUE SMALLINT,
TXN_DUEDATE DATE,
TXN_AMOUNT NUMERIC(15,2),
TXN_DOWNPAYMENT NUMERIC(15,2),
TXN_AMOUNTPAID NUMERIC(15,2),
SALESCREDIT NUMERIC(15,2),
TXN_PARTICULARS VARCHAR(255),
TXN_TYPE_CID VARCHAR(6),
CLIENT_ID INTEGER,
AGENT_ID INTEGER,
TOWN_ID INTEGER,
CLIENTNAME VARCHAR(40),
AGENTNAME VARCHAR(40),
TOWNPROVINCE VARCHAR(82))
 AS
BEGIN
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
        SUSPEND;
    END
END
^

CREATE PROCEDURE SEL_SALES_CREDIT(P_START_DATE DATE,
P_END_DATE DATE,
P_CLIENT_ID INTEGER,
P_SALES_CR_NUMBER VARCHAR(15))
 RETURNS(SALES_CR_ID INTEGER,
SALES_CR_NUMBER VARCHAR(15),
SALES_CR_DATE DATE,
SALES_CR_AMOUNT NUMERIC(15,2),
CLIENT_ID INTEGER,
CLIENTNAME VARCHAR(40))
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
END
^

CREATE PROCEDURE SEL_SALES_CREDIT_LINES RETURNS(SALES_CR_LINES_ID INTEGER,
SALES_CR_ID INTEGER,
PRODUCT_ID INTEGER,
PRODUCTNAME VARCHAR(40),
QTY NUMERIC(18,2),
SALES_DOC_NO VARCHAR(15),
COST_UNIT NUMERIC(18,2),
COST_TOTAL NUMERIC(18,2),
PRICE_UNIT NUMERIC(18,2),
PRICETOTAL NUMERIC(18,2))
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
END
^

CREATE PROCEDURE SEL_UNPAID_INVOICES RETURNS(TXN_NUMBER VARCHAR(15),
TXN_DATE DATE,
TXN_AMOUNT NUMERIC(15,2),
TXN_AMOUNTPAID NUMERIC(15,2),
TXN_DOWNPAYMENT NUMERIC(15,2),
CLIENT_ID INTEGER,
TXN_TYPE_CID DM_CID,
AGENT_ID INTEGER)
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
END
^

CREATE PROCEDURE SP_TXN RETURNS(TXN_NUMBER VARCHAR(15),
TXN_DATE DATE,
TXN_AMOUNT NUMERIC(15,2),
TXN_AMOUNTPAID NUMERIC(15,2),
TXN_DOWNPAYMENT NUMERIC(15,2),
CLIENT_ID INTEGER,
TXN_TYPE_CID DM_CID,
AGENT_ID INTEGER)
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
END
^

CREATE PROCEDURE SP_TXN_BALANCES(PERIOD_BATCH VARCHAR(10),
A_PRODUCT_ID INTEGER,
A_PROVINCE VARCHAR(40))
 RETURNS(TXN_PERIOD VARCHAR(10),
TXN_ID INTEGER,
TXN_DATE DATE,
TXN_NUMBER VARCHAR(15),
TXN_AMOUNT NUMERIC(15,2),
PAYMENTS NUMERIC(15,2),
BALANCE NUMERIC(15,2),
CLIENT_NAME VARCHAR(40),
STREET_ADDRESS VARCHAR(40),
ADDRESS VARCHAR(40),
TOWN VARCHAR(40),
PROVINCE VARCHAR(40),
SALES_REP VARCHAR(40),
TXN_DETAIL_ID INTEGER,
PRODUCT_ID INTEGER,
PRODUCTNAME VARCHAR(40),
QTYOUT NUMERIC(18,2))
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
END
^

CREATE PROCEDURE SP_TXN_BALANCES_BYSR(PERIOD_BATCH VARCHAR(10),
A_PRODUCT_ID INTEGER,
A_PROVINCE VARCHAR(40))
 RETURNS(TXN_PERIOD VARCHAR(10),
TXN_ID INTEGER,
TXN_DATE DATE,
TXN_NUMBER VARCHAR(15),
TXN_AMOUNT NUMERIC(15,2),
PAYMENTS NUMERIC(15,2),
BALANCE NUMERIC(15,2),
CLIENT_NAME VARCHAR(40),
STREET_ADDRESS VARCHAR(40),
ADDRESS VARCHAR(40),
TOWN VARCHAR(40),
PROVINCE VARCHAR(40),
SALES_REP VARCHAR(40),
TXN_DETAIL_ID INTEGER,
PRODUCT_ID INTEGER,
PRODUCTNAME VARCHAR(40),
QTYOUT NUMERIC(18,2))
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
END
^

CREATE PROCEDURE SP_TXN_CUS_STATEMENT(CLIENT_ID INTEGER)
 RETURNS(TXN_TYPE CHAR(3),
TXN_NUMBER VARCHAR(10),
TXN_DATE DATE,
TXN_CHARGES NUMERIC(18,2),
TXN_PAYMENT NUMERIC(18,2),
TXN_RETURNS NUMERIC(18,2),
TXN_AFFIDAVIT NUMERIC(18,2),
TXN_DISCOUNT NUMERIC(18,2),
RUN_TOTAL NUMERIC(18,2))
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
      
END
^

CREATE PROCEDURE SP_TXN_INV_OVERDUE(ASOFDATE DATE)
 RETURNS(TXN_NUMBER VARCHAR(15),
TXN_DATE DATE,
TXN_DUEDATE DATE,
TXN_AMOUNT NUMERIC(15,2),
TXN_AMOUNTPAID NUMERIC(15,2),
CLIENT_ID INTEGER,
CLIENT_NAME VARCHAR(40),
DAYS_OVERDUE INTEGER,
BALANCE NUMERIC(15,2),
AGE INTEGER)
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
END
^

CREATE PROCEDURE SP_TXN_PROD_SUMM_BYSR(APERIOD VARCHAR(10),
PRODUCT_ID INTEGER)
 RETURNS(AGENT_ID INTEGER,
SALES_REP_NAME VARCHAR(40),
PROVINCE VARCHAR(40),
TOWN VARCHAR(40),
QTY INTEGER,
INVAMT NUMERIC(15,2),
DOWNPMT NUMERIC(15,2),
BALANCE NUMERIC(15,2))
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
END
^

CREATE PROCEDURE SP_TXN_PROD_SUMM_BYTEAM(APERIOD VARCHAR(10),
PRODUCT_ID INTEGER)
 RETURNS(PROVINCE VARCHAR(40),
TOWN VARCHAR(40),
QTY INTEGER,
INVAMT NUMERIC(15,2),
DOWNPMT NUMERIC(15,2),
BALANCE NUMERIC(15,2),
PERIOD VARCHAR(10))
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
END
^

CREATE PROCEDURE SP_TXN_PRODUCTION(PERIOD_BATCH VARCHAR(10),
A_PRODUCT_ID INTEGER)
 RETURNS(TXN_PERIOD VARCHAR(10),
TXN_ID INTEGER,
TXN_DATE DATE,
TXN_NUMBER VARCHAR(15),
TXN_AMOUNT NUMERIC(15,2),
TXN_DOWNPAYMENT NUMERIC(15,2),
TXN_BALANCE NUMERIC(15,2),
CLIENT_NAME VARCHAR(40),
STREET_ADDRESS VARCHAR(40),
ADDRESS VARCHAR(40),
TOWN VARCHAR(40),
PROVINCE VARCHAR(40),
SALES_REP VARCHAR(40),
TXN_DETAIL_ID INTEGER,
PRODUCT_ID INTEGER,
PRODUCTNAME VARCHAR(40),
QTYOUT NUMERIC(18,2))
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
END
^

CREATE PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD(PERIOD VARCHAR(10),
PRODUCT_ID INTEGER)
 RETURNS(AGENT_ID INTEGER,
SALES_REP_NAME VARCHAR(40),
PROVINCE VARCHAR(40),
TOWN VARCHAR(40),
QTY INTEGER,
INVAMT NUMERIC(15,2),
DOWNPMT NUMERIC(15,2),
BALANCE NUMERIC(15,2))
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
END
^

SET TERM ; ^

SET TERM ^ ;

CREATE TRIGGER AGENT_BI FOR AGENT
ACTIVE BEFORE INSERT POSITION 0 
AS
BEGIN
  IF ((NEW.AGENT_ID IS NULL) OR (NEW.AGENT_ID < 0)) THEN
    NEW.AGENT_ID = GEN_ID(GEN_AGENT_ID,1);
END
^

CREATE TRIGGER AGENT_BUD0 FOR AGENT
ACTIVE BEFORE UPDATE OR DELETE POSITION 0 
AS 
BEGIN 
  if (OLD.AGENT_ID = 0) then
    exception no_delete_system_data; 
END
^

CREATE TRIGGER CLIENT_BD_SALESREP FOR CLIENT
ACTIVE BEFORE DELETE POSITION 0 
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
    
END
^

COMMENT ON TRIGGER CLIENT_BD_SALESREP IS
'AGENT_ID and COLLECTOR_ID are not covered by Foreign Keys'
^

CREATE TRIGGER CLIENT_BI FOR CLIENT
ACTIVE BEFORE INSERT POSITION 0 
as
begin
  if ((new.client_id is null) or (new.client_id < 0))  then
    new.client_id = gen_id(gen_client_id,1);
end
^

CREATE TRIGGER CLIENT_BIUD FOR CLIENT
ACTIVE BEFORE INSERT OR UPDATE OR DELETE POSITION 0 
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
END
^

CREATE TRIGGER CLIENT_GROUP_BI FOR CLIENT_GROUP
ACTIVE BEFORE INSERT POSITION 0 
as
begin
  if ((new.client_group_id is null) or (NEW.CLIENT_GROUP_ID < 0))  then
    new.client_group_id = gen_id(gen_client_group_id,1);
end
^

CREATE TRIGGER CLIENT_GROUP_BUD0 FOR CLIENT_GROUP
ACTIVE BEFORE UPDATE OR DELETE POSITION 0 
AS
begin
  if (OLD.client_group_id = 0) then
    exception no_delete_system_data;
end
^

CREATE TRIGGER COLLECTION_DETAIL_BID FOR COLLECTION_DETAIL
ACTIVE BEFORE INSERT OR DELETE POSITION 0 
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
END
^

CREATE TRIGGER PRODUCT_BI FOR PRODUCT
ACTIVE BEFORE INSERT POSITION 0 
as
begin
  if ((new.product_id is null) or (NEW.product_id < 0))  then
    new.product_id = gen_id(gen_product_id,1);
end
^

CREATE TRIGGER PRODUCT_TYPE_BI FOR PRODUCT_TYPE
ACTIVE BEFORE INSERT POSITION 0 
AS
BEGIN
  IF ((NEW.PRODUCT_TYPE_ID IS NULL) or (new.PRODUCT_TYPE_ID < 0)) THEN
    NEW.PRODUCT_TYPE_ID = GEN_ID(GEN_PRODUCT_TYPE_ID,1);
END
^

CREATE TRIGGER PRODUCT_TYPE_BUD0 FOR PRODUCT_TYPE
ACTIVE BEFORE UPDATE OR DELETE POSITION 0 
AS
begin
  if (old.PRODUCT_TYPE_ID = 0) then
    exception no_delete_system_data;
end
^

CREATE TRIGGER TOWN_BIUD FOR TOWN
ACTIVE BEFORE INSERT OR UPDATE OR DELETE POSITION 0 
AS
declare x integer;
BEGIN
      x = gen_id(VER_TOWN,1);
END
^

CREATE TRIGGER TXN_BI FOR TXN
ACTIVE BEFORE INSERT POSITION 0 
as
begin
  if ((new.TXN_id is null) or (NEW.TXN_id < 0))  then
    new.TXN_id = gen_id(gen_txn_id,1);
end
^

CREATE TRIGGER TXN_BIU FOR TXN
ACTIVE BEFORE INSERT OR UPDATE POSITION 0 
AS
BEGIN
  NEW.LASTCHANGED = 'NOW';
END
^

CREATE TRIGGER TXN_DETAIL_BI FOR TXN_DETAIL
ACTIVE BEFORE INSERT POSITION 0 
as
begin
  if ((new.txn_detail_id is null) or (NEW.txn_detail_id <0))  then
    new.txn_detail_id = gen_id(gen_txn_detail_id,1);
end
^

CREATE TRIGGER TXN_DETAIL_BIUD FOR TXN_DETAIL
ACTIVE BEFORE INSERT OR UPDATE OR DELETE POSITION 0 
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



GRANT SELECT ON RDB$FORMATS TO PUBLIC;
GRANT SELECT ON RDB$PAGES TO PUBLIC;
GRANT SELECT ON RDB$ROLES TO PUBLIC;


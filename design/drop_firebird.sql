/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v6.0.0                     */
/* Target DBMS:           Firebird 2                                      */
/* Project file:          Project1.dez                                    */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2014-08-17 22:59                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop triggers                                                          */
/* ---------------------------------------------------------------------- */

DROP TRIGGER AGENT_BI;

DROP TRIGGER AGENT_BUD0;

DROP TRIGGER CLIENT_BI;

DROP TRIGGER CLIENT_BD_SALESREP;

DROP TRIGGER CLIENT_BIUD;

DROP TRIGGER CLIENT_GROUP_BI;

DROP TRIGGER CLIENT_GROUP_BUD0;

DROP TRIGGER COLLECTION_DETAIL_BID;

DROP TRIGGER PRODUCT_BI;

DROP TRIGGER PRODUCT_TYPE_BI;

DROP TRIGGER PRODUCT_TYPE_BUD0;

DROP TRIGGER TOWN_BIUD;

DROP TRIGGER TXN_BI;

DROP TRIGGER TXN_BIU;

DROP TRIGGER TXN_DETAIL_BI;

DROP TRIGGER TXN_DETAIL_BIUD;

/* ---------------------------------------------------------------------- */
/* Drop procedures                                                        */
/* ---------------------------------------------------------------------- */

DROP PROCEDURE SP_TXN_INV_OVERDUE;

DROP PROCEDURE SP_TXN_PRODUCTION;

DROP PROCEDURE SP_TXN_BALANCES;

DROP PROCEDURE SP_TXN_CUS_STATEMENT;

DROP PROCEDURE SEL_COLLECTION;

DROP PROCEDURE SP_TXN_BALANCES_BYSR;

DROP PROCEDURE SEL_CLIENT;

DROP PROCEDURE SEL_SALES_CREDIT;

DROP PROCEDURE SEL_INVOICE;

DROP PROCEDURE SEL_UNPAID_INVOICES;

DROP PROCEDURE SP_TXN_PRODUCTION_SUMMARY_OLD;

DROP PROCEDURE SEL_SALES_CREDIT_LINES;

DROP PROCEDURE SEL_INVOICE_DETAIL;

DROP PROCEDURE SP_TXN_PROD_SUMM_BYTEAM;

DROP PROCEDURE SP_TXN_PROD_SUMM_BYSR;

/* ---------------------------------------------------------------------- */
/* Drop views                                                             */
/* ---------------------------------------------------------------------- */

DROP VIEW VW_PRODUCTION;

DROP VIEW VW_PAYMENTS;

/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE CLIENT DROP CONSTRAINT FK_CLIENT_0;

ALTER TABLE COLLECTION DROP CONSTRAINT FK_COLLECTION_0;

ALTER TABLE COLLECTION_DETAIL DROP CONSTRAINT FK_COLLECTION_DETAIL_0;

ALTER TABLE COLLECTION_DETAIL DROP CONSTRAINT FK_COLLECTION_DETAIL_1;

ALTER TABLE PRODUCT DROP CONSTRAINT FK_PRODUCT_1;

ALTER TABLE SALES_CREDIT DROP CONSTRAINT FK_SALES_CREDIT_0;

ALTER TABLE SALES_CREDIT_LINES DROP CONSTRAINT FK_SALES_CREDIT_LINES_0;

ALTER TABLE SALES_CREDIT_LINES DROP CONSTRAINT FK_SALES_CREDIT_LINES_1;

ALTER TABLE TXN DROP CONSTRAINT FK_TXN_2;

ALTER TABLE TXN DROP CONSTRAINT FK_TXN_1;

ALTER TABLE TXN_DETAIL DROP CONSTRAINT FK_TXN_DETAIL_1;

ALTER TABLE TXN_DETAIL DROP CONSTRAINT FK_TXN_DETAIL_2;

/* ---------------------------------------------------------------------- */
/* Drop table "COLLECTION_DETAIL"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE COLLECTION_DETAIL DROP CONSTRAINT PK_COLLECTION_DETAIL_0;

/* Drop table */

DROP TABLE COLLECTION_DETAIL;

/* ---------------------------------------------------------------------- */
/* Drop table "TXN_DETAIL"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE TXN_DETAIL DROP CONSTRAINT PK_TXN_DETAIL;

/* Drop table */

DROP TABLE TXN_DETAIL;

/* ---------------------------------------------------------------------- */
/* Drop table "TXN"                                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE TXN DROP CONSTRAINT PK_TXN;

/* Drop table */

DROP TABLE TXN;

/* ---------------------------------------------------------------------- */
/* Drop table "SALES_CREDIT_LINES"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE SALES_CREDIT_LINES DROP CONSTRAINT PK_SALES_CREDIT_LINES_0;

/* Drop table */

DROP TABLE SALES_CREDIT_LINES;

/* ---------------------------------------------------------------------- */
/* Drop table "SALES_CREDIT"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE SALES_CREDIT DROP CONSTRAINT PK_SALES_CREDIT_0;

/* Drop table */

DROP TABLE SALES_CREDIT;

/* ---------------------------------------------------------------------- */
/* Drop table "PRODUCT"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE PRODUCT DROP CONSTRAINT PK_PRODUCT;

/* Drop table */

DROP TABLE PRODUCT;

/* ---------------------------------------------------------------------- */
/* Drop table "COLLECTION"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE COLLECTION DROP CONSTRAINT PK_COLLECTION_0;

ALTER TABLE COLLECTION DROP CONSTRAINT CHK_COLLECTION_0;

/* Drop table */

DROP TABLE COLLECTION;

/* ---------------------------------------------------------------------- */
/* Drop table "CLIENT"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE CLIENT DROP CONSTRAINT PK_CLIENT;

ALTER TABLE CLIENT DROP CONSTRAINT CHK_CLIENT_TYPE;

/* Drop table */

DROP TABLE CLIENT;

/* ---------------------------------------------------------------------- */
/* Drop table "TXN_TYPE"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE TXN_TYPE DROP CONSTRAINT PK_TXN_TYPE;

/* Drop table */

DROP TABLE TXN_TYPE;

/* ---------------------------------------------------------------------- */
/* Drop table "TXN_MD_GTT"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

/* Drop table */

DROP TABLE TXN_MD_GTT;

/* ---------------------------------------------------------------------- */
/* Drop table "TOWN"                                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE TOWN DROP CONSTRAINT PK_TOWN_0;

ALTER TABLE TOWN DROP CONSTRAINT CHK_TOWN_ATLEASTONE;

/* Drop table */

DROP TABLE TOWN;

/* ---------------------------------------------------------------------- */
/* Drop table "SALES_CREDIT_MD_GTT"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

/* Drop table */

DROP TABLE SALES_CREDIT_MD_GTT;

/* ---------------------------------------------------------------------- */
/* Drop table "PRODUCT_TYPE"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE PRODUCT_TYPE DROP CONSTRAINT PK_PRODUCT_TYPE;

/* Drop table */

DROP TABLE PRODUCT_TYPE;

/* ---------------------------------------------------------------------- */
/* Drop table "COLLECTION_MD_GTT"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

/* Drop table */

DROP TABLE COLLECTION_MD_GTT;

/* ---------------------------------------------------------------------- */
/* Drop table "CLIENT_GROUP"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE CLIENT_GROUP DROP CONSTRAINT PK_CLIENT_GROUP;

/* Drop table */

DROP TABLE CLIENT_GROUP;

/* ---------------------------------------------------------------------- */
/* Drop table "AGENT"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE AGENT DROP CONSTRAINT INTEG_38;

/* Drop table */

DROP TABLE AGENT;

/* ---------------------------------------------------------------------- */
/* Drop domains                                                           */
/* ---------------------------------------------------------------------- */

DROP DOMAIN DM_MONEY;

DROP DOMAIN DM_CID_PK;

DROP DOMAIN DM_ID_PK;

DROP DOMAIN DM_CID;

DROP DOMAIN DM_ID;

/* ---------------------------------------------------------------------- */
/* Drop sequences                                                         */
/* ---------------------------------------------------------------------- */

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_CLIENT_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_PRODUCT_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_TXN_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_TXN_DETAIL_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_HIGHVALUE_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_PRODUCT_TYPE_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_AGENT_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'GEN_CLIENT_GROUP_ID';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'VER_CLIENT';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'VER_SALESREP';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'VER_TOWN';

DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'VER_COLLECTOR';

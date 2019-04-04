[cus_OutstandingInvoices_byDaysOverdue]
select
*
from SP_TXN_INV_OVERDUE({ASOFDATE_INVBAL})
order by AGE, TXN_DATE, TXN_NUMBER

[cus_OutstandingInvoices_byCustomer]
select *
from SP_TXN_INV_OVERDUE({ASOFDATE_INVBAL})
order by CLIENT_NAME, TXN_DATE, TXN_NUMBER

[cus_InvoiceSummary]
select TXN_DATE
, TXN_NUMBER
, TXN_AMOUNT
, TXN_PARTICULARS
, (TXN_AMOUNT-TXN_DOWNPAYMENT-TXN_AMOUNTPAID) TXN_BALANCE
, t.CLIENT_ID
, (select c.CLIENT_NAME from CLIENT c 
   where c.CLIENT_ID = t.CLIENT_ID) CLIENT_NAME
from TXN t
where TXN_DATE between {FROMDATE} and {TODATE}
order by 6, TXN_DATE

[cus_Balances]
select 
c.client_id
, c.CLIENT_NAME
, C.ADDRESS||' '||t.TOWN_PROVINCE AS ADDRESS
, c.PHONE
, inv.amt - INV.DOWNPMT as Invoices
, pmt.amt as Payments  
, ret.AMT as "Returns" 
from CLIENT c
join TOWN t on t.TOWN_ID=c.TOWN_ID
join (select client_id, sum(txn_amount) amt, sum(txn_downpayment) downpmt
        from (select client_id, txn_amount, txn_downpayment
               from txn where txn_date <= {ASOFDATE} 
              union all select client_id, 0, 0 from client )
       group by client_id
     ) Inv on inv.client_id = c.client_id 
join (select client_id, sum(COL_AMOUNT) amt 
        from (select client_id, col_amount
                from collection where col_date <= {ASOFDATE}
               union all select client_id, 0 from client )
       group by client_id
      ) pmt on pmt.client_id = c.client_id  
join (select client_id, sum(SALES_CR_AMOUNT) AMT
        from (select client_id, sales_cr_amount
                from SALES_CREDIT where sales_cr_date <= {ASOFDATE}
               union all select client_id, 0 from client )
       group by client_id
      ) RET on ret.client_id = c.client_id        
order by 2

[cus_Balances_where]
select 
c.client_id
, c.CLIENT_NAME
, C.ADDRESS||' '||t.TOWN_PROVINCE AS ADDRESS
, c.PHONE
, inv.amt - INV.DOWNPMT as Invoices
, pmt.amt as Payments   
, ret.AMT as "Returns"
from CLIENT c
join TOWN t on t.TOWN_ID=c.TOWN_ID
join (select client_id, sum(txn_amount) amt, sum(txn_downpayment) downpmt
        from (select client_id, txn_amount, txn_downpayment
               from txn where txn_date <= {ASOFDATE} 
              union all select client_id, 0, 0 from client )
       group by client_id
     ) Inv on inv.client_id = c.client_id 
join (select client_id, sum(COL_AMOUNT) amt 
        from (select client_id, col_amount
                from collection where col_date <= {ASOFDATE}
               union all select client_id, 0 from client )
       group by client_id
      ) pmt on pmt.client_id = c.client_id 
join (select client_id, sum(SALES_CR_AMOUNT) AMT
        from (select client_id, sales_cr_amount
                from SALES_CREDIT where sales_cr_date <= {ASOFDATE}
               union all select client_id, 0 from client )
       group by client_id
      ) RET on ret.client_id = c.client_id       


[prod_Daily]
select * 
  from sp_txn_production('{PERIOD}','{PRODUCTID}')
 order by TXN_PERIOD, TXN_ID, TXN_DETAIL_ID

[prod_Daily_ByTown]
select * 
  from sp_txn_production('{PERIOD}','{PRODUCTID}')
 where TXN_BALANCE <> 0
 order by PROVINCE, TOWN, ADDRESS, STREET_ADDRESS, TXN_ID, TXN_DETAIL_ID
 
[prod_Collectors_Reference]
select * 
  from sp_txn_balances('{PERIOD}','{PRODUCTID}','{PROVINCE}')
 order by PROVINCE, TOWN, ADDRESS, STREET_ADDRESS, TXN_ID, TXN_DETAIL_ID
 
[prod_Collectors_Reference_bySR]
select * 
  from sp_txn_balances_bysr('{PERIOD}','{PRODUCTID}','{PROVINCE}')
 order by PROVINCE, TOWN, ADDRESS, STREET_ADDRESS, TXN_ID, TXN_DETAIL_ID
  
[prod_Summary]
select *
from sp_txn_prod_summ_bysr('{PRODSUMPERIOD}','{PRODSUMPRODUCTID}')
{PRODSUMSALESREPID}

[prod_Summary_byGroup]
select PROVINCE, TOWN, QTY, INVAMT, DOWNPMT, BALANCE
from sp_txn_prod_summ_byteam('{PRODSUMPERIOD}','{PRODSUMPRODUCTID}')

[prod_Summary_Updated_byTown]
select inv.province, inv.town, QTY, new_amount, old_amount, new_amount+old_amount total_amount
from (select t.province, t.town, 
             sum(case when i.txn_period starting with '{PRODSUMPERIOD}' then 
                      Q.QTY else 0 end) qty,
             sum(case when i.txn_period starting with '{PRODSUMPERIOD}' then 
                      i.txn_amount else 0 end) new_amount,
             sum(case when i.txn_period < '{PRODSUMPERIOD}' then 
                      i.txn_amount-p.CASH-p.AFFIDAVIT-p.DISCOUNT-p."RETURN" else 0 end) old_amount
       from town t 
       join txn i on i.TOWN_ID=t.TOWN_ID
       join VW_PAYMENTS p on p.TXN_NUMBER=i.TXN_NUMBER
       join ( select qm.TXN_NUMBER, sum(QTYOUT) QTY 
                from TXN_DETAIL qd 
                join TXN qm on qm.TXN_ID=qd.TXN_ID
               where PRODUCT_ID = {PRODSUMPRODUCTID}  
               group by 1 ) q on q.TXN_NUMBER = i.TXN_NUMBER 
       group by t.PROVINCE, t.TOWN
      ) inv
{PRODSUMMPROVINCE}

[prod_Summary_Updated_byTown_OLD**********************]
select inv.province, inv.town, new_amount, old_amount, new_amount+old_amount total_amount
from (select t.province, t.town, 
             sum(case when i.txn_period starting with '{PRODSUMPERIOD}' then 
                      i.txn_amount else 0 end) new_amount,
             sum(case when i.txn_period < '{PRODSUMPERIOD}' then 
                      i.txn_amount-i.TXN_DOWNPAYMENT-i.TXN_AMOUNTPAID else 0 end) old_amount
        from town t 
        join txn i on i.TOWN_ID=t.TOWN_ID
       group by t.PROVINCE, t.TOWN
      ) inv

[prod_Summary_Updated_bySR]
select inv.AGENT_ID, inv.AgentName, inv.province, inv.town, QTY, new_amount, old_amount, new_amount+old_amount total_amount
from (select i.agent_id, t.province, t.town, max(c.CLIENT_NAME) AgentName,
             sum(case when i.txn_period starting with '{PRODSUMPERIOD}' then 
                      Q.QTY else 0 end) qty,
             sum(case when i.txn_period starting with '{PRODSUMPERIOD}' then 
                      i.txn_amount else 0 end) new_amount,
             sum(case when i.txn_period < '{PRODSUMPERIOD}' then 
                      i.txn_amount-p.CASH-p.AFFIDAVIT-p.DISCOUNT-p."RETURN" else 0 end) old_amount
       from town t 
       join txn i on i.TOWN_ID=t.TOWN_ID
       join VW_PAYMENTS p on p.TXN_NUMBER=i.TXN_NUMBER
       join ( select qm.TXN_NUMBER, sum(QTYOUT) QTY 
                from TXN_DETAIL qd 
                join TXN qm on qm.TXN_ID=qd.TXN_ID
               group by 1  ) q on q.TXN_NUMBER = i.TXN_NUMBER
       join CLIENT c on c.CLIENT_ID =  i.AGENT_ID 
       group by i.AGENT_ID, t.PROVINCE, t.TOWN
      ) inv
{PRODSUMSALESREPID}

[cus_Statement]
SELECT *
FROM SP_TXN_CUS_STATEMENT({CLIENT_ID})

[col_Summary_bySR]
select T.AGENT_ID, max(CL.CLIENT_NAME) AgentName,
  sum( case when T.TXN_PERIOD starting with '{PERIOD}' then CD.COL_DETAIL_AMTPAID else 0 end) NewAccounts,
  sum( case when T.TXN_PERIOD < '{PERIOD}' then CD.COL_DETAIL_AMTPAID else 0 end) OldAccounts
from COLLECTION_DETAIL CD
join COLLECTION C on C.COL_ID=CD.COL_ID
join TXN T on T.TXN_NUMBER=cd.TXN_NUMBER
join CLIENT CL on CL.CLIENT_ID=T.AGENT_ID 
where C.COL_DATE between '{FROMDATE}' and '{TODATE}'
group by T.AGENT_ID
order by AgentName

[col_Summary_byTown]
select L.PROVINCE, L.TOWN, 
  sum( case when T.TXN_PERIOD starting with '{PERIOD}' then CD.COL_DETAIL_AMTPAID else 0 end) NewAccounts,
  sum( case when T.TXN_PERIOD < '{PERIOD}' then CD.COL_DETAIL_AMTPAID else 0 end) OldAccounts
from COLLECTION_DETAIL CD
join COLLECTION C on C.COL_ID=CD.COL_ID
join TXN T on T.TXN_NUMBER=cd.TXN_NUMBER
join TOWN L on L.TOWN_ID=T.TOWN_ID 
where C.COL_DATE between '{FROMDATE}' and '{TODATE}'
group by L.PROVINCE, L.TOWN

[col_Breakdown_bySR]
select AGENT_ID, AgentName, Cash, Affidavit, Discount, "Returns", Cash+Affidavit+Discount+"Returns" Total
from ( select T.AGENT_ID, max(CL.CLIENT_NAME) AgentName, 
              sum( case when DOC_TYPE='CAS' then AMOUNT else 0 end ) Cash,
              sum( case when DOC_TYPE='AFF' then AMOUNT else 0 end ) Affidavit,
              sum( case when DOC_TYPE='DIS' then AMOUNT else 0 end ) Discount,
              sum( case when DOC_TYPE='RET' then AMOUNT else 0 end ) "Returns"
         from ( select C.COL_TYPE DOC_TYPE, C.COL_DATE DOC_DATE, CD.TXN_NUMBER, CD.COL_DETAIL_AMTPAID AMOUNT
                  from COLLECTION_DETAIL CD
                  join COLLECTION C on C.COL_ID=CD.COL_ID
                  
                 union all
                select 'RET' DOC_TYPE, SC.SALES_CR_DATE DOC_DATE, SCL.SALES_DOC_NO TXN_NUMBER, SCL.QTY*SCL.PRICE_UNIT AMOUNT
                  from SALES_CREDIT_LINES SCL
                  join SALES_CREDIT SC on SC.SALES_CR_ID=SCL.SALES_CR_ID 
               ) Details
         join TXN T on T.TXN_NUMBER=Details.TXN_NUMBER
         join CLIENT CL on CL.CLIENT_ID=T.AGENT_ID 
        where DOC_DATE between '{FROMDATE}' and '{TODATE}'
        group by T.AGENT_ID
     ) Collections
order by AgentName

[col_Summary_byCollector]
select b.COLLECTOR_ID, b.COL_DATE,
  sum(case when c.TXN_PERIOD< '{PERIOD}' then a.COL_DETAIL_AMTPAID else 0 end) OLD,
  sum(case when c.TXN_PERIOD>='{PERIOD}' then a.COL_DETAIL_AMTPAID else 0 end) NEW,
  max( (select CLIENT_NAME from CLIENT p 
        where p.CLIENT_ID = b.COLLECTOR_ID 
       ) ) COLLECTORNAME
from COLLECTION_DETAIL a
join TXN c on c.TXN_NUMBER = a.TXN_NUMBER
join COLLECTION b on b.COL_ID=a.COL_ID
where b.COL_DATE between '{FROMDATE}' and '{TODATE}'
group by 1,2

[col_Summary_byProvince]
select t.PROVINCE, b.COL_DATE,
  sum(case when i.TXN_PERIOD< '{PERIOD}' then a.COL_DETAIL_AMTPAID else 0 end) OLD,
  sum(case when i.TXN_PERIOD>='{PERIOD}' then a.COL_DETAIL_AMTPAID else 0 end) NEW
from COLLECTION_DETAIL a
join COLLECTION b on b.COL_ID=a.COL_ID
join TXN i on i.TXN_NUMBER = a.TXN_NUMBER
join TOWN t on t.TOWN_ID = i.TOWN_ID
where b.COL_DATE between '{FROMDATE}' and '{TODATE}'
group by 1,2
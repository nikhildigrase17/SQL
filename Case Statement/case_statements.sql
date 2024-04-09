SELECT DISTINCT SUBMITTED_VIA FROM ND_CONSUMER_COMPLAINTS;

SELECT *,
    CASE WHEN SUBMITTED_VIA IN ('Referral', 'Postal Mail', 'Email') THEN 'Outbound'
         WHEN SUBMITTED_VIA IN ('Phone', 'Web') THEN 'Inbound'
         ELSE 'Electronics'
    END AS SUBMISSION_TYPE
FROM ND_CONSUMER_COMPLAINTS;    

SELECT DISTINCT PRODUCT_NAME FROM ND_CONSUMER_COMPLAINTS;

SELECT *,
    CASE WHEN PRODUCT_NAME LIKE '%Loan' OR PRODUCT_NAME LIKE '%loan' THEN 'Loan'
         WHEN PRODUCT_NAME IN ('Bank account or service', 'Mortgage',
                                'Debt collection','Credit card', 'Credit reporting',
                                'Money transfers', 'Prepaid card') THEN 'Service'
         ELSE 'Other financial service'
    END AS FINANCIAL_TYPE
 FROM  ND_CONSUMER_COMPLAINTS;   


SELECT DISTINCT SUB_PRODUCT FROM ND_CONSUMER_COMPLAINTS;

SELECT *,
    
        CASE
        WHEN SUB_PRODUCT = 'I do not know' OR SUB_PRODUCT is null THEN 'NA'
        WHEN UPPER(SUB_PRODUCT) LIKE '%LOAN' THEN 'LOAN'
        WHEN UPPER(SUB_PRODUCT) LIKE '%CARD' THEN 'CARD'
        WHEN UPPER(SUB_PRODUCT) LIKE '%MORTGAGE' THEN 'MORTGAGE'
        ELSE SUB_PRODUCT
        END AS SUB_PRODUCT_TYPE,
FROM  ND_CONSUMER_COMPLAINTS;       


SELECT DISTINCT COMPANY_RESPONSE_TO_CONSUMER FROM ND_CONSUMER_COMPLAINTS;
CREATE OR REPLACE VIEW ND_COMPANY_RESPONSE_TO_CONSUMER AS
SELECT DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,STATE_NAME,ZIP_CODE,SUBMITTED_VIA,


        CASE 
        WHEN PRODUCT_NAME LIKE '%Loan' OR PRODUCT_NAME LIKE '%loan' THEN 'Loan'
        WHEN PRODUCT_NAME IN ('Bank account or service', 'Mortgage',
                                'Debt collection','Credit card', 'Credit reporting',
                                'Money transfers', 'Prepaid card') THEN 'Service'
        ELSE 'Other financial service'
        END AS FINANCIAL_TYPE,

        CASE
        WHEN SUB_PRODUCT = 'I do not know' OR SUB_PRODUCT is null THEN 'NA'
        WHEN UPPER(SUB_PRODUCT) LIKE '%LOAN' THEN 'LOAN'
        WHEN UPPER(SUB_PRODUCT) LIKE '%CARD' THEN 'CARD'
        WHEN UPPER(SUB_PRODUCT) LIKE '%MORTGAGE' THEN 'MORTGAGE'
        ELSE SUB_PRODUCT
        END AS SUB_PRODUCT_TYPE,

        
        CASE
        WHEN COMPANY_RESPONSE_TO_CONSUMER = 'Closed with explanation' THEN 'Explained'
        WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed', 'Closed with non-monetary relief') THEN 'Closed'
        WHEN COMPANY_RESPONSE_TO_CONSUMER = 'Closed with monetary relief' THEN 'Monetary Relief Provided'
        ELSE 'Untimely response'
        END AS COMPANY_RESPONSE
FROM ND_CONSUMER_COMPLAINTS;

SELECT * FROM ND_COMPANY_RESPONSE_TO_CONSUMER;
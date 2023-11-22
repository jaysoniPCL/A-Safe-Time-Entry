-------------------------------------------------------------------------------------
   
create or replace PACKAGE CREDENTIALS_DETAILS_PROD AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  --'https://eqay-dev3.fa.em1.ukg.oraclecloud.com:443/idcws/GenericSoapPort'
  --'https://eqay-dev3.fa.em1.ukg.oraclecloud.com:443/hcmService/HCMDataLoader'
GP_URL VARCHAR2(128) := 'https://fa-eueq-test-saasfaprod1.fa.ocs.oraclecloud.com';
GP_USERNAME VARCHAR2(128) := 'Deep@payrollcloudcorp.com';
GP_PASSWORD VARCHAR2(128) := 'PayrollCloud@1';

END CREDENTIALS_DETAILS_PROD;
/

-------------------------------------------------------------------------------------

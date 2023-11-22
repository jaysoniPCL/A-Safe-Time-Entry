-------------------------------------------------------------------------------------


CREATE TABLE "ASAFE_TIME_ENTRY_API_INPUT_PROD" 
   (	"ID" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"CARDHOLDERID" NUMBER(38,0), 
	"EVENTTIME" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"LOCATION" VARCHAR2(128) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" ;

-------------------------------------------------------------------------------------   
   
  CREATE TABLE "ASAFE_TIME_ENTRY_RESPONSE_PROD" 
   (	"ID" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"CARDHOLDERID" NUMBER(38,0), 
	"EVENTTIME" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"LOCATION" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"STATUS_CODE" VARCHAR2(128) COLLATE "USING_NLS_COMP", 
	"REASON_PHRASE" VARCHAR2(32767) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" ;

-------------------------------------------------------------------------------------

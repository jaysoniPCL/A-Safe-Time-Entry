create or replace Procedure ASAFE_TIME_ENTRY_API_PROD as
l_json CLOB;
l_timestamp VARCHAR2(200) := TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD"T"HH24:MI:SS.FF3TZD"+00:00"');
l_http_response utl_http.resp;
l_id varchar2(32767);
l_Person_Number varchar2(32767);
l_event_time varchar2(32767);
l_location varchar2(32767);
status_code varchar2(32767);
REASON_PHRASE   varchar2(32767);
	CURSOR data_cursor IS
        SELECT ATEAI.ID, ATEAI.CARDHOLDERID, ATEAI.EVENTTIME, ATEAI.LOCATION
        FROM ASAFE_TIME_ENTRY_API_INPUT_PROD ATEAI;
BEGIN
	UTL_HTTP.SET_WALLET('');
	
    EXECUTE IMMEDIATE 'DELETE FROM ASAFE_TIME_ENTRY_RESPONSE';
    
	apex_web_service.g_request_headers(1).name := 'Content-Type';
	apex_web_service.g_request_headers(1).value := 'application/json';
	
	FOR data_row IN data_cursor LOOP
		l_id := data_row.ID;
		l_Person_Number := data_row.CARDHOLDERID;
		l_event_time := TO_CHAR(TO_DATE(data_row.EVENTTIME, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD"T"HH24:MI:SS".000+00:00"');
		l_location := data_row.LOCATION;
		
/*		
    dbms_output.put_line('l_id... '||l_id);
	dbms_output.put_line('l_Person_Number.. '||l_Person_Number);
	dbms_output.put_line('l_event_time... '||l_event_time);
	dbms_output.put_line('l_location... '||l_location);
	dbms_output.put_line('---------------------------------------------------------------------------------------');
*/		
	
	l_json := apex_web_service.make_rest_request(
					p_url            => 'https://fa-eueq-test-saasfaprod1.fa.ocs.oraclecloud.com/hcmWorkforceMgmtApi/resources/latest/timeEventRequests/',
					p_username       => CREDENTIALS_DETAILS.GP_USERNAME,	--'USERNAME'
					p_password       => CREDENTIALS_DETAILS.GP_PASSWORD,	--'PASSWORD'
					p_http_method    => 'POST',
					p_body           =>'{
									"requestNumber": "'||l_id||'",
									"sourceId": "HQ-Office",
									"requestTimestamp": "'||l_timestamp||'",
									"timeEvents": [{
										"eventDateTime": "'||l_event_time||'",
										"supplierDeviceEvent": "'||l_location||'",
										"reporterId": "'||l_Person_Number||'",
										"reporterIdType": "PERSON",
										"timeEventAttributes": [
											{
											"name": "PayrollTimeType",
											"value": "Regular Shifts Hours"
											}]
										}]
									}');
/*	
	dbms_output.put_line ('status_code : '||apex_web_service.g_status_code);
	dbms_output.put_line ('REASON_PHRASE : '||APEX_WEB_SERVICE.G_REASON_PHRASE);
	dbms_output.put_line ('detailed_sqlerrm : '||utl_http.get_detailed_sqlerrm);
	dbms_output.put_line('---------------------------------------------------------------------------------------');
*/
    status_code := (apex_web_service.g_status_code);
    REASON_PHRASE := (APEX_WEB_SERVICE.G_REASON_PHRASE);
    EXECUTE IMMEDIATE 
                  'INSERT INTO ASAFE_TIME_ENTRY_RESPONSE (ID,CARDHOLDERID,EVENTTIME,LOCATION,STATUS_CODE,REASON_PHRASE)
                  Values(:l_id,:l_Person_Number,:l_event_time,:l_location,:status_code,:REASON_PHRASE)'
                    USING l_id,l_Person_Number,l_event_time,l_location,status_code,REASON_PHRASE;
   
	END LOOP;
	
	apex_web_service.g_request_headers.delete();
	--EXECUTE IMMEDIATE 'DELETE FROM ASAFE_TIME_ENTRY_API_INPUT';
END	ASAFE_TIME_ENTRY_API_PROD;
/
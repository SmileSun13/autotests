*** Settings ***
Documentation		Проверка запроса /get
Library				../library/test_lib.py
Suite Setup			Get Response And Check Status	${OK}	Get
Resource			../resource/status.robot

*** Test Cases ***
Check Headers Are Correct
    [Template]	Check If Default Header Is Here And Correct
	Connection			keep-alive
	Content-Type		application/json

Check Headers Are Not Empty
	[Template]	Check If Default Header Is Not Empty
	Content-Length
	Date
	Server

*** Keywords ***
Check If Default Header Is Here And Correct
	[Documentation]	Проверка обязательных хедеров на корректность
	[Arguments]	${header}	${correct_value}
	Should Be Equal		${RESPONSE['headers']['${header}']}		${correct_value}

Check If Default Header Is Not Empty
	[Documentation]	Проверка обязательных хедеров на непустоту
	[Arguments]	${header}
	Should Not Be Empty		${RESPONSE['headers']['${header}']}
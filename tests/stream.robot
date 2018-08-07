*** Settings ***
Documentation		Проверка запроса /stream/:n
Library				../library/test_lib.py
Resource			../resource/status.robot

*** Test Cases ***
Succesful Stream Check
    [Template]	Check If Returned Number Of Lines Is Correct
    0				0
    1				1
    2				2
    10				10
    99				99
    100				100
    101				100
    10000			100
    10000000		100

Failed Stream Check
    [Template]	Check If Given Argument Raises Error
    -1
    1.0
    -2.2
    a
    99a
    a99

*** Keywords ***
Check If Returned Number Of Lines Is Correct
	[Documentation]	Проверка количества строк в ответе
	[Arguments]	${parameter}	${expected_number_of_lines}
	${status}	${result}=	Stream	${parameter}
	Run Keyword If	${status} == ${OK}	Should Be Equal As Integers		${result}	${expected_number_of_lines}

Check If Given Argument Raises Error
	[Documentation]	Проверка, вернет ли запрос код возврата ошибки при некорректном аргументе
	[Arguments]	${parameter}
	${status}	${result}=	Stream	${parameter}
	Should Not Be Equal As Integers		${status}	${OK}
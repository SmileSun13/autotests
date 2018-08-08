*** Settings ***
Documentation		Вспомогательные ресурсы

*** Keywords ***
Get Response And Check Status
	[Documentation]	Получение ответа и проверка кода возврата
	[Arguments]	${status}	${keyword}	@{parameters}
	&{RESPONSE}=	Wait Until Keyword Succeeds		10x	200ms	Run Keyword		${keyword}	@{parameters}
	Set Suite Variable	&{RESPONSE}
	Should Be Equal As Integers		&{RESPONSE}[status]		${status}

*** Variables ***
${OK}	200
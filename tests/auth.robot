*** Settings ***
Documentation		Проверка аутентификации
Library				../library/test_lib.py
Resource			../resource/status.robot

*** Test Cases ***
Successful Authentication
	[Template]	Authentication With Valid Credentials
	${USERNAME}			${PASSWORD}
	${USERNAME_OTHER}	${PASSWORD_OTHER}

Failed Authentication
	[Template]	Authentication With Invalid Credentials
	${USERNAME}    ${PASSWORD}    ${USERNAME_OTHER}    ${PASSWORD_OTHER}
	${USERNAME}    ${PASSWORD}    ${USERNAME}    ${PASSWORD_OTHER}
	${USERNAME}    ${PASSWORD}    ${USERNAME_OTHER}    ${PASSWORD}
	${EMPTY}    ${EMPTY}    ${USERNAME}    ${PASSWORD}
	${EMPTY}    ${PASSWORD}    ${USERNAME}    ${PASSWORD}
	${USERNAME}    ${EMPTY}    ${USERNAME}    ${PASSWORD}
	${USERNAME}    ${PASSWORD}	${EMPTY}    ${EMPTY}
	${USERNAME}    ${PASSWORD}	${EMPTY}    ${PASSWORD}
	${USERNAME}    ${PASSWORD}	${USERNAME}    ${EMPTY}

*** Keywords ***
Authentication With Valid Credentials
	[Documentation]	Проверка при правильных данных
	[Arguments]	${login}	${password}
	${status}=	Basic Auth	${login}	${password}	${login}	${password}
	Should Be Equal As Integers		${status}	${OK}

Authentication With Invalid Credentials
	[Documentation]	Проверка при неправильных или недостаточных данных
	[Arguments]	${base_login}	${base_password}	${login}	${password}
	${status}=	Basic Auth	${base_login}	${base_password}	${login}	${password}
	Should Not Be Equal As Integers		${status}	${OK}

*** Variables ***
${USERNAME}				user1
${USERNAME_OTHER}		user2
${PASSWORD}				passwd1
${PASSWORD_OTHER}		passwd2
"""Library for testing webservice http://httpbin.org/ with Robot Framework."""

import requests
from robot.api import logger

BASE_URL = 'http://httpbin.org/'


def _log_response(response):
    """Log additional information to test log.

    Keyword arguments:
    response -- response object (from requests library)

    """
    logger.trace('Raw: {}'.format(response.raw))
    logger.debug('Headers:\n{}'.format(response.headers))
    logger.info('Response body:\n{}'.format(response.text))


def basic_auth(base_login, base_password, login, password):
    """Authentication with Basic-Auth.

    Returns status code.
    Path: /basic-auth/:login/:password.

    Keyword arguments:
    base_login -- login to authenticate to
    base_password -- password for base_login
    login -- login to authenticate with
    password -- password for login

    """
    response = requests.get(
        BASE_URL + 'basic-auth/{}/{}'.format(base_login, base_password),
        auth=(login, password))
    _log_response(response)
    return response.status_code


def stream(n):
    """Get min(n, 100) lines in response body.

    Returns status code and number of lines in response body.
    Path: /stream/:n.

    Keyword arguments:
    n -- (must be non-negative and integer) number of expected lines
    if 0 <= n <= 100; otherwise value does not influence response's body

    """
    response = requests.get(BASE_URL + 'stream/{}'.format(n))
    _log_response(response)
    return response.status_code, response.text.count('\n')


def get():
    """Get GET response's headers.

    Returns dictionary containing status code and response's headers.
    Path: /get.

    """
    response = requests.get(BASE_URL + 'get')
    _log_response(response)
    return {'status': response.status_code, 'headers': response.headers}

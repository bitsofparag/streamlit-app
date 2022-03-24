"""
Sample Data App.
~~~~~~~~~~~~~~~~~~~~~

Sample Weather Streamlit App

Basic usage:
    >>> import app_weather_ts
    >>> app_weather_ts()

CLI usage:
    >>> python -m app_weather_ts.main

:copyright: (c) 2022 Parag M..
:license: MIT, see LICENSE for more details.
"""
import logging
import sys
import streamlit as st
import pandas as pd

from os import path
from decouple import config

SENTRY_DSN = config('APP_SENTRY_DSN', default=False)
here = path.abspath(path.dirname(__file__))
logging.basicConfig(format='%(levelname)s - %(message)s', stream=sys.stdout, level=logging.DEBUG)
logger = logging.getLogger('app_weather_ts')

# Sentry integration
if (SENTRY_DSN):
    import sentry_sdk
    from sentry_sdk.integrations.logging import LoggingIntegration

    sentry_logging = LoggingIntegration(
        level=logging.WARNING,  # Capture warnings and above as breadcrumbs
        event_level=logging.ERROR
    )  # Send errors as events
    # if environment is staging or production, enable sentry
    sentry_sdk.init(dsn=SENTRY_DSN, integrations=[sentry_logging])


def main(*args, **kwargs):
    """Print hello world.

    :some_arg type: describe the argument `some_arg`
    """
    logger.debug('Hello world!')

    # Title
    st.title("Weather Time-Series")

    # Header
    st.header('Temperature Data')

    # Data source
    df = []

    # Line chart
    st.line_chart(df)


if __name__ == '__main__':
    main()

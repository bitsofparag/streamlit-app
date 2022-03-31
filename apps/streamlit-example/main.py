"""
Sample Streamlit App.
~~~~~~~~~~~~~~~~~~~~~

>> Usage:
   streamlit run main.py

:copyright: (c) 2022 Parag M..
:license: MIT, see LICENSE for more details.
"""
import streamlit as st
import pandas as pd
from utils import configure_logger

logger = configure_logger('streamlit-example')

def main(*args, **kwargs):
    """Print hello world.

    :some_arg type: describe the argument `some_arg`
    """
    logger.debug('Hello world!')

    # Title
    st.title("Title: Streamlit App")

    # Header
    st.header('Header')

    # Data source
    df = []

    # Line chart
    st.line_chart(df)


if __name__ == '__main__':
    main()

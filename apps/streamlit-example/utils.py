import logging
import sys
from decouple import config

def configure_logger(name):
    logging.basicConfig(format='%(levelname)s - %(message)s', stream=sys.stdout, level=logging.DEBUG)
    return logging.getLogger(name)


def configure_sentry():
    SENTRY_DSN = config('APP_SENTRY_DSN', default=False)

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


import logging
import os
import warnings

log = logging.getLogger(__name__)
warnings.filterwarnings('ignore', '.*found in sys.modules after import of package.*but prior to execution of.*', RuntimeWarning)

try:
    from ds_tools.logging import init_logging
    from ds_tools.output import Printer; p = Printer('pseudo-json')
    log_level = int(os.environ.get('IPYTHON_LOG_LEVEL', 2))
    print(f'Using log_level={log_level} - use IPYTHON_LOG_LEVEL to change this')
    init_logging(
        log_level,
        log_path=None,
        # log_path='/var/tmp/ipython3_interactive.log',
        entry_fmt='%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s',
        # names=['ds_tools', 'requests_client', 'music_manager', '__main__', 'tz_aware_dt'],
        names=None,
        millis=True,
        set_levels={'asyncio': 50, 'parso.cache': 50},
    )
except ImportError:
    logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s')


class RequestFilter(logging.Filter):    # Make requests_client logged requests gray
    def filter(self, record):
        record.color = 8
        return True


logging.getLogger('requests_client.client').addFilter(RequestFilter())
logging.getLogger('urllib3.connectionpool').addFilter(RequestFilter())


# Remove the colorama stdout/stderr patches, which interfere with ANSI color codes in ConEMU
try:
    import colorama
    import atexit
except ImportError:
    pass
else:
    colorama.deinit()
    colorama.initialise.reset_all()
    atexit.unregister(colorama.initialise.reset_all)

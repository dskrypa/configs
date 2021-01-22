
import logging
import warnings

log = logging.getLogger(__name__)
warnings.filterwarnings('ignore', '.*found in sys.modules after import of package.*but prior to execution of.*', RuntimeWarning)

try:
    from ds_tools.logging import init_logging
    from ds_tools.output import Printer; p = Printer('json-pretty')
    init_logging(4, log_path=None, entry_fmt='%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s', names=['ds_tools', 'requests_client', 'music_manager', '__main__', 'tz_aware_dt'])
    # init_logging(2, log_path='/var/tmp/ipython3_interactive.log', entry_fmt='%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s')
except ImportError:
    pass


class RequestFilter(logging.Filter):    # Make requests_client logged requests gray
    def filter(self, record):
        record.color = 8
        return True


logging.getLogger('requests_client.client').addFilter(RequestFilter())

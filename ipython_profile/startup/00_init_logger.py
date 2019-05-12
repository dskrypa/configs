
import warnings

warnings.filterwarnings('ignore', '.*found in sys.modules after import of package.*but prior to execution of.*', RuntimeWarning)

try:
    from ds_tools.logging import LogManager
    from ds_tools.output import Printer; p = Printer("json-pretty")
    lm = LogManager.create_default_logger(4, log_path=None, entry_fmt="%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s")
    #lm = LogManager.create_default_logger(2, log_path='/var/tmp/ipython3_interactive.log', entry_fmt="%(asctime)s %(levelname)s %(name)s %(lineno)d %(message)s")
except ImportError:
    pass


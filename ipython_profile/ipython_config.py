"""
Location: ~/.ipython/profile_default/ipython_config.py

For better pprint, ``pip install rich``

To debug a silent crash likely due to infinite recursion, run with env var: PYTHONDEVMODE=1
"""

from typing import TYPE_CHECKING

from IPython.core.formatters import PlainTextFormatter, catch_format_error
from IPython.terminal.prompts import ClassicPrompts

if TYPE_CHECKING:
    from traitlets.config.loader import Config
    c = Config()

c.TerminalInteractiveShell.prompts_class = ClassicPrompts  # noqa
c.TerminalInteractiveShell.automagic = False
c.IPCompleter.omit__names = 0
# c.PlainTextFormatter.max_width = 200
c.TerminalInteractiveShell.ast_node_interactivity = 'all'
c.TerminalInteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.xmode = 'Plain'  # prevent bloated traceback output

try:
    # from rich import get_console
    from rich.console import Console
    from rich.highlighter import NullHighlighter
    from rich.pretty import Pretty  # , pprint, pretty_repr
except ImportError:
    c.PlainTextFormatter.pprint = False
else:
    highlighter = NullHighlighter()
    console = Console(highlight=False)

    def _format_obj(self, obj):
        # Note: This is failing for importlib.metadata.EntryPoint objects (infinite recursion)
        # console.print(Pretty(obj, highlighter=highlighter, max_depth=30), soft_wrap=True)
        console.print(Pretty(obj, highlighter=highlighter), soft_wrap=True)
        return None  # Tells ipython that the object has already been printed

    PlainTextFormatter.__call__ = catch_format_error(_format_obj)

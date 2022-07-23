"""
Location: ~/.ipython/profile_default/ipython_config.py

For better pprint, ``pip install rich``
"""

# from io import StringIO
from typing import TYPE_CHECKING

from IPython.core.formatters import PlainTextFormatter, catch_format_error
# from IPython.lib.pretty import RepresentationPrinter, Breakable
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
        console.print(Pretty(obj, highlighter=highlighter), soft_wrap=True)
        return None  # Tells ipython that the object has already been printed

    PlainTextFormatter.__call__ = catch_format_error(_format_obj)


# WIP: Patch for default repr pprinter to make output more symmetrical

# class BetterPrinter(RepresentationPrinter):
#     def __init__(self, *args, **kwargs):
#         super().__init__(StringIO(), *args, **kwargs)
#
#     def begin_group(self, indent=0, open=''):
#         print(f'begin_group: {indent=}, {open=}')
#         indent += 3 if indent else 0
#         indent_str = ' ' * (self.indentation + indent)
#         open = f'{open}\n{indent_str}' if open else open
#         print(f'  > begin_group: {indent=}, {open=}')
#         super().begin_group(indent, open)
#
#     def end_group(self, dedent=0, close=''):
#         print(f'end_group: {dedent=}, {close=}')
#         dedent += 3 if dedent else 0
#         # indent_str = ' ' * (self.indentation + dedent)
#         close = f'\n{close}' if close else close
#         print(f'  > end_group: {dedent=}, {close=}')
#         super().end_group(dedent, close)
#
#     def pformat(self, obj):
#         self.pretty(obj)
#         self.flush()
#         return self.output.getvalue()


# def _format_obj(self, obj):
#     if not self.pprint:
#         return repr(obj)
#     else:
#         return BetterPrinter(
#             self.verbose, self.max_width, self.newline, max_seq_length=self.max_seq_length,
#             singleton_pprinters=self.singleton_printers, type_pprinters=self.type_printers,
#             deferred_pprinters=self.deferred_printers,
#         ).pformat(obj)


# PlainTextFormatter.__call__ = catch_format_error(_format_obj)

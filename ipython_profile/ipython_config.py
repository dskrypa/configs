
"""
Location: ~/.ipython/profile_default/ipython_config.py
"""

from IPython.terminal.prompts import ClassicPrompts

c = get_config()

c.TerminalInteractiveShell.prompts_class = ClassicPrompts
c.TerminalInteractiveShell.automagic = False
c.IPCompleter.omit__names = 0
c.PlainTextFormatter.pprint = False  # Comment out to enable below printer
c.TerminalInteractiveShell.ast_node_interactivity = 'all'
c.TerminalInteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.xmode = 'Plain'  # prevent bloated traceback output


# WIP: Patch for default repr pprinter to make output more symmetrical

from io import StringIO

from IPython.core.formatters import PlainTextFormatter, catch_format_error
from IPython.lib.pretty import RepresentationPrinter, Breakable


class BetterPrinter(RepresentationPrinter):
    def __init__(self, *args, **kwargs):
        super().__init__(StringIO(), *args, **kwargs)

    def begin_group(self, indent=0, open=''):
        indent += 3 if indent else 0
        indent_str = ' ' * (self.indentation + indent)
        super().begin_group(indent, f'{open}\n{indent_str}' if open else open)

    def end_group(self, dedent=0, close=''):
        super().end_group(dedent + 3 if dedent else dedent, f'\n{close}' if close else close)

    def pformat(self, obj):
        self.pretty(obj)
        self.flush()
        return self.output.getvalue()


def _format_obj(self, obj):
    if not self.pprint:
        return repr(obj)
    else:
        return BetterPrinter(
            self.verbose, self.max_width, self.newline, max_seq_length=self.max_seq_length,
            singleton_pprinters=self.singleton_printers, type_pprinters=self.type_printers,
            deferred_pprinters=self.deferred_printers,
        ).pformat(obj)


PlainTextFormatter.__call__ = catch_format_error(_format_obj)

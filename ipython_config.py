
"""
Location: ~/.ipython/profile_default/ipython_config.py
"""

from IPython.terminal.prompts import ClassicPrompts

c = get_config()

c.TerminalInteractiveShell.prompts_class = ClassicPrompts
c.TerminalInteractiveShell.automagic = False
c.IPCompleter.omit__names = 0
c.PlainTextFormatter.pprint = False
c.TerminalInteractiveShell.ast_node_interactivity = "all"

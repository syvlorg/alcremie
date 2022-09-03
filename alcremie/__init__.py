import rich.traceback as RichTraceback
RichTraceback.install(show_locals = True)

import hy

hy.macros.require('alcremie.alcremie',
    # The Python equivalent of `(require alcremie.alcremie *)`
    None, assignments = 'ALL', prefix = '')
hy.macros.require_reader('alcremie.alcremie', None, assignments = 'ALL')
from alcremie.alcremie import *

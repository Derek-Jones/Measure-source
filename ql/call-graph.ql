/**
 * @id calls-from-function
 * @kind table
 */

/*
 * call-graph.ql,  3 Nov 25
 */

import cpp

from FunctionCall call
select call.getTarget(), call.getNumberOfArguments(),
		call.getLocation().getStartLine(), call.getLocation().getEndLine(), call.getFunction(), call.getFile()


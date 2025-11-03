/**
 * @id calls-from-function
 * @kind problem
 * @problem.severity warning
 */

/*
 * call-graph.ql, 31 Oct 25
 */

import cpp

from FunctionCall call
select "", ""+call.getTarget()+","+call.getNumberOfArguments()+
		","+call.getLocation().getStartLine()+","+call.getLocation().getEndLine()+","+call.getEnclosingFunction()+","+call.getFile()


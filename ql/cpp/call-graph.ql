/**
 * @id calls-from-function
 * @kind table
 */

/*
 * call-graph.ql, 14 Nov 25
 */

import cpp

from FunctionCall call
where
        not call.getFile() instanceof HeaderFile and
	not call.isCompilerGenerated()
select call.getTarget() as cname,
		call.getNumberOfArguments() as nargs, call.getNumberOfTemplateArguments() as tempargs,
		count(int dummy | dummy = 1 and call.hasTemplateArgumentList() | dummy) as templatearglist,
		count(int dummy | dummy = 1 and call.isOnlyFoundByADL() | dummy) as foundbyADL,
		count(int dummy | dummy = 1 and call.isVirtual() | dummy) as virtual,
		count(int dummy | dummy = 1 and call.getFile().compiledAsCpp() | dummy) as cpp,
		call.getLocation().getStartLine() as startline,
		call.getEnclosingFunction() as enclosingfunc, call.getFile().getRelativePath() as filepath


/**
 * @id calls-from-function
 * @kind table
 */

/*
 * call-graph.ql, 13 Nov 25
 */

import cpp

from FunctionCall call
where
        not call.getFile() instanceof HeaderFile and
	not call.isCompilerGenerated()
select call.getTarget() as cname,
		call.getNumberOfArguments() as nargs, call.getNumberOfTemplateArguments() as tempargs,
		call.getEnclosingFunction() as enclosefunc,
		count(int dummy | dummy = 1 and call.hasTemplateArgumentList() | dummy) as templatearglist,
		count(int dummy | dummy = 1 and call.isOnlyFoundByADL() | dummy) as foundbyADL,
		count(int dummy | dummy = 1 and call.isVirtual() | dummy) as virtual,
		count(int dummy | dummy = 1 and call.getFile().compiledAsCpp() | dummy) as cpp,
		call.getLocation().getStartLine() as startline, call.getLocation().getEndLine() as endline,
		call.getEnclosingFunction() as enclosingfunc, call.getFile().getRelativePath() as filepath


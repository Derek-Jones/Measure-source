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
select call.getTarget(), call.getNumberOfArguments(), call.getNumberOfTemplateArguments(),
		call.getEnclosingFunction(),
		count(int dummy | dummy = 1 and call.hasTemplateArgumentList() | dummy),
		count(int dummy | dummy = 1 and call.isOnlyFoundByADL() | dummy),
		count(int dummy | dummy = 1 and call.isVirtual() | dummy),
		call.getLocation().getStartLine(), call.getLocation().getEndLine(), call.getEnclosingFunction(), call.getFile().getRelativePath()

/*
target,arguments,targs,enclosefunc,targlist,foundbyadl,virtual,startline,endline,enclosefunc,file
 */

/**
 * @id calls-from-function
 * @kind table
 */

/*
 * call-graph.ql, 22 Jan 26
 */

import cpp

from FunctionCall call
where
        not call.getFile() instanceof HeaderFile and
	not call.isCompilerGenerated()
select call.getTarget() as cname,
		// call.getType() as ctype,
		call.getNumberOfArguments() as nargs, call.getNumberOfTemplateArguments() as tempargs,
		count(int dummy | dummy = 1 and call.hasTemplateArgumentList() | dummy) as templatearglist,
		count(int dummy | dummy = 1 and call.isOnlyFoundByADL() | dummy) as foundbyADL,
		count(int dummy | dummy = 1 and call.isVirtual() | dummy) as virtual,
		count(int dummy | dummy = 1 and call.getFile().compiledAsCpp() | dummy) as cpp,
                // call.getEnclosingFunction().getMetrics().getNumberOfLines() as nlines,
                call.getEnclosingFunction().getMetrics().getNumberOfLinesOfCode() as nLOC,
                count(Stmt s | s.getEnclosingFunction() = call.getEnclosingFunction()) as nstmts,  // Number of statements per function
                // call.getEnclosingFunction().getBlock().getLocation().getStartLine() as curlstart,
		// 	call.getEnclosingFunction().getBlock().getLocation().getEndLine() as curlend,
		call.getLocation().getStartLine() as startline,
		call.getEnclosingFunction() as enclosingfunc, call.getFile().getRelativePath() as filepath


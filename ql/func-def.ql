/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql,  3 Nov 25
 */

import cpp

from Function func
select func.getName(),
		func.getType(),
		func.getMetrics().getNumberOfParameters(),
		func.getMetrics().getNumberOfLines(),
		func.getMetrics().getNumberOfLinesOfCode(),
		func.getMetrics().getNumberOfLinesOfComments(),
		func.getBlock().getLocation().getStartLine(), func.getBlock().getLocation().getEndLine(),
		count(int dummy | dummy = 1 and func.isNoThrow() | dummy),
		count(int dummy | dummy = 1 and func.isSideEffectFree() | dummy),
		count(int dummy | dummy = 1 and func.isVarargs() | dummy),
		func.getLocation().getStartLine(), func.getLocation().getEndLine(), func.getName(), func.getFile()

/*
 * fname,ftype,parameters,lines,LOC,comments,curlstart,curlend,nothrow,sideeffect,varargs,startline,endline,function,file
 */


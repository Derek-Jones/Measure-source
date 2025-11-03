/**
 * @id func-definition
 * @kind problem
 * @problem.severity warning
 */

/*
 * func-def.ql, 31 Oct 25
 */

import cpp

from Function func
select "", ""+func.getName()+
		","+func.getType()+
		","+func.getMetrics().getNumberOfLines()+
		","+func.getMetrics().getNumberOfLinesOfCode()+
		","+func.getMetrics().getNumberOfLinesOfComments()+
		","+func.getMetrics().getNumberOfParameters()+
		","+count(int dummy | dummy = 1 and func.isNoThrow() | dummy)+
		","+count(int dummy | dummy = 1 and func.isSideEffectFree() | dummy)+
		","+count(int dummy | dummy = 1 and func.isVarargs() | dummy)+
		","+func.getLocation().getStartLine()+","+func.getLocation().getEndLine()+","+func.getEnclosingFunction()+","+func.getFile()


/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql,  5 Nov 25
 */

import python

from Function func
select func.getName(),
		func.getMinPositionalArguments(), func.getMaxPositionalArguments(),
		func.getMetrics().getNumberOfLines(),
		func.getMetrics().getNumberOfLinesOfCode(),
		func.getMetrics().getNumberOfLinesOfComments(),
		func.getMetrics().getNumberOfLinesOfDocStrings(),
		count(func.getAStmt()),
		count(int dummy | dummy = 1 and func.hasKwArg() | dummy),
		count(int dummy | dummy = 1 and func.hasVarArg() | dummy),
		count(int dummy | dummy = 1 and func.isGenerator() | dummy),
		count(int dummy | dummy = 1 and func.isInitMethod() | dummy),
		count(int dummy | dummy = 1 and func.isLambda() | dummy),
		count(int dummy | dummy = 1 and func.isMethod() | dummy),
		count(int dummy | dummy = 1 and func.isProcedure() | dummy),
		func.getDefinition().getLocation().getStartLine(), func.getDefinition().getLocation().getEndLine(),
 		func.getLastStatement().getLocation().getEndLine(),
		func.getName(), func.getScope().getLocation().getFile()

/*
		count(int dummy | dummy = 1 and func.neverReturns() | dummy),
		count(int dummy | dummy = 1 and func.isOverridingMethod() | dummy),
		count(int dummy | dummy = 1 and func.isOverridingMethod() | dummy)

from FunctionDef func
select func.toString(),
		func.getDefinedFunction(),
		func.getLocation().getStartLine(), func.getLastStatement().getLocation().getEndLine(),
		func.toString(), func.getLocation().getFile()

 * 
 */


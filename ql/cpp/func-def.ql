/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql, 11 Nov 25
 */

import cpp

from Function func
where
	not func.isCompilerGenerated() and
        not func.getFile() instanceof HeaderFile
select func.getName(),
		func.getType(),
		func.getMetrics().getNumberOfParameters(),
		func.getMetrics().getNumberOfLines(),
		func.getMetrics().getNumberOfLinesOfCode(),
		func.getMetrics().getNumberOfLinesOfComments(),
		func.getBlock().getLocation().getStartLine(), func.getBlock().getLocation().getEndLine(),
		count(int dummy | dummy = 1 and func.hasCLinkage() | dummy),
		count(int dummy | dummy = 1 and func.hasExceptionSpecification() | dummy),
		count(int dummy | dummy = 1 and func.isConsteval() | dummy),
		count(int dummy | dummy = 1 and func.isConstexpr() | dummy),
		count(int dummy | dummy = 1 and func.isDeclaredConstexpr() | dummy),
		count(int dummy | dummy = 1 and func.isDeclaredVirtual() | dummy),
		count(int dummy | dummy = 1 and func.isDefaulted() | dummy),
		count(int dummy | dummy = 1 and func.isDeleted() | dummy),
		count(int dummy | dummy = 1 and func.isExplicit() | dummy),
		count(int dummy | dummy = 1 and func.isFinal() | dummy),
		count(int dummy | dummy = 1 and func.isInline() | dummy),
		count(int dummy | dummy = 1 and func.isNaked() | dummy),
		count(int dummy | dummy = 1 and func.isNoExcept() | dummy),
		count(int dummy | dummy = 1 and func.isNoThrow() | dummy),
		count(int dummy | dummy = 1 and func.isOverride() | dummy),
		count(int dummy | dummy = 1 and func.isPrototyped() | dummy),
		count(int dummy | dummy = 1 and func.isSideEffectFree() | dummy),
		count(int dummy | dummy = 1 and func.isSpecialization() | dummy),
		count(int dummy | dummy = 1 and func.isVarargs() | dummy),
		count(int dummy | dummy = 1 and func.isVirtual() | dummy),
		func.getLocation().getStartLine(), func.getLocation().getEndLine(), func.getName(), func.getFile().getRelativePath()

/*
 * fname,ftype,parameters,lines,LOC,comments,curlstart,curlend,nothrow,sideeffect,varargs,startline,endline,function,file
 */


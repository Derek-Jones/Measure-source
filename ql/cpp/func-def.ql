/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql, 13 Nov 25
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
		count(Stmt s | s.getEnclosingFunction() = func),  // Number of statements per function
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
		count(int dummy | dummy = 1 and func.isMember() | dummy),
		count(int dummy | dummy = 1 and func.isNaked() | dummy),
		count(int dummy | dummy = 1 and func.isNoExcept() | dummy),
		count(int dummy | dummy = 1 and func.isNoThrow() | dummy),
		count(int dummy | dummy = 1 and func.isOverride() | dummy),
		count(int dummy | dummy = 1 and func.isPrototyped() | dummy),
		count(int dummy | dummy = 1 and func.isSideEffectFree() | dummy),
		count(int dummy | dummy = 1 and func.isSpecialization() | dummy),
		count(int dummy | dummy = 1 and func.isStatic() | dummy),
		count(int dummy | dummy = 1 and func.isVarargs() | dummy),
		count(int dummy | dummy = 1 and func.isVirtual() | dummy),
		func.getLocation().getStartLine(), func.getLocation().getEndLine(), func.getName(), func.getFile().getRelativePath()

/*
fname,ftype,numparams,nlines,nLOC,ncomments,curlstart,curlend,Clinkage,exceptionspec,consteval,constexpr,declconstexpr,declvirt,defaulted,deleted,explicit,final,inline,member,naked,noexcept,nothrow,override,prototyped,sideeffect,specialization,static,varargs,virtual,startline,endline,function,file
 */


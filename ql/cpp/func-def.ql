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
select func.getName() as fname,
		func.getType() as ftype,
		func.getMetrics().getNumberOfParameters() as nparams,
		func.getMetrics().getNumberOfLines() as nlines,
		func.getMetrics().getNumberOfLinesOfCode() as nLOC,
		func.getMetrics().getNumberOfLinesOfComments() as ncomments,
		count(Stmt s | s.getEnclosingFunction() = func) as nstmts,  // Number of statements per function
		func.getBlock().getLocation().getStartLine() as curlstart, func.getBlock().getLocation().getEndLine() as curlend,
		count(int dummy | dummy = 1 and func.hasCLinkage() | dummy) as clinkage,
		count(int dummy | dummy = 1 and func.hasExceptionSpecification() | dummy) as exceptionspec,
		count(int dummy | dummy = 1 and func.isConsteval() | dummy) as consteval,
		count(int dummy | dummy = 1 and func.isConstexpr() | dummy) as constexpr,
		count(int dummy | dummy = 1 and func.isDeclaredConstexpr() | dummy) as declconstexpr,
		count(int dummy | dummy = 1 and func.isDeclaredVirtual() | dummy) as declvirtual,
		count(int dummy | dummy = 1 and func.isDefaulted() | dummy) as defaulted,
		count(int dummy | dummy = 1 and func.isDeleted() | dummy) as deleted,
		count(int dummy | dummy = 1 and func.isExplicit() | dummy) as explicit,
		count(int dummy | dummy = 1 and func.isFinal() | dummy) as final,
		count(int dummy | dummy = 1 and func.isInline() | dummy) as inline,
		count(int dummy | dummy = 1 and func.isMember() | dummy) as member,
		count(int dummy | dummy = 1 and func.isNaked() | dummy) as naked,
		count(int dummy | dummy = 1 and func.isNoExcept() | dummy) as noexcept,
		count(int dummy | dummy = 1 and func.isNoThrow() | dummy) as nothrow,
		count(int dummy | dummy = 1 and func.isOverride() | dummy) as override,
		count(int dummy | dummy = 1 and func.isPrototyped() | dummy) as prototyped,
		count(int dummy | dummy = 1 and func.isSideEffectFree() | dummy) as seffectfqee,
		count(int dummy | dummy = 1 and func.isSpecialization() | dummy) as specialization,
		count(int dummy | dummy = 1 and func.isStatic() | dummy) as static,
		count(int dummy | dummy = 1 and func.isVarargs() | dummy) as varargs,
		count(int dummy | dummy = 1 and func.isVirtual() | dummy) as virtual,
		func.getLocation().getStartLine() as startline, func.getLocation().getEndLine() as endline,
		func.getName() as funcname, func.getFile().getRelativePath() as filepath



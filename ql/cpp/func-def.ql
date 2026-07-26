/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql, 21 Jul 26
 */

import cpp

// int startLine(Function aFunc)
// {
// exists(Location loc | loc = aFunc.getLocation() | result = loc.getStartLine())
// }

// int endLine(Function aFunc)
// {
// exists(Location loc | loc = aFunc.getLocation() | result = loc.getEndLine())
// }

from Function func
where
	not func.isCompilerGenerated() and
        not func.getFile() instanceof HeaderFile and
		not func.isConstructedFrom(_)
select func.getName() as fname,
		func.getType() as ftype,
		func.getNumberOfParameters() as nparam,
		func.getMetrics().getNumberOfLines() as nline,
		func.getMetrics().getNumberOfLinesOfCode() as nLOC,
		func.getMetrics().getNumberOfLinesOfComments() as ncomment,
		func.getMetrics().getNumberOfCalls() as ncall,   // Number of calls in this function
		count(FunctionCall fc | fc.getEnclosingFunction()= func and fc.isCompilerGenerated()) as ncgcall,  // Number of calls in this function
		count(FunctionCall fc | fc.getEnclosingFunction()= func and fc.isInMacroExpansion()) as nmecall,  // Number of calls in this function
		count(ExprCall pc | pc.getEnclosingFunction() = func) as nptrcall,  // Number of calls via a pointer
		count(FunctionCall fc | fc.getTarget() = func) as ncalled,  // Number of calls to this function
		count(Stmt s | s.getEnclosingFunction() = func) as nstmt,  // Number of statements per function
		count(BlockStmt bs | bs.getEnclosingFunction() = func) as nblkstmt,  // Number of block-statements per function
		count(IfStmt i | i.getEnclosingFunction() = func) as nif,  // Number of if-statements per function
		count(SwitchStmt s | s.getEnclosingFunction() = func) as nswitch,  // Number of while-statements per function
		count(ForStmt f | f.getEnclosingFunction() = func) as nfor,  // Number of for-statements per function
		count(WhileStmt w | w.getEnclosingFunction() = func) as nwhile,  // Number of while-statements per function
		count(DoStmt d | d.getEnclosingFunction() = func) as ndo,  // Number of do-statements per function
		count(ExprStmt e | e.getEnclosingFunction() = func) as nexprstmt,  // Number of expression-statements per function
		count(BreakStmt b | b.getEnclosingFunction() = func) as nbreak,  // Number of break-statements per function
		count(ContinueStmt c | c.getEnclosingFunction() = func) as ncontinue,  // Number of continue-statements per function
		count(ReturnStmt r | r.getEnclosingFunction() = func) as nreturn,  // Number of return-statements per function
		count(LocalVariable lv | lv.getFunction() = func) as nloclvar,  // Number of local variables
		//func.getBlock().getLocation().getStartLine() as curlstart, func.getBlock().getLocation().getEndLine() as curlend,
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
		// startLine(func) as startline,
		// endLine(func) as endline,
		// func.getLocation().getStartLine() as startline, func.getLocation().getEndLine() as endline,
		// func.getLocation().toString() as aloc,
		func.getFile().getRelativePath() as filepath



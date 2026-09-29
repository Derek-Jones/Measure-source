/**
 * @id func-definition
 * @kind table
 */

/*
 * func-def.ql, 28 Sep 26
 */

import python
import semmle.python.types.FunctionObject

from FunctionMetrics func
where
                not func.isArtificial() and
                func.inSource()
select func.getName(),
		func.getMinPositionalArguments() as nposargs,
		func.getNumberOfLines() as nlines,
		func.getNumberOfLinesOfCode() as nLOC,
		func.getNumberOfLinesOfComments() as ncomments,
		func.getNumberOfLinesOfDocStrings() as ndocstrings,
		func.getStatementNestingDepth() as nestdepth,
		func.getNumberOfCalls() as ncalls,
		count(func.getAStmt()) as nstmts,
		// count(ExprStmt e | e.getEnclosingCallable() = meth) as nexprstmt,  // Number of expression-statements per method
		count(FunctionObject fo | fo.getFunction() = func) as ncalled,  // Number of calls to this function
		count(int dummy | dummy = 1 and func.hasKwArg() | dummy) as kwarg,
		count(int dummy | dummy = 1 and func.hasVarArg() | dummy) as vararg,
		count(int dummy | dummy = 1 and func.isGenerator() | dummy) as generator,
		count(int dummy | dummy = 1 and func.isInitMethod() | dummy) as initmeth,
		count(int dummy | dummy = 1 and func.isLambda() | dummy) as lambda,
		count(int dummy | dummy = 1 and func.isMethod() | dummy) as meth,  // Declared as a class?
		count(int dummy | dummy = 1 and func.isProcedure() | dummy) as proc,
		count(int dummy | dummy = 1 and func.isPublic() | dummy) as public,
		count(int dummy | dummy = 1 and func.isTopLevel() | dummy) as toplevel,

		count(Stmt s | s.getScope() = func and
				s instanceof Assert) as nassert,
		count(Stmt s | s.getScope() = func and
				s instanceof Assign) as nassign,
		count(Stmt s | s.getScope() = func and
				s instanceof AnnAssign) as nannAssign,
		count(Stmt s | s.getScope() = func and
				s instanceof AugAssign) as naugAssign,
		count(Stmt s | s.getScope() = func and
				s instanceof Break) as nbreak,
		count(Stmt s | s.getScope() = func and
				s instanceof Continue) as ncontinue,
		count(Stmt s | s.getScope() = func and
				s instanceof Delete) as ndelete,
		count(Stmt s | s.getScope() = func and
				s instanceof ExceptStmt) as nexceptstmt,
		count(Stmt s | s.getScope() = func and
				s instanceof ExprStmt) as nexprstmt,
		count(Stmt s | s.getScope() = func and
				s instanceof For) as nfor,
		count(Stmt s | s.getScope() = func and
				s instanceof Global) as nglobal,
		count(Stmt s | s.getScope() = func and
				s instanceof If) as nif,
		count(Stmt s | s.getScope() = func and
				s instanceof Nonlocal) as nnonlocal,
		count(Stmt s | s.getScope() = func and
				s instanceof Pass) as npass,
		count(Stmt s | s.getScope() = func and
				s instanceof Raise) as nraise,
		count(Stmt s | s.getScope() = func and
				s instanceof Return) as nreturn,
		count(Stmt s | s.getScope() = func and
				s instanceof Try) as ntry,
		count(Stmt s | s.getScope() = func and
				s instanceof While) as nwhile,
		count(Stmt s | s.getScope() = func and
				s instanceof With) as nwith,
		count(Stmt s | s.getScope() = func and
				s instanceof FunctionDef) as nfunctiondef,
		count(Stmt s | s.getScope() = func and
				s instanceof ClassDef) as nclassdef,

		func.getDefinition().getLocation().getStartLine() as startline,
		func.getDefinition().getLocation().getEndLine() as endline,
 		func.getLastStatement().getLocation().getEndLine() as lstmtline,
		func.getScope().getLocation().getFile().getRelativePath() as relpath


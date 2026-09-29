/**
 * @id expr-stmt
 * @kind table
 */

/*
 * expr-stmts.ql, 19 Sep 26
 */

import cpp

from ExprStmt es
where
        not es.isCompilerGenerated() and
        not es.getFile() instanceof HeaderFile and
		not es.getEnclosingFunction().isConstructedFrom(_)
select 	es.getLocation().getStartLine() as startline,
		es.getLocation().getEndLine() as endline,
		es.getLocation().getStartColumn() as startcol,
		es.getLocation().getEndColumn() as endcol,
		count(int dummy | dummy = 1 and es.getFile().compiledAsC() | dummy) as isC,
		es.getEnclosingFunction() as enclosingfunc,
		es.getFile().getRelativePath() as filepath



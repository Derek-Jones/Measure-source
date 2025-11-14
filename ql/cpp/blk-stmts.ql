/**
 * @id compound-stmt
 * @kind table
 */

/*
 * blk-stmts.ql, 14 Nov 25
 */

import cpp

from BlockStmt bs
select bs.getParent() as parent, bs.getNumStmt() as nstmt,
		bs.getLocation().getStartLine() as startline, bs.getLastStmt().getLocation().getEndLine() as endline,
		bs.getEnclosingFunction() as enclosingfunc, bs.getFile().getRelativePath() as filepath



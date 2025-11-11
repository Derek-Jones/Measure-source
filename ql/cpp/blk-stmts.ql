/**
 * @id compound-stmt
 * @kind table
 */

/*
 * blk-stmts.ql, 11 Nov 25
 */

import cpp

from BlockStmt bs
select bs.getParent(), bs.getNumStmt(),
		bs.getLocation().getStartLine(), bs.getLastStmt().getLocation().getEndLine(),
		bs.getEnclosingFunction(), bs.getFile().getRelativePath()


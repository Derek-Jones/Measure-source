/**
 * @id compound-stmt
 * @kind table
 */

/*
 * blk-stmts.ql,  3 Nov 25
 */

import cpp

from BlockStmt bs
select bs.getParent(), bs.getNumStmt(),
		bs.getLocation().getStartLine(), bs.getLocation().getEndLine(), bs.getFunction(), bs.getFile()


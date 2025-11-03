/**
 * @id compound-stmt
 * @kind problem
 * @problem.severity warning
 */

/*
 * blk-stmts.ql, 31 Oct 25
 */

import cpp

from BlockStmt bs
select "", ""+bs.getParent()+","+bs.getNumStmt()+
		","+bs.getLocation().getStartLine()+","+bs.getLocation().getEndLine()+","+bs.getEnclosingFunction()+","+bs.getFile()


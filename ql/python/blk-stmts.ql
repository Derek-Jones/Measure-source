/**
 * @id compound-stmt
 * @kind table
 */

/*
 * blk-stmts.ql, 11 Nov 25
 */

import python
import semmle.python.Stmts

from StmtList sl
select sl, count(sl.getAnItem()),
		sl.getItem(0).getLocation().getStartLine(), sl.getLastItem().getLocation().getEndLine(),
		sl.getItem(0).getScope(), sl.getItem(0).getScope().getLocation().getFile().getRelativePath()


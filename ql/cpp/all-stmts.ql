/**
 * @id all-stmts
 * @kind table
 */

/*
 * all-stmts.ql, 19 Sep 26
 */

import cpp

from Stmt st
where
        not st.isCompilerGenerated() and
        not st.getFile() instanceof HeaderFile and
		not st.getEnclosingFunction().isConstructedFrom(_)
select 	st.getLocation().getStartLine() as startline,
		st.getLocation().getEndLine() as endline,
		st.getLocation().getStartColumn() as startcol,
		st.getLocation().getEndColumn() as endcol,
		count(int dummy | dummy = 1 and st.getFile().compiledAsC() | dummy) as isC,
		st.toString() as stmtkind,
		st.getEnclosingFunction() as enclosingfunc,
		st.getFile().getRelativePath() as filepath



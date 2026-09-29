/**
 * @id all-tokens
 * @kind table
 */

/*
 * all-tokens.ql, 19 Sep 26
 */

import cpp

from Element el
where
		// not el.isCompilerGenerated() and
		not el.getFile() instanceof HeaderFile and
		not el.isInMacroExpansion()
		// not el.getEnclosingFunction().isConstructedFrom(_)
select 	el.getLocation().getStartLine() as startline,
		el.getLocation().getStartColumn() as startcol,
		el.getLocation().getEndColumn() as endcol,
		// el.toString() as elemstr,
		count(int dummy | dummy = 1 and el.getFile().compiledAsC() | dummy) as isC,
		// el.getEnclosingFunction() as enclosingfunc,
		el.getFile().getRelativePath() as filepath



/**
 * @id unused-local
 * @kind table
 */

/*
 * unused-local.ql, 14 Nov 25
 */

import cpp

from LocalScopeVariable lv
where
  	not lv instanceof Parameter and
  	not exists(lv.getAnAccess()) and
	not lv.getFunction().isCompilerGenerated() and
	not lv.getFile() instanceof HeaderFile
select lv.getName() as vname,
		lv.getLocation().getStartLine() as startline, lv.getLocation().getEndLine() as endline,
		lv.getFunction() as enclosingfunc, lv.getFile().getRelativePath() as filepath



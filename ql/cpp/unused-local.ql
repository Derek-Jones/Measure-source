/**
 * @id unused-local
 * @kind table
 */

/*
 * unused-local.ql, 13 Nov 25
 */

import cpp

from LocalScopeVariable lv
where
  	not lv instanceof Parameter and
  	not exists(lv.getAnAccess()) and
	not lv.getFunction().isCompilerGenerated() and
	not lv.getFile() instanceof HeaderFile
select lv.getName(),
		lv.getLocation().getStartLine(), lv.getLocation().getEndLine(), lv.getFunction(), lv.getFile().getRelativePath()

/*
vname,startline,endline,enclosefunction,filepath
 */



/**
 * @id unused-local
 * @kind table
 */

/*
 * unused-local.ql,  3 Nov 25
 */

import cpp

from LocalScopeVariable lv
where
  not lv instanceof Parameter and
  not exists(lv.getAnAccess())
select lv.getName(),
		lv.getLocation().getStartLine(), lv.getLocation().getEndLine(), lv.getFunction(), lv.getFile()


/**
 * @id unused-local
 * @kind problem
 * @problem.severity warning
 */

/*
 * unused-local.ql, 31 Oct 25
 */

import cpp

from LocalScopeVariable lv
where
  not lv instanceof Parameter and
  not exists(lv.getAnAccess())
select "", ""+lv.getName()+
		","+lv.getLocation().getStartLine()+","+lv.getLocation().getEndLine()+","+lv.getEnclosingFunction()+","+lv.getFile()


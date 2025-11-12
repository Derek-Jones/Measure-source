/**
 * @id unused-param
 * @kind table
 */

/*
 * unused-param.ql, 12 Nov 25
 *
 * Mostly copied from codeql examples
 */

import python
import Definition

predicate unused_parameter(FunctionValue f, LocalVariable v) {
  v.isParameter() and
  v.getScope() = f.getScope() and
  not name_acceptable_for_unused_variable(v) and
  not exists(NameNode u | u.uses(v)) and
  not exists(Name inner, LocalVariable iv |
    inner.uses(iv) and iv.getId() = v.getId() and inner.getScope().getScope() = v.getScope()
  )
}

predicate is_abstract(FunctionValue func) {
  func.getScope().getADecorator().(Name).getId().matches("%abstract%")
}

from PythonFunctionValue f, LocalVariable v
where
  v.getId() != "self" and
  unused_parameter(f, v) and
  not f.isOverridingMethod() and
  not f.isOverriddenMethod() and
  not is_abstract(f)
select v.getId(),
		max(int n | v.getId() = f.getParameter(n).getId() | n), // Parameter number
		f.minParameters(), f.maxParameters(), f.descriptiveString(),
		v.getScope().getLocation().getStartLine(), v.getScope().getLocation().getEndLine(), v.getScope(), v.getScope().getLocation().getFile().getRelativePath()

/*
 * pname,pnum,minp,maxp,fname,pstartline,pendline,scope,filename
 */

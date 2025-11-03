/**
 * @id def-use
 * @kind problem
 * @problem.severity warning
 */

/*
 * def-use.ql, 31 Oct 25
 */

import cpp


from StackVariable v, ControlFlowNode def, Element use
where
  definition(v, def) and
  definitionUsePair(v, def, use)
select def, ""+v.getName()+
		","+v.getLocation().getStartLine()+","+use.getLocation().getStartLine()+","+def.getFile()


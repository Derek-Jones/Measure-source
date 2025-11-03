/**
 * @id def-use
 * @kind table
 */

/*
 * def-use.ql,  3 Nov 25
 */

import cpp


from StackVariable v, ControlFlowNode def, Element use
where
  definition(v, def) and
  definitionUsePair(v, def, use)
select def, ""+v.getName()+
		v.getLocation().getStartLine(), v.getLocation().getEndLine(), v.getFunction(), v.getFile()


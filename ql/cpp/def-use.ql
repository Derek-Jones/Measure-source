/**
 * @id def-use
 * @kind table
 */

/*
 * def-use.ql, 14 Nov 25
 */

import cpp


from StackVariable v, ControlFlowNode def, Element use
where
	definition(v, def) and
	definitionUsePair(v, def, use) and
        not v.getFile() instanceof HeaderFile and
	not v.getFunction().isCompilerGenerated()
select def, v.getName() as vname,
		def.getLocation().getStartLine() dstartline, use.getLocation().getStartLine() dendline,
		v.getParentScope().getLocation().getStartLine() as vstartline, v.getParentScope().getLocation().getEndLine() as vendline,
		count(int dummy | dummy = 1 and v.isConst() | dummy) as const,
		count(int dummy | dummy = 1 and v.isConstinit() | dummy) as constinit,
		count(int dummy | dummy = 1 and v.isMember() | dummy) as member,
		count(int dummy | dummy = 1 and v.isTopLevel() | dummy) as toplevel,
		count(int dummy | dummy = 1 and v.isVolatile() | dummy) as volatile,
		v.getFunction() as enclosingfunc, v.getFile().getRelativePath() as filepath



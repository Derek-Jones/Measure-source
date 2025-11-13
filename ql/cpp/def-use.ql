/**
 * @id def-use
 * @kind table
 */

/*
 * def-use.ql, 11 Nov 25
 */

import cpp


from StackVariable v, ControlFlowNode def, Element use
where
	definition(v, def) and
	definitionUsePair(v, def, use) and
        not v.getFile() instanceof HeaderFile and
	not v.getFunction().isCompilerGenerated()
select def, v.getName(),
		def.getLocation().getStartLine(), use.getLocation().getStartLine(),
		v.getParentScope().getLocation().getStartLine(), v.getParentScope().getLocation().getEndLine(),
		count(int dummy | dummy = 1 and v.isConst() | dummy),
		count(int dummy | dummy = 1 and v.isConstinit() | dummy),
		count(int dummy | dummy = 1 and v.isMember() | dummy),
		count(int dummy | dummy = 1 and v.isTopLevel() | dummy),
		count(int dummy | dummy = 1 and v.isVolatile() | dummy),
		v.getLocation().getStartLine(), v.getLocation().getEndLine(), v.getFunction(), v.getFile().getRelativePath()

/*
def,vname,defline,useline,vscopestart,vscopeend,const,constinit,member,toplevel,volatile,vstartline,vendline,vfunc,vfile
 */


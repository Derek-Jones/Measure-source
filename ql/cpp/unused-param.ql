/**
 * @id unused-param
 * @kind table
 */

/*
 * unused-param.ql, 11 Nov 25
 */

import cpp

/*
{ fstr = "h" or fstr = "H" or fstr = "hpp" }

	not header_suffix(p.getFile().getExtensions())
*/

from Parameter p
where p.isNamed() and
	not exists(p.getAnAccess()) and
	not p.getFunction().isCompilerGenerated() and
	not p.getFile() instanceof HeaderFile
select p.getName(),
		max(int n | p.getName() = p.getFunction().getParameter(n).getName() | n), // Parameter number
		p.getFunction().getNumberOfParameters(),
		p.getLocation().getStartLine(), p.getLocation().getEndLine(), p.getFunction(), p.getFile().getRelativePath()


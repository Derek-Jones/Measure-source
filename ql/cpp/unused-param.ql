/**
 * @id unused-param
 * @kind table
 */

/*
 * unused-param.ql, 14 Nov 25
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
select p.getName() as pname,
		max(int n | p.getName() = p.getFunction().getParameter(n).getName() | n) as pnum, // Parameter number
		p.getFunction().getNumberOfParameters() as numparam,
		p.getLocation().getStartLine() as startline, p.getLocation().getEndLine() as endline,
		p.getFunction() as enclosingfunc, p.getFile().getRelativePath() as filepath



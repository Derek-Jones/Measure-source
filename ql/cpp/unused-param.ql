/**
 * @id unused-param
 * @kind table
 */

/*
 * unused-param.ql,  3 Nov 25
 */

import cpp

predicate header_suffix(string fstr)
{ fstr = "h" or fstr = "H" or fstr = "hpp" }

from Parameter p
where p.isNamed() and
	not exists(p.getAnAccess()) and
	not header_suffix(p.getFile().getExtension())
select p.getName(),
		p.getLocation().getStartLine(), p.getLocation().getEndLine(), p.getFunction(), p.getFile()


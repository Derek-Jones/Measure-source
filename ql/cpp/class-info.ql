/**
 * @id class-definition
 * @kind table
 */

/*
 * class-info.ql, 11 Nov 25
 */

import cpp

from Class C
where
	not C.isCompilerGenerated() and
        not C.getFile() instanceof HeaderFile
select C.getName(),
		C.getType(),
		C.getMetrics().getNumberOfParameters(),
		C.getMetrics().getNumberOfLines(),
		C.getMetrics().getNumberOfLinesOfCode(),
		C.getMetrics().getNumberOfLinesOfComments(),
		C.getLocation().getStartLine(), C.getLocation().getEndLine(),
		count(int dummy | dummy = 1 and func.hasCLinkage() | dummy),
		count(int dummy | dummy = 1 and func.hasExceptionSpecification() | dummy),
		count(int dummy | dummy = 1 and func.isOverride() | dummy),
		count(int dummy | dummy = 1 and func.isSpecialization() | dummy),
		count(int dummy | dummy = 1 and func.isVarargs() | dummy),
		C.getLocation().getStartLine(), C.getLocation().getEndLine(), C.getName(), C.getFile().getRelativePath()

/*
The number of lines of code in a class.
where
  c.fromSource() and
  n =
    c.getMetrics().getNumberOfMembers() +
      sum(Function f | c.getACanonicalMemberFunction() = f | f.getMetrics().getNumberOfLinesOfCode())
select c, n

The number of statements in the member functions of a class.
 For template functions, only the statements in the template
 itself, not in the instantiations, are counted.
from Class c, int n
where
  c.fromSource() and
  n = count(Stmt s | s.getEnclosingFunction() = c.getACanonicalMemberFunction())
select c, n

 The number of public member functions in a public class.
n = count(Function f | c.getAPublicCanonicalMember() = f)

*/

/*
 * fname,ftype,parameters,lines,LOC,comments,curlstart,curlend,nothrow,sideeffect,varargs,startline,endline,function,file
 */


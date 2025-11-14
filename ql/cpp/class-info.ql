/**
 * @id class-definition
 * @kind table
 */

/*
 * class-info.ql, 14 Nov 25
 */

import cpp

from Class C
where
	not C.isCompilerGenerated() and
        not C.getFile() instanceof HeaderFile
select C.getName() as cname,
		C.getMetrics().getNumberOfLines() as nlines,
		C.getMetrics().getNumberOfLinesOfCode() as LOC,
		C.getMetrics().getNumberOfLinesOfComments() as ncomments,
		count(int dummy | dummy = 1 and func.hasExceptionSpecification() | dummy) as exceptspec,
		count(int dummy | dummy = 1 and func.isOverride() | dummy) as override,
		count(int dummy | dummy = 1 and func.isSpecialization() | dummy) as specialization,
		C.getLocation().getStartLine() as startline, C.getLocation().getEndLine() as endline,
		C.getFile().getRelativePath() as filepath



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


Shows the distribution of inheritance depth across all classes.

predicate hasInheritanceDepth(Class c, int d) {
  c.fromSource() and d = c.getMetrics().getInheritanceDepth()
}

from int depth
where hasInheritanceDepth(_, depth)
select depth as inheritanceDepth, count(Class c | hasInheritanceDepth(c, depth)) as numberOfClasses
  order by inheritanceDepth


Shows general statistics about the application.

from string l, string n
where
  l = "Number of Namespaces" and
  n = count(Namespace p | p.fromSource()).toString()
  or
  l = "Number of Files" and
  n = count(File f | f.fromSource()).toString()
  or
  l = "Number of Header Files" and
  n = count(HeaderFile f | f.fromSource()).toString()
  or
  l = "Number of C Files" and
  n = count(CFile f | f.fromSource()).toString()
  or
  l = "Number of C++ Files" and
  n = count(CppFile f | f.fromSource()).toString()
  or
  l = "Number of Classes" and
  n = count(Class c | c.fromSource() and not c instanceof Struct).toString()
  or
  l = "Number of Structs" and
  n = count(Struct s | s.fromSource() and not s instanceof Union).toString()
  or
  l = "Number of Unions" and
  n = count(Union u | u.fromSource()).toString()
  or
  l = "Number of Functions" and
  n = count(Function f | f.fromSource()).toString()
  or
  l = "Number of Lines Of Code" and
  n =
    sum(File f, int toSum |
      f.fromSource() and toSum = f.getMetrics().getNumberOfLinesOfCode()
    |
      toSum
    ).toString()
  or
  l = "Self-Containedness" and
  n =
    (
        100 * sum(Class c | c.fromSource() | c.getMetrics().getEfferentSourceCoupling()) /
          sum(Class c | c.fromSource() | c.getMetrics().getEfferentCoupling())
      ).toString() + "%"
select l as title, n as value

*/

/*
 * fname,ftype,parameters,lines,LOC,comments,curlstart,curlend,nothrow,sideeffect,varargs,startline,endline,function,file
 */


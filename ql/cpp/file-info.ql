/**
 * @id file-info
 * @kind table
 */

/*
 * file-info.ql, 21 Jul 26 Nov 25
 */

import cpp

from File f
where
        not f.getFile() instanceof HeaderFile
select f.getShortName()+"."+f.getExtensions() as fname,
		f.getMetrics().getNumberOfClasses() as nclasses,
		f.getMetrics().getNumberOfTopLevelFunctions() as ntopfuncs,
		f.getMetrics().getNumberOfUserTypes() as numusrtypes,
		f.getMetrics().getNumberOfLines() as nlines,
		f.getMetrics().getNumberOfLinesOfCode() as nLOC,
		f.getMetrics().getNumberOfLinesOfComments() as ncomments,
		count(f.getAnIncludedFile()) as ninclfiles,
		count(int dummy | dummy = 1 and f.compiledAsC() | dummy) as isC,
		count(int dummy | dummy = 1 and f.compiledAsCpp() | dummy) as isCpp,
		f.getLocation().getStartLine() as startline, f.getLocation().getEndLine() as endline,
    f.getRelativePath() as filepath


/*
fname,numclasses,numtoplevelfuncs,numusertypes,numlines,numLOC,numcomments,compiledC,compiledCpp,startline,endline,fpath
 */

/*
Count the number of dependencies a C/C++ source file has on external libraries.

import ExternalDependencies

from File file, int num, string encodedDependency
where encodedDependencies(file, encodedDependency, num)
select encodedDependency, num order by num desc


The total number of global variables in each file.

predicate macroLocation(File f, int startLine, int endLine) {
  exists(MacroInvocation mi, Location l |
    l = mi.getLocation() and
    l.getFile() = f and
    l.getStartLine() = startLine and
    l.getEndLine() = endLine
  )
}

pragma[nomagic]
Location getVariableLocation(Variable v) { result = v.getLocation() }

predicate globalLocation(GlobalVariable gv, File f, int startLine, int endLine) {
  exists(Location l |
    l = getVariableLocation(gv) and
    l.hasLocationInfo(f.getAbsolutePath(), startLine, _, endLine, _)
  )
}

predicate inMacro(GlobalVariable gv) {
  exists(File f, int macroStart, int macroEnd, int varStart, int varEnd |
    macroLocation(f, macroStart, macroEnd) and
    globalLocation(gv, f, varStart, varEnd) and
    varStart >= macroStart and
    varEnd <= macroEnd
  )
}


Number of classes per file

from File f, int n
where
  f.fromSource() and
  n = count(Class c | c.getAFile() = f)
select f, n order by n desc


description Measures the amount of time (in milliseconds) spent
 compiling a C/C++ file, including time spent processing
 all files included by the pre-processor.

from string x, float t
where
  exists(Compilation c, int i |
    x = c.toString() + ":" + i.toString() and
    t = 1000 * c.getFrontendCpuSeconds(i) and
    c.getFileCompiled(i).fromSource()
  )
select x, t order by t desc


from File f
where f.fromSource()
select f, count(GlobalVariable gv | gv.getFile() = f and not inMacro(gv))
*/

/*
 * fname,nclasses,ntoplevfuncs,nusertypes,nlines,nLOC,ncomments,nincludes,asC,asCpp,startline,endline,file
 */


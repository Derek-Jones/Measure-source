/**
 * @id func-definition
 * @kind table
 */

/*
 * file-info.ql, 11 Nov 25
 */

import cpp

from File f
where
        not f.getFile() instanceof HeaderFile
select f.getShortName()+"."+f.getExtensions(),
		f.getMetrics().getNumberOfClasses(),
		f.getMetrics().getNumberOfTopLevelFunctions(),
		f.getMetrics().getNumberOfUserTypes(),
		f.getMetrics().getNumberOfLines(),
		f.getMetrics().getNumberOfLinesOfCode(),
		f.getMetrics().getNumberOfLinesOfComments(),
		count(f.getAnIncludedFile()),
		count(int dummy | dummy = 1 and f.compiledAsC() | dummy),
		count(int dummy | dummy = 1 and f.compiledAsCpp() | dummy),
		f.getLocation().getStartLine(), f.getLocation().getEndLine(), f.getRelativePath()

/*
Count the number of dependencies a C/C++ source file has on external libraries.

import ExternalDependencies

from File file, int num, string encodedDependency
where encodedDependencies(file, encodedDependency, num)
select encodedDependency, num order by num desc
*/

/*
 * fname,nclasses,ntoplevfuncs,nusertypes,nlines,nLOC,ncomments,nincludes,asC,asCpp,startline,endline,file
 */


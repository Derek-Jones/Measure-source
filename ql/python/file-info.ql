/**
 * @id file-info
 * @kind table
 */

/*
 * file-info.ql,  7 Nov 25
 */

import python

from Module m
select m.getName(),
		m.getMetrics().getNumberOfLines(), count(m.getAStmt()),
		count(m.getAnImportedModuleName()),
		count(Class c | c.getEnclosingModule() = m), // number of classes in a file
		count(Function f | f.getEnclosingModule() = m and f.getName() != "lambda") , // number of functions/methods in a file
		count(Stmt s | s.getEnclosingModule() = m), // value differs from count(m.getAStmt())
		count(m.getAnExport()),
		count(int dummy | dummy = 1 and m.inStdLib() | dummy),
		count(int dummy | dummy = 1 and m.isPackage() | dummy),
		count(int dummy | dummy = 1 and m.isPackageInit() | dummy),
		m.getLocation().getStartLine(), m.getLocation().getEndLine(), m.getLastStatement().getLocation().getEndLine(),
		"none", m.getFile()


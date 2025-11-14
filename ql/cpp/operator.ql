/**
 * @id operator
 * @kind table
 */

/*
 * operator.ql, 13 Nov 25
 */

import cpp

from Operation op
where
        not op.getFile() instanceof HeaderFile and
	not op.isCompilerGenerated()
select op.getOperator() as operator,
		op.getActualType() as optype,
		count(int dummy | dummy = 1 and op instanceof BinaryOperation | dummy) as binop,
		count(int dummy | dummy = 1 and op instanceof Assignment | dummy) as assign,
		count(int dummy | dummy = 1 and op instanceof ConditionalExpr | dummy) as condop,
		count(int dummy | dummy = 1 and op.isCondition() | dummy) as condition,
		count(int dummy | dummy = 1 and op.hasLValueToRValueConversion() | dummy) as lv_rv_conv,
		count(int dummy | dummy = 1 and op.isConstant() | dummy) as constant,
		count(int dummy | dummy = 1 and op.getFile().compiledAsCpp() | dummy) as cpp,
		op.getEnclosingFunction() as enclosefunc, op.getFile().getRelativePath() as filepath



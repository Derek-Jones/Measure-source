/**
 * @id method-chain
 * @kind table
 */

/*
 * method-chain.ql, 14 Nov 25
 */

import cpp

int mchain_len(Expr mc) {
   not mc instanceof Call and
      result = 0 or
   exists(Expr e | e=mc.(Call).getQualifier()) and
      result=mchain_len(mc.(Call).getQualifier())+
				count(int dummy | dummy = 1 and not mc.(Call).isCompilerGenerated() and
								not mc.(Call).getTarget().toString().regexpMatch("^operator[ =+*/%&|><!(\\[\\-].*") and
								not mc instanceof ConstructorCall | dummy)
/*
			not mc.(Call).mayBeFromImplicitlyDeclaredFunction() and
			not mc.(Call).hasImplicitConversion() and
*/
}

string mchain_seq(Expr mc) {
   not mc instanceof Call and
      result = "" or
   exists(Expr e | e=mc.(Call).getQualifier()) and
      result=mc.(Call).getTarget()+"()"+mchain_seq(mc.(Call).getQualifier())
}


from Call mc
where
        not mc.getFile() instanceof HeaderFile and
	not mc.isCompilerGenerated() and
	mchain_len(mc) > 0
select mc.getTarget() as mname, mchain_len(mc) as chainlen, mchain_seq(mc) as chainnames,
		mc.getParent() as parent,
		mc.getLocation().getStartLine() as startline, mc.getLocation().getEndLine() as endline,
		mc.getEnclosingFunction() as enclosingfunc, mc.getFile().getRelativePath() as filepath



/**
 * @id method-chain
 * @kind table
 */

/*
 * method-chain.ql, 12 Nov 25
 */

import cpp

int mchain_len(Expr mc) {
   not mc instanceof Call and
      result = 0 or
   exists(Expr e | e=mc.(Call).getQualifier()) and
      result=mchain_len(mc.(Call).getQualifier())+
				count(int dummy | dummy = 1 and not mc.(Call).isCompilerGenerated() and
								mc.(Call).getTarget().toString() != "operator->" and
								not mc instanceof ConstructorCall | dummy)
/*
								not mc.(Call).mayBeFromImplicitlyDeclaredFunction() and
								not mc.(Call).hasImplicitConversion() and
   exists(Expr e | e=mc.getChild(-1)) and
   result=mchain_len(mc.getChild(-1))+1
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
select mc.getTarget(), mchain_len(mc), mchain_seq(mc),
		mc.getParent(), mc.getLocation().getStartLine(), mc.getLocation().getEndLine(),
		mc.getEnclosingFunction(), mc.getFile().getRelativePath()


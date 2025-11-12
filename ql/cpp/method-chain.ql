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
								not mc.(Call).hasImplicitConversion() and
								not mc instanceof ConstructorCall | dummy)
/*
   exists(Expr e | e=mc.getChild(-1)) and
   result=mchain_len(mc.getChild(-1))+1
*/
}

string mchain_seq(Expr mc) {
   not mc instanceof Call and
      result = "" or
   exists(Expr e | e=mc.(Call).getQualifier()) and
      result=mc.(Call).getTarget()+"()"+mchain_seq(mc.(Call).getQualifier())
/*
   exists(Expr e | e=mc.getChild(-1)) and
   result=mc.getTarget()+mchain_len(mc.getChild(-1))
*/
}


/* Follow the receiver/base rather than the last argument. */
/*
Expr receiverOf(Call c) {
  result = c.getCalleeExpr().(Expr).getQualifier() // adjust per your target cases
  or
  result = c.getCalleeExpr().(MemberExpr).getBase()
}

int recv_chain_len(Expr e) {
  result =
    if e instanceof Call and exists(Call c | c = e and exists(Expr r | r = receiverOf(c)))
    then recv_chain_len(receiverOf(e as Call)) + 1
    else 0
}
*/


from Call mc
where
        not mc.getFile() instanceof HeaderFile and
	not mc.isCompilerGenerated() and
	mchain_len(mc) > 0
select mc.getTarget(), mchain_len(mc), mchain_seq(mc),
		mc.getParent(), mc.getLocation().getStartLine(), mc.getLocation().getEndLine(),
		mc.getEnclosingFunction(), mc.getFile().getRelativePath()


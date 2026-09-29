/**
 * @id meth-definition
 * @kind table
 */

/*
 * method-def.ql, 25 Sep 26
 */

import java


from Method meth
where
		meth.fromSource() and
                not meth.isCompilerGenerated()
select meth.getName() as mname,
                meth.getReturnType() as rettype,
                meth.getNumberOfParameters() as nparam,
                count(int dummy | dummy = 1 and exists(meth.getBody()) | dummy) as body,
                meth.getNumberOfLinesOfCode() as nLOC,
                meth.getNumberOfCommentLines() as ncomment,
                meth.getTotalNumberOfLines() as nlines,
                count(Call call | call.getEnclosingCallable() = meth) as ncall,  // Number of all calls (includes constructors and new) in this method
                count(MethodCall call | call.getEnclosingCallable() = meth) as nmcall,  // Number of method calls in this method
		// count(meth.getACallSite()) as ncall,   // Number of calls in this method
                count(meth.getAReference()) as ncalled,   // Number of calls to this method
                // count(MethodCall fc | fc.getMethod() = meth) as ncalled,  // Number of calls to this method
                count(Stmt s | s.getEnclosingCallable() = meth) as nstmt,  // Number of statements per method
                count(BlockStmt bs | bs.getEnclosingCallable() = meth) as nblkstmt,  // Number of block-statements per method
                count(IfStmt i | i.getEnclosingCallable() = meth) as nif,  // Number of if-statements per method
                count(SwitchStmt s | s.getEnclosingCallable() = meth) as nswitch,  // Number of while-statements per method
                count(ForStmt f | f.getEnclosingCallable() = meth) as nfor,  // Number of for-statements per method
                count(EnhancedForStmt f | f.getEnclosingCallable() = meth) as nenhancedfor,  // Number of for-statements per method
                count(WhileStmt w | w.getEnclosingCallable() = meth) as nwhile,  // Number of while-statements per method
                count(DoStmt d | d.getEnclosingCallable() = meth) as ndo,  // Number of do-statements per method
                count(ThrowStmt d | d.getEnclosingCallable() = meth) as nthrow,  // Number of try-statements per method
                count(TryStmt d | d.getEnclosingCallable() = meth) as ntry,  // Number of try-statements per method
                count(CatchClause d | d.getEnclosingCallable() = meth) as ncatch,  // Number of try-statements per method
                count(ExprStmt e | e.getEnclosingCallable() = meth) as nexprstmt,  // Number of expression-statements per method
                count(BreakStmt b | b.getEnclosingCallable() = meth) as nbreak,  // Number of break-statements per method
                count(ContinueStmt c | c.getEnclosingCallable() = meth) as ncontinue,  // Number of continue-statements per method
                count(ReturnStmt r | r.getEnclosingCallable() = meth) as nreturn,  // Number of return-statements per method
                count(EmptyStmt e | e.getEnclosingCallable() = meth) as nempty,  // Number of empty-statements per method
                count(LocalVariableDecl lv | lv.getEnclosingCallable() = meth) as nloclvar,  // Number of local variables
                // count(LocalClassDecl lv | lv.getMethod() = meth) as nloclclass,  // Number of local classes
                count(int dummy | dummy = 1 and meth.isAbstract() | dummy) as abstract,
                count(int dummy | dummy = 1 and meth.isDefault() | dummy) as default,
                count(int dummy | dummy = 1 and meth.isFinal() | dummy) as final,
                count(int dummy | dummy = 1 and meth.isInheritable() | dummy) as inheritable,
                count(int dummy | dummy = 1 and meth.isInline() | dummy) as inline,
                count(int dummy | dummy = 1 and meth.isLocal() | dummy) as local,
                count(int dummy | dummy = 1 and meth.isOverridable() | dummy) as overidable,
                count(int dummy | dummy = 1 and meth.isPrivate() | dummy) as private,
                count(int dummy | dummy = 1 and meth.isProtected() | dummy) as protected,
                count(int dummy | dummy = 1 and meth.isPublic() | dummy) as public,
                count(int dummy | dummy = 1 and meth.isStatic() | dummy) as static,
                count(int dummy | dummy = 1 and meth.isStrictfp() | dummy) as strictfp,
                count(int dummy | dummy = 1 and meth.isVirtual() | dummy) as virtual,
                meth.getBody().getLocation().getStartLine() as startline,
		meth.getBody().getLocation().getEndLine() as endline,
                meth.getFile().getRelativePath() as filepath

// mname,rettype,nparam,body,nLOC,ncomment,nlines,ncall,nmcall,ncalled,nstmt,nblkstmt,nif,nswitch,nfor,nenhancedfor,nwhile,ndo,nthrow,ntry,ncatch,nexprstmt,nbreak,ncontinue,nreturn,nempty,nloclvar,abstract,default,final,inheritable,inline,local,overidable,private,protected,public,static,strictfp,virtual,startline,endline,filepath
 

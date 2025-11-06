/**
 * @id calls-from-function
 * @kind table
 */

/*
 * call-graph.ql,  5 Nov 25
 */

import python

from Call fcall
select fcall.toString(), fcall.getPositionalArgumentCount(),
		fcall.getLocation().getStartLine(), fcall.getLocation().getEndLine(), fcall.getScope(), fcall.getLocation().getFile()

/*
 * called,arguments,startline,endline,function,file
 */

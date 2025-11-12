/**
 * @id def-use
 * @kind table
 */

/*
 * def-use.ql, 12 Nov 25
 */

import python
import analysis.DefinitionTracking

/*
external string selectedSourceFile();
*/

from NiceLocationExpr use, Definition defn, string kind
where
  defn = definitionOf(use, kind)
select use, defn, kind,
		use.getLocation().getStartLine(), use.getLocation().getEndLine(), use.getScope(), use.getLocation().getFile().getRelativePath()


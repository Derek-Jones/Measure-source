#
# codeql.sh,  3 Nov 25

CODECQ_DIR="/home/web/blog/codeql"
CQ_DIR="/home/Measure-source"

DBBASE=`basename $1`
QLBASE=`basename $2 .ql`

QL_DB="$QLBASE-$DBBASE"

# 1) Run the query against your DB -> produces a .bqrs
$CODECQ_DIR/codeql query run --database $CODECQ_DIR/db/$1 --output=$CQ_DIR/bqrs/$QL_DB.bqrs $2

# 2) Decode the results to something readable (prints to stdout)
$CODECQ_DIR/codeql bqrs decode $CQ_DIR/bqrs/$QL_DB.bqrs --format=csv --output=csv/$QL_DB.csv


# Scripts to measure source code

CodeQL scripts for extracting measurement data from C, C++, Python and Java projects.

Running these scripts requires installing the [command line version of CodeQL](https://github.com/github/codeql-cli-binaries/releases) and Java (to execute the CodeQL jar).

CodeQL works on project databases, which can be [built using CodeQL](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/preparing-your-code-for-codeql-analysis).

The CodeQL extension in Visual Studio Code can download project databases from GitHub.

The command `codeql.sh proj_db feature.ql` runs the CodeQL script +feature.ql+ on the contents of the database +proj_db+ to produce a csv file in the +csv+ directory.

This script invoke +codeql+ twice, once to create a bqrs file (an intermediate file used by CodeQL), from which the csv file is then generated.


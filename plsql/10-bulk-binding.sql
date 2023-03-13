/*
How Oracle executes PL/SQL code

Two engines that executes code:
1 - PL/SQL engine - all the procedural code (Loops, if-else, etc...)
2 - SQL engine - all the SQL statements

Binding - when variable is assigned in SQL statement and sends back to PL/SQL engine (Example: assigned in SQL INTO statement and sends back to IF)

Context switching - changing between PL/SQL and SQL engine. Impacts performance. (SQL in FOR LOOP statement 1000 times)

Bulk binding - concept to fewer context switching during execution

Types of binding:
1) In-bind - when INSERT, UPDATE or MERGE statements stores a PL/SQL or host variable in the DB
2) Out-bind - when the RETURNING INTO clause of an INSERT, UPDATE, or DELETE statements assigns a DB value to PL/SQL host variable
3) DEFINE - when SELECT or FETCH statements assign a DB value to a PL/SQL or host variable

To implement BULK BINDING we use:
1) FORALL (in-bind and out-bind)
2) BULK COLLECT (for DEFINE binding)
*/

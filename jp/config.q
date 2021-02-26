\l schema.q

/ this file generates a table of parameters which will be passed to tester.q to generated the full set of results
/ variables we are using include rowCount, symCount, columnCount, attribute application, complression algorithm, data at rest encryption
/ this script could be replaced with a single parameter set, or table of data

/ define param values and cross them to get set of inputs
/ number of rows to save
rowCounts:10 100 1000 100000;

/number of distinct syms which will be sorted / have p attr applied
symCount:10 100 1000 100000;

/ different compression params. no compression, compression only, encrpyp only, compress and encrypt
/compressionParams:((0 0 0);(17 2 6);(17;2+16;6);(17;16;6));
compressionParams:((0 0 0);(17 2 6));

/ count of columns in schema
columnCount:count cols trade;
/ g attributes set in schema file
attrs:exec (` sv'a,'c) from meta[trade] where not null a 

/ build configTable of all combinations of params to iterate through
params:{raze x,/:\:y} over (rowCounts;symCount;enlist each compressionParams;enlist columnCount);


/ build table of params which will be processed one at a time. 
/ We will not use parallelization in this application
configTable:flip `rowCount`symCount`compressionParams`columnCount!flip params;
configTable:update runId:"j"$.z.P,isEncrypted:0b,tableName:`trade,tableAttributes:count[configTable]#enlist attrs from configTable;

stdout "########################"
stdout "Loaded Config for tests:"
stdout "########################"


// test with encryption
/ data at rest encryption requires kdb4.0 and openssl 1.1.1
/ gen master key
/ openssl rand 32 | openssl aes-256-cbc -md SHA256 -salt -pbkdf2 -iter 50000 -out testkey.key
/ data will not load without the key loader
/ q)get `:db/2021.02.26/trade
/ 'db/2021.02.26/trade/sym. no key loaded for encrypted file db/2021.02.26/trade/sym

/ load key into q session
/-36!(`:testkey.key;"mypassword")
/compressionParams:((17;2+16;6);(17;16;6)); / compression with encrytion and encrpytion only 

/params:{raze x,/:\:y} over (rowCounts;symCount;enlist each compressionParams;enlist columnCount);
/
/configTable:flip `rowCount`symCount`compressionParams`columnCount!flip params;
/configTable:update runId:"j"$.z.P,isEncrypted:1b,tableName:`trade,tableAttributes:count[configTable]#enlist attrs from configTable;
/
/stdout "Parameters for tests:"
/show configTable



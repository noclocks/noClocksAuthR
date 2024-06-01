
This directory contains the JS front end code.  

The JS is written using ES5+ JS (modern Javascript), so, in order to be compatible with older browsers, we transpile it to ES3 before including it with noClocksAuthR.  The ES5+ JS is located in this "srcjs/src" directory.  We edit this code during development.  The transpiled ES3 code is saved into the "inst/assets/js" directory.  The transpiled code is what runs with noClocksAuthR.  The ES3 JS in "inst/assets/js" is not edited directly by hand.

To transpile the code run the following:

```
# terminal

npm run build
```

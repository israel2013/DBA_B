const {Pool} =require('pg');
const pool = new Pool({
    host:'localhost',
    port:'5432',
    user:'israelcastanedaluna',
    password:null,
    database:'teclag' 
})

module.exports=pool;
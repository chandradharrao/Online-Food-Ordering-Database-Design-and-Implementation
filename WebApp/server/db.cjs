require("dotenv").config();

const {Pool} = require("pg"); //set config

config_params={
    user:`${process.env.DBUSER}`,
    password:`${process.env.DBPASSWORD}`,
    database:`${process.env.DB}`,
    host:`${process.env.DBHOST}`,
    port:process.env.DBPORT
}

const pool = new Pool(config_params)
module.exports = {
    query:(text,params)=>pool.query(text,params),
};
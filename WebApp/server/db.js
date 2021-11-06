require("dotenv").config();

const Pool = require("pg").Pool; //set config
config_params={
    user=`${process.env.DBUSER}`,
    password:`${process.env.DBPASSWORD}`,
    database:`${pocess.env.DB}`,
    host:`${process.env.DBHOST}`,
    port:`${process.env.DBPORT}`
}
const pool = Pool(config_params)
module.exports = pool;
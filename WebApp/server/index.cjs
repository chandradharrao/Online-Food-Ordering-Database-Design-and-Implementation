const express = require("express");
const app = express();
app.use(express.json()); //parse incoming req to json
const pool = require("./db");

const PORT = process.env.PORT || 4000;

const insertInto = (tableName,columnNames,values)=>{
    /*pool.query('INSERT INTO users (name, email) VALUES ($1, $2)', [name, email], (error, results) => {
    if (error) {
      throw error
    } */
    const query=`INSERT INTO ${tableName} (${columnNames}) VALUES (${values});`;
    pool.query(query,(err,results)=>{
        if(err) throw err;
        else return results;
    })
}

app.post("/login",(req,res)=>{
    console.log(req.body);
    const isAdmin = req.body['isAdmin'];
    if(!isAdmin){
        const email = req.body["email"];
        const password=req.body["password"];
        if(!email || !password){
            res.status(422).json({error:"Please fil all fields"});
        }else{
            res.status(200).json({success:"Recieved all details"});
        }
    }
}) 

app.listen(PORT,()=>{
    console.log(`Running on PORT ${PORT}....`)
});
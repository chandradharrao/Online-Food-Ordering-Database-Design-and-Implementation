const express = require("express");
const app = express();
app.use(express.json()); //parse incoming req to json

const db = require("./db.cjs");

const PORT = process.env.PORT || 5000;

app.post("/login",async(req,res)=>{
    console.log(req.body);
    const isAdmin = req.body['isAdmin'];

    //If Customer Login
    if(!isAdmin){
        const email = req.body["email"];
        const password=req.body["password"];
        if(!email || !password){
            res.status(422).json({error:"Please fill all fields"});
        }else{
            //fetch from the database.  
            try{
                const result = await db.query("select * from Customer;");
                // console.log(result);
                if (result){
                    console.log(result['rows']);
                    all_enteries = result["rows"];
                    for(let i=0;i<all_enteries.length;i++){
                        let row = all_enteries[i];
                        const {cust_id,passkey,email_id,phone_num,last_name,first_name,address_id} = row;
                        //check if the username and passwords match
                        console.log(email_id,passkey);
                        if(email===email_id && password===passkey){
                            return res.status(200).json({success:"Successfull Login",details:{cust_id,phone_num,first_name,last_name}});
                        }
                    } 
                    //if not returned till now,then not in db
                    return res.status(200).json({error:"User not in DB"});
                }else{
                    console.log("Error");
                    console.log(result);
                    res.status(422).json({error:"Unable to fetch from DataBa!"});
                }
            }catch(err){
                console.log("Error");
                res.status(422).json({error:"Unable to fetch from DB!"});
            }
        }
    }else{
        //then user is admin
        //query database for all users
        //if user found in the database,login
        //else error
    }
}) 

app.post("/createAccount",async(req,res)=>{
    const r1 = db.query("INSERT ITNO Address (street_num,zip_code,building_num) VALUES ")
    const r2 = db.query("INSERT INTO Customer (passkey,email_id,phone_num,last_name,first_name,address_id)")
})

app.listen(PORT,()=>{
    console.log(`Running on PORT ${PORT}....`)
});
const express = require("express");
const app = express();
app.use(express.json()); //parse incoming req to json

const db = require("./db.cjs");

const PORT = process.env.PORT || 5000;

app.post("/login",async(req,res)=>{
    console.log(req.body);
    const isAdmin = req.body['isAdmin'];
    console.log(`IsAdmin? ${isAdmin}`);
    const email = req.body["email"];
    const password=req.body["password"];

    //If Customer Login
    if(!isAdmin){
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
                console.log(err);
                res.status(422).json({error:"Unable to fetch from DB!"});
            }
        }
    }else{
        //then user is admin
        if(!email || !password){
            return res.status(422).json({error:"No email or password"});
        }else{
            //query database for all admins
            try{
                const query_data = await db.query("select * from Restaurant_admin");
                console.log(query_data);
                let all_admins = query_data["rows"];
                console.log(all_admins);

                if(all_admins){
                    for(let admin of all_admins){  
                        const username=admin["email_id"];
                        const pass = admin["passkey"];
                        console.log(`Fetched username and password is ${username},${pass}`); 

                        if(username==email && pass==password){
                            return res.status(200).json({success:"user found!"});
                        }
                    }  

                    //if not returned till now user not found
                    return res.status(404).json({error:"user not found"});

                }else throw "Undefined variable all_Admins"; 
            }catch(err){
                console.log(err);
                return res.status(422).json({error:"Internal Server Error"});
            }
        }
    }
}) 

app.post("/createAccount",async(req,res)=>{
    //insert address
    const {street_num,zip_code,building_num}=req.body["address"];

    try{
        const address_result = await db.query("INSERT INTO Address (street_num,zip_code,building_num) VALUES ($1,$2,$3)",[street_num,zip_code,building_num]);

        if(address_result){
            const isAdmin = req.body['isAdmin'];
            if(isAdmin){
                //if user is admin,create admin account
                const {name,passkey,email_id,bank_number} = req.body["details"];

                try{
                    const admin_result = await db.qury("INSERT INTO Restaurant_admin (name,passkey,email_id,bank_number,address_id) VALUES ($1,$2,$3,$4,$5)",[name,passkey,email_id,bank_number,address_result["rows"][0]["id"]]);

                    if(admin_result){
                        return res.status(200).json({success:"Inserted admin into database"});
                    }else throw "Unable to INSERT INTO address table in db";
                }catch(err){
                    console.log(err);
                    return res.status(422).json({error:"Unable to insert admin into db"});
                }
            }else{
                //if user is customer create customer account
                const {passkey,email_id,phone_num,last_name,first_name} = req.body["details"];
                try{
                    const customer_result = await db.query("INSERT INTO Customer (passkey,email_id,phone_num,last_name,first_name,address_id) ($1,$2,$3,$4,$5,$6)",[passkey,email_id,phone_num,last_name,first_name,address_result["rows"][0]["id"]]);
    
                    if(customer_result){
                        return res.status(200).json({success:"Inserted Customer"});
                    }else throw "Unable to insert itno customer table";
                }catch(err){
                    res.status(422).json({error:"Unable to insert customer into db"});
                }
            }
        }else throw "address_result variable is undefined";
    }catch(err){
        res.status(422).json({error:"Unable to insert address into db"});
    }
})
  
app.listen(PORT,()=>{
    console.log(`Running on PORT ${PORT}....`)
});

app.get("/allRestraunts/:zipcode",(req,res)=>{
    //fetch all hotels details in the same zipcode
})
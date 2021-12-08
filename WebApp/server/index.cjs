const express = require("express");
const app = express();
app.use(express.json()); //parse incoming req to json
var cors = require("cors");
app.use(cors());

const db = require("./db.cjs");

const PORT = process.env.PORT || 5000;

app.post("/login", async (req, res) => {
  console.log(req.body);
  const isAdmin = req.body["isAdmin"] === "admin";
  console.log(`IsAdmin? ${isAdmin}`);
  const email = req.body["email"];
  const password = req.body["password"];

  //If Customer Login
  if (!isAdmin) {
    if (!email || !password) {
      res.status(422).json({ error: "Please fill all fields" });
    } else {
      //fetch from the database.
      try {
        const result = await db.query(
          "select * from Customer;"
        ); /* use where command to retrieve record */
        // console.log(result);
        if (result) {
          console.log(result["rows"]);
          all_enteries = result["rows"];
          for (let i = 0; i < all_enteries.length; i++) {
            let row = all_enteries[i];
            const {
              cust_id,
              passkey,
              email_id,
              phone_num,
              last_name,
              first_name,
              address_id,
            } = row;
            //check if the username and passwords match
            console.log(email_id, passkey);
            if (email === email_id && password === passkey) {
              return res.status(200).json({
                status: true,
                success: "Successfull Login",
                details: { cust_id, phone_num, first_name, last_name },
              });
            }
          }
          //if not returned till now,then not in db
          return res
            .status(200)
            .json({ status: false, error: "User not in DB" });
        } else {
          console.log("Error");
          console.log(result);
          res
            .status(422)
            .json({ status: false, error: "Unable to fetch from DataBa!" });
        }
      } catch (err) {
        console.log(err);
        res
          .status(422)
          .json({ status: false, error: "Unable to fetch from DB!" });
      }
    }
  } else {
    //then user is admin
    if (!email || !password) {
      return res.status(422).json({ error: "No email or password" });
    } else {
      //query database for all admins
      try {
        const query_data = await db.query("select * from Restaurant_admin");
        console.log(query_data);
        let all_admins = query_data["rows"];
        console.log(all_admins);

        if (all_admins) {
          for (let admin of all_admins) {
            const username = admin["email_id"];
            const pass = admin["passkey"];
            console.log(`Fetched username and password is ${username},${pass}`);

            if (username == email && pass == password) {
              return res
                .status(200)
                .json({ success: "user found!", details: admin });
            }
          }

          //if not returned till now user not found
          return res.status(404).json({ error: "user not found" });
        } else throw "Undefined variable all_Admins";
      } catch (err) {
        console.log(err);
        return res.status(422).json({ error: "Internal Server Error" });
      }
    }
  }
});

//http://localhost:5000/displayDishes/price=50
//http://localhost:5000/allRestraunts/zipcode=560061

app.get("/displayDishes/:price", async (req, res) => {
  console.log("Called display hotels....");
  const q_price = req.params.price.split("=")[1];
  console.log(q_price);

  try {
    const query_dishes = `select 
        dish_name,description 
        from dish 
        where price >= '${q_price}';`;
    // const query_hotels = "SELECT * FROM pg_catalog.pg_tables;";
    console.log(query_dishes);

    let all_dishes = await db.query(query_dishes);
    all_dishes = all_dishes["rows"];
    console.log(all_dishes);

    if (all_dishes) {
      return res
        .status(200)
        .json({ success: "Found dishes", dishes: all_dishes });
    } else {
      throw "Issues with searching in database";
    }
  } catch (err) {
    console.log(err);
    return res.status(404).json({ failure: "Internal server err" });
  }
});

// DISPLAY THE RESTAURANTS
app.get("/displayRest", async (req, res) => {
  console.log("Called display hotels....");

  try {
    const query_rest = `select 
        name 
        from restaurant_admin;`;

    console.log(query_rest);

    let all_rest = await db.query(query_rest);
    all_rest = all_rest["rows"];
    console.log(all_rest);

    if (all_rest) {
      return res
        .status(200)
        .json({ success: "Found Restaurants", restaurants: all_rest });
    } else {
      throw "Issues with searching in database";
    }
  } catch (err) {
    console.log(err);
    return res.status(404).json({ failure: "Internal server err" });
  }
});

// Sort restaurants by order
app.get("/orderRest", async (req, res) => {
  console.log("Called sort order display hotels....");

  try {
    const query_rest = `select ra1.name,T.num_orders
    from (select ra.id,COUNT(*) as num_orders
        from restaurant_admin ra
        inner JOIN order_details as o
        on o.restaurant_id=ra.id
        GROUP BY ra.id) as T
    inner JOIN restaurant_admin ra1
    on T.id=ra1.id
    order by T.num_orders desc;`;

    console.log(query_rest);

    let all_rest = await db.query(query_rest);
    all_rest = all_rest["rows"];
    console.log(all_rest);

    if (all_rest) {
      return res
        .status(200)
        .json({ success: "Sorted Restaurants", restaurants: all_rest });
    } else {
      throw "Issues with searching in database";
    }
  } catch (err) {
    console.log(err);
    return res.status(404).json({ failure: "Internal server err" });
  }
});

app.post("/createAccount", async (req, res) => {
  console.log("Creating account...");
  //insert address
  const { street_num, zip_code, building_num } = req.body["address"];

  try {
    const address_result = await db.query(
      "INSERT INTO Address (street_num,zip_code,building_num) VALUES ($1,$2,$3)",
      [street_num, zip_code, building_num]
    );

    if (address_result) {
      const isAdmin = req.body["isAdmin"];
      if (isAdmin) {
        //if user is admin,create admin account
        const { name, passkey, email_id, bank_number } = req.body["details"];

        try {
          const admin_result = await db.qury(
            "INSERT INTO Restaurant_admin (name,passkey,email_id,bank_number,address_id) VALUES ($1,$2,$3,$4,$5)",
            [
              name,
              passkey,
              email_id,
              bank_number,
              address_result["rows"][0]["id"],
            ]
          );

          if (admin_result) {
            return res
              .status(200)
              .json({ success: "Inserted admin into database" });
          } else throw "Unable to INSERT INTO address table in db";
        } catch (err) {
          console.log(err);
          return res
            .status(422)
            .json({ error: "Unable to insert admin into db" });
        }
      } else {
        //if user is customer create customer account
        const { passkey, email_id, phone_num, last_name, first_name } =
          req.body["details"];
        try {
          const customer_result = await db.query(
            "INSERT INTO Customer (passkey,email_id,phone_num,last_name,first_name,address_id) ($1,$2,$3,$4,$5,$6)",
            [
              passkey,
              email_id,
              phone_num,
              last_name,
              first_name,
              address_result["rows"][0]["id"],
            ]
          );

          if (customer_result) {
            return res.status(200).json({ success: "Inserted Customer" });
          } else throw "Unable to insert itno customer table";
        } catch (err) {
          res.status(422).json({ error: "Unable to insert customer into db" });
        }
      }
    } else throw "address_result variable is undefined";
  } catch (err) {
    res.status(422).json({ error: "Unable to insert address into db" });
  }
});

app.get("/allRestraunts/:zipcode", async (req, res) => {
  //fetch all hotels details in the same zipcode
  const q_zipcode = req.params.zipcode.split("=")[1];
  console.log(q_zipcode);
  console.log(typeof q_zipcode);

  try {
    const query_hotels = `select r.name,a.street_num,a.zip_code,a.building_num
        from restaurant_Admin r
        inner JOIN address a
        on r.address_id=a.id
        where a.zip_code='${q_zipcode}';`;
    console.log(query_hotels);

    let all_hotels = await db.query(query_hotels);
    all_hotels = all_hotels["rows"];
    if (all_hotels) {
      return res
        .status(200)
        .json({ success: "Found Hotels", hotels: all_hotels });
    } else {
      throw "Issues with searching in database";
    }
  } catch (err) {
    console.log(err);
    return res.status(404).json({ failure: "Internal server err" });
  }
});

app.listen(PORT, () => {
  console.log(`Running on PORT ${PORT}....`);
});

import React from 'react';
import { useState } from 'react';

const CreateAccount = ()=>{
    const address=[
        <div>
            <input type="text" placeholder="street number"></input>,
            <input type="text" placeholder="zip code"></input>,
            <input type="text" placeholder="building number"></input>
        </div>
    ];

    const admin=[
        <div>
            <input type="text" placeholder="Hotel Name"></input>
            <input type="text" placeholder="email-id"></input>
            <input type="password" placeholder="password"></input>
            <input type="text" placeholder="bank number"></input>
            {address}
        </div>
    ];

    const user=[
        <div>
            <input type="text" placeholder="email-id"></input>,
            <input type="text" placeholder="phone number"></input>,
            <input type="text" placeholder="first name"></input>,
            <input type="text" placeholder="last name"></input>
            {address}
        </div>
    ];

    //state to change betwen different account types
    const [isAdmin,setIsAdmin] = useState(false);

    return(
        <div>
            <div className="createAccountCard">
                <h1>Create {!isAdmin?"User":"Admin"} Account</h1>
                <button onClick={()=> setIsAdmin(!isAdmin)} >Are you {!isAdmin?"Admin":"User"}?</button>
                {isAdmin?admin:user}
                <button>Create Account</button>
            </div>
        </div>
    )
}

export default CreateAccount;
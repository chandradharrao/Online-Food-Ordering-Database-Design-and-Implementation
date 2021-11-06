import React from 'react';

const LoginForm = ()=>{
    return(
        <div>
            <div className="authcard">
                <h1>Login</h1>
                <input type="text" placeholder="email"></input>
                <input type="text" placeholder="password"></input>
                <button>Login</button>
            </div>
        </div>
    )
}

export default LoginForm;
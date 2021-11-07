import React from "react";
import axios from "axios";

class LoginForm extends React.Component{
    constructor(props){
        super(props);
        this.state={
            priviledge:"user",
            email_id:"email",
            passkey:"password",
            status:null,
        }
    };

    rememberMe(){
        let details = JSON.parse(localStorage.getItem("details"));
        if(details){
            this.setState({status:true});
            return true;
        }
        return false;
    }

    componentDidMount(){
        this.rememberMe();
    }

    handlePriviledge(e){
        this.setState({priviledge:e.target.value});
    }

    handleEmail(e){
        this.setState({email_id:e.target.value});
    }

    handlePassword(e){
        this.setState({passkey:e.target.value});
    }

    postData = async()=>{
        if(!this.rememberMe()){
            const url = "http://localhost:5000/login";
            const human={
                isAdmin:this.state.priviledge,
                email:this.state.email_id,
                password:this.state.passkey
            }

            try{
                const post_result = await axios.post(url,human);
                alert(JSON.stringify(post_result));
                const {status,details} = post_result.data;
                if(status){
                    alert("Successful login");
                    localStorage.setItem("details",JSON.stringify(details));
                    this.setState({status:true});
                }
            }catch(err){
                alert(err);
                this.setState({status:false});
            }
        }else{
            alert("Already logged in....");
        }
    }

    render(){
        let {priviledge,email_id,passkey,status} = this.state;
        return(
            <div>
                <input type="text" placeholder="email" value={email_id} onChange={(e)=>this.handleEmail(e)}></input>
                <input type="text" placeholder="password" value={passkey} onChange={(e)=>this.handlePassword(e)}></input>

                <fieldset onChange={this.handlePriviledge.bind(this)}>
                    <label><input type="radio" name="priviledge-option" value="admin" checked={priviledge==="admin"}/>Admin</label>

                    <label><input type="radio" name="priviledge-option" value="user" checked={priviledge==="user"}/>User</label>
                </fieldset>

                <button onClick={this.postData}>Login</button>
                {
                    status==true?"Successful login.....Browse Hotels":status==false?"Retry or create new account!":null
                }
            </div>
        )
    }
}

export default LoginForm;
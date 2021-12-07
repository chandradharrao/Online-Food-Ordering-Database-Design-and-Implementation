import React from "react";
import axios from "axios";

class Dishes extends React.Component{
    constructor(props){
        super(props);
        this.state={
            price:25,
            dishes:[]
        }
    }

    handleChange(e){
        // alert(e.target.value)
        this.setState({price:e.target.value});
    }

    submitIT= async()=>{
        const url = `http://localhost:5000/displayDishes/price=${this.state.price}`;

        try{
            const response = await axios.get(url);
            const dishes = response.data.dishes;
            this.setState({dishes:dishes});
            alert(JSON.stringify(this.state.dishes))
        }catch(err){
            alert("No dishes in locality");
            alert(err);
            console.log(err);
        }
    }

    render(){
        return(
            <div>
                <input type="text" className="price-box" placeholder="enter amount" value={this.state.price} onChange={(e)=>this.handleChange(e)}></input>
                <button onClick={this.submitIT}>Search</button>

                <div>
                    {
                        this.state.dishes.length>0?this.state.dishes.map((dish,i)=>{
                            return <div key={i}>{dish.dish_name},{dish.description}</div>
                        }):null
                    }
                </div>
            </div>
        )
    }
}

export default Dishes;
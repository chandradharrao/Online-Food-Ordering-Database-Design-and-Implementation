import React from "react";
import axios from "axios";

class Dishes extends React.Component{
    constructor(props){
        super(props);
        this.state={
            price:25,
            hotels:[]
        }
    }

    handleChange(e){
        // alert(e.target.value)
        this.setState({price:e.target.value});
    }

    submitIT= async()=>{
        const url = `http://localhost:5000/displayHotels/price=${this.state.price}`;

        try{
            const response = await axios.get(url);
            const hotels = response.data.hotels;
            this.setState({hotels:hotels});
        }catch(err){
            alert("No hotels in locality");
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
                        this.state.hotels.length>0?`${JSON.stringify(this.state.hotels)}`:null
                    }
                </div>
            </div>
        )
    }
}

export default Dishes;
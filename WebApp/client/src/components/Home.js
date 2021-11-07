import axios from "axios";
import React from "react";
import HotelCardGallery from "./HotelCardGallery";

class Home extends React.Component{
    state={
        cardData:[]
    }

    fetchData = async(zipcode)=>{
        const url = `http://localhost:5000/allRestraunts/zipcode=${zipcode}`;
        try{
            const response = await axios.get(url);
            const hotels = response.data.hotels;
            // alert(JSON.stringify(hotels[0]));
            this.setState({cardData:hotels})
        }catch(err){
            alert("No hotels in your surrounding!");
            alert(err);
        }
    }

    render(){
        return(
            <>
               <input type="text" className="search-bar" placeholder="enter zipcode" ></input>
                <button onClick={()=>this.fetchData("560061")}>Search For Food</button>
                <a href="/login">Admin ? </a>

                <>
                    {
                        this.state.cardData?<HotelCardGallery cardData={this.state.cardData} />:null
                    }
                </>
            </>
        )
    }
}

export default Home;
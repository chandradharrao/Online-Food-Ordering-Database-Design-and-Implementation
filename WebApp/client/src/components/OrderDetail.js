import axios from "axios";
import React from "react";

class OrderDetail extends React.Component{
    constructor(props){
        super(props);

        this.state={
            orders : [],
            first_name:'',
            last_name:''
        }
    }

    handleChangeFname = (e)=>{
        this.setState({first_name:e.target.value});
    }

    handleChangeLname = (e)=>{
        this.setState({last_name:e.target.value});
    }

    submitIt = async()=>{
        const url=`http://localhost:5000/getOrderDetails/first_name=${this.state.first_name}/last_name=${this.state.last_name}`;
        try{
            const response = await axios.get(url);
            const orders = response.data.orders;
            this.setState({orders:orders});
            alert(JSON.stringify(this.state.orders));
        }catch(err){
            alert(err);
        }
    }

    render(){
        return(
            <div>
                <input type="text" placeholder="first name" value={this.state.first_name} onChange={(e)=>this.handleChangeFname(e)}/>
                <input type="text" placeholder="last name" value={this.state.last_name} onChange={(e)=>this.handleChangeLname(e)}/>
                <button onClick={this.submitIt}>Retrieve</button>

                {
                    this.state.orders.length==0?null:this.state.orders.map((order,i)=>{
                        return <div key={i}>Order ID: {order.order_id},Cost:{order.total_amount},Order status:{order.status?"Delivered":"Not delivered"}</div>
                    })
                }
            </div>
        )
    }
}

export default OrderDetail;
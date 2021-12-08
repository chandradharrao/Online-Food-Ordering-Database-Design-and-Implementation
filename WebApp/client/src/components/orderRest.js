import React from "react";
import axios from "axios";

class OrderRestaurants extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      rests: [],
    };
  }

  submitIT = async () => {
    const url = `http://localhost:5000/orderRest`;

    try {
      const response = await axios.get(url);
      const rests = response.data.restaurants;
      this.setState({ rests: rests });
      alert(JSON.stringify(this.state.rests));
    } catch (err) {
      alert("No restaurants in locality");
      alert(err);
      console.log(err);
    }
  };

  render() {
    return (
      <div>
        <button onClick={this.submitIT}>Search</button>

        <div>
          {this.state.rests.length > 0
            ? this.state.rests.map((rest, i) => {
                return (
                  <div key={i}>
                    {i + 1}. {rest.name} - {rest.num_orders}
                  </div>
                );
              })
            : null}
        </div>
      </div>
    );
  }
}

export default OrderRestaurants;

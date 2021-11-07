import React from 'react';

const HotelCard = ({aHotel}) =>{
    // alert(JSON.stringify(aHotel))
    const {name,street_num,zip_code,building_num} = aHotel;

    return(
        <div>
            <h1>{name}</h1>
            <h3>{street_num}</h3>
            <h3>{zip_code}</h3>
            <h3>{building_num}</h3>
        </div>
    )
}

export default HotelCard;
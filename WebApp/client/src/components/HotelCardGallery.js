import React from 'react';
import HotelCard from './HotelCard';

const HotelCardGallery = ({cardData}) =>{   
    //alert(`cardData ${cardData}`);
    return(
        <div>
            {
                cardData.length!=0?cardData.map((aHotel,i)=>{
                    return <HotelCard key={i} aHotel={aHotel}/>
                }):"Search for hotels nearby!"
            }
        </div>
    )
}

export default HotelCardGallery;
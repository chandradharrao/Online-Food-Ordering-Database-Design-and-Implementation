import React, { useState } from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import LoginForm from "./components/LoginForm";
import CreateAccount from "./components/CreateAccount";
import Home from "./components/Home";
import Dishes from "./components/Dishes";
import Restaurants from "./components/Restaurants";
import OrderRestaurants from "./components/orderRest";

function App() {
  const [user, setUser] = useState({ name: "", email: "" });

  return (
    <BrowserRouter>
      <Navbar />
      <Routes>
        <Route path="/restOrder" element={<OrderRestaurants />} />
        <Route path="/restShow" element={<Restaurants />} />
        <Route path="/itemsShow" element={<Dishes />} />
        <Route path="/login" element={<LoginForm />} />
        <Route path="/createAccount" element={<CreateAccount />} />
        <Route path="/" element={<Home />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;

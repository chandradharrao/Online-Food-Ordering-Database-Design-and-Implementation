import React from "react";

const logout = () => {
  alert("Logging out....");
  localStorage.clear();
};

const Navbar = () => {
  return (
    <div>
      <li>
        <a href="/">Home</a>
      </li>
      <li>
        <a href="/login">Login</a>
      </li>
      <li>
        <a href="/itemsShow">Dishes Display</a>
      </li>
      <li>
        <a href="/restShow">Restaurants Display</a>
      </li>
      <li>
        <a href="/createAccount">Create Account</a>
      </li>
      <button onClick={logout}>Logout?</button>
    </div>
  );
};

export default Navbar;

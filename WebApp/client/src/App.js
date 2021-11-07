import React,{useState} from 'react';
import {BrowserRouter,Route,Routes} from 'react-router-dom';
import Navbar from './components/Navbar';
import LoginForm from './components/LoginForm';
import CreateAccount from './components/CreateAccount';
import Home from './components/Home';

function App() {
  const testUser={
    email:"test@test.com",
    password:"test123"
  }

  const [user,setUser] = useState({name:"",email:""});

  return (
    <BrowserRouter>
      <Navbar/>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/createAccount" element={<CreateAccount/>} />
        <Route path="/login" element= {<LoginForm/>} />
      </Routes>
    </BrowserRouter>

  );
}

export default App;

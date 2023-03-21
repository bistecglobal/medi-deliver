/* eslint-disable @next/next/no-img-element */
import styles from './login-form.module.css';
import { Button } from 'antd';
import axios from 'axios';
import React,{useState} from 'react';
import { useRouter } from 'next/router';

/* eslint-disable-next-line */
export interface LoginFormProps {}

export function LoginForm(props: LoginFormProps) {
  const [emailval,setemailval]= useState("");
  const [passway,setpassval]= useState("");

  const navigate = useRouter();

  const setEmailVal = (value:any) =>{
      setemailval(value);
  };
  const setPassVal = (value:any) =>{
    setpassval(value);
};
const handleSave =(e)=>{
  e.preventDefault();
  const data ={
    UserName : emailval,
    Password : passway
  };

  const url ='http://localhost:7117/api/Function1';
  axios.post(url,data).then((result)=>{
      console.log(result)
      navigate.push('/home');
     
    
  
  }).catch((error)=>{
    alert(error);
  });

}
  
  return (
    <div className={styles['main']}>
      <div className={styles["sub-main"]}>
          <div>
            <div className={styles["imgs"]}>
              <div className={styles["container-image"]}>
                <img src={"/bg.png"} alt="profiles"  className={styles["profile"]}/>
                <img src={"/app.jpg"} alt="profiles" className={styles["profiles"]}/>
              </div>
   
   
            </div>
            <div>
              <h1 className={styles["h1"]}>Login Page Medical App</h1>
              <div>
                {/* <img src={email} alt="email" className="email"/> */}
                <input type="text" placeholder="user name" className={styles["name"]} value={emailval}
                onChange={(e)=>{setEmailVal(e.target.value)}}/>
              </div>
              <div className={styles["second-input"]}>
                {/* <img src={pass} alt="pass" className="email"/> */}
                <input type="password" placeholder="password" className={styles["name"]}
                 value={passway} onChange={(e)=>{setPassVal(e.target.value)}}/>
              </div>
             <div className={styles["login-button"]}>
             <Button className={styles["button"]} onClick={(e)=> handleSave(e)}>Login</Button>
             </div>
              
              
              
    
            </div>
          </div>
          
   
        </div>
         

     </div>
  );
}

export default LoginForm;

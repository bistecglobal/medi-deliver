
import Head from 'next/head';

import LoginForm from '../components/login-form/login-form';

export function Index() {
  
  return (
    <div>
    <LoginForm/>
  
   </div>
  );
}

Index.getLayout = function getLayout(LoginPage) {
  return (
    <div>
    {LoginPage}
    </div>
  )
}

export default Index;

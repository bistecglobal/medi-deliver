import React from 'react'
import DashBoard from '../components/dash-board/dash-board'



export default function RootLayout({ children }) {
    return (
        <div>
           <DashBoard/>
           <main>{children}</main> 
           
        </div>
    );
}

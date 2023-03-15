import React from 'react'
import DashBoard from '../components/dash-board/dash-board'



export default function RootLayout({ children }) {
    return (
        <div>
            
           <main>{children}</main> 
           
        </div>
    );
}

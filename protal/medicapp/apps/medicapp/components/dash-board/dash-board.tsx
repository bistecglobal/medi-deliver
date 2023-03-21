/* eslint-disable react/jsx-no-undef */
/* eslint-disable @nrwl/nx/enforce-module-boundaries */
/* eslint-disable jsx-a11y/alt-text */
import { Layout,theme } from 'antd';
import Sider from 'antd/es/layout/Sider';
import styles from './dash-board.module.css';
import { BellFilled, MailOutlined } from "@ant-design/icons";
import { Badge,  Image, Space, Typography } from "antd";
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  AppstoreOutlined,
  ShopOutlined,
  ShoppingCartOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { Menu } from "antd";
import { useRouter } from "next/navigation";
import { Route, Router, Routes } from 'react-router-dom';
import React, { useState } from 'react';
import { start } from 'repl';

/* eslint-disable-next-line */
export interface DashBoardProps {}

export function DashBoard({ children }) {


  const navigate = useRouter();
  const { Header, Footer, Sider, Content } = Layout;

  const [collapsed, setCollapsed] = useState(false);
  const {
    token: { colorBgContainer },
  } = theme.useToken();
   


  return (
    <div className={styles['container']}>
      <Layout>
      <Header className={styles["AppHeader"]} >
      <Image width={60}  src={"/download.png"} style={{paddingLeft:20}} ></Image>
      <div className={styles['trigger']}>
      {React.createElement(collapsed ? MenuUnfoldOutlined : MenuFoldOutlined, {
            
            onClick: () => setCollapsed(!collapsed),
          })}
          </div>
      <Typography.Title style={{color:'white',paddingRight:350}}>Medical Dashboard</Typography.Title>
      <Space>
        <Badge  dot>
          <MailOutlined
            style={{ fontSize: 24 }}  />
        </Badge>
        <Badge>
          <BellFilled
            style={{ fontSize: 24 }} />
        </Badge>
      </Space>
      </Header>
      <Layout>
        <Sider className={styles["SideMenu"]} trigger={null} collapsible collapsed={collapsed}>
        <Menu
        //  theme="dark"
         defaultSelectedKeys={['1']}
        className={styles["SideMenuVertical"]}
        mode="vertical"
        onClick={(item) => {
          //item.key
          navigate.push(item.key);
        }}
       
        items={[
          {
            label: "Dashboard",
            icon: <AppstoreOutlined />,
            key: "/home",
          },
          {
            label: "Location",
            key: "/location",
            icon: <ShopOutlined />,
          },
          {
            label: "ManageOrders",
            key: "/orders",
            icon: <ShoppingCartOutlined />,
          },
          {
            label: "Customers",
            key: "/customers",
            icon: <UserOutlined />,
          },
        ]}
      ></Menu>
        </Sider>
        <Content >
            {children}
        </Content>
      </Layout>
      <Footer className={styles["AppFooter"]} >
        
      <Typography.Link href="tel:+123456789" style={{color:'white'}}>+123456789</Typography.Link>
      <Typography.Link href="https://www.google.com" target={"_blank"} style={{color:'white'}}>
        Privacy Policy
      </Typography.Link>
      <Typography.Link href="https://www.google.com" target={"_blank"} style={{color:'white'}}>
        Terms of Use
      </Typography.Link>
      </Footer>
    </Layout>
    </div>
  );
}

export default DashBoard;

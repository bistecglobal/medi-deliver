/* eslint-disable react/jsx-no-undef */
/* eslint-disable @nrwl/nx/enforce-module-boundaries */
/* eslint-disable jsx-a11y/alt-text */
import { Layout } from 'antd';
import Sider from 'antd/es/layout/Sider';
import styles from './dash-board.module.css';
import { BellFilled, MailOutlined } from "@ant-design/icons";
import { Badge,  Image, Space, Typography } from "antd";
import {
  AppstoreOutlined,
  ShopOutlined,
  ShoppingCartOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { Menu } from "antd";
import { useRouter } from "next/navigation";
import { Route, Router, Routes } from 'react-router-dom';

/* eslint-disable-next-line */
export interface DashBoardProps {}

export function DashBoard({ children }) {
  

  
  const navigate = useRouter();
  const { Header, Footer, Sider, Content } = Layout;
  return (
    <div className={styles['container']}>
      <Layout>
      <Header className={styles["AppHeader"]}>
      <Image width={40}  src={"/download.png"} ></Image>
      <Typography.Title style={{color:'white'}}>Medical Dashboard</Typography.Title>
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
        <Sider className={styles["SideMenu"]}>
        <Menu
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
        
      <Typography.Link href="tel:+123456789">+123456789</Typography.Link>
      <Typography.Link href="https://www.google.com" target={"_blank"}>
        Privacy Policy
      </Typography.Link>
      <Typography.Link href="https://www.google.com" target={"_blank"}>
        Terms of Use
      </Typography.Link>
      </Footer>
    </Layout>
    </div>
  );
}

export default DashBoard;

/* eslint-disable react/jsx-no-undef */
/* eslint-disable react-hooks/rules-of-hooks */
import './styles.css';
import React, { useEffect } from 'react'
import { Button, Table, Modal, Input, Form, Space, DatePicker, Select,Upload, Statistic, message, Tag, Card } from "antd";
import { useState } from "react";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import {PlusOutlined} from '@ant-design/icons/lib/icons'
import { LoadingOutlined} from '@ant-design/icons';
import { UploadOutlined } from '@ant-design/icons';
import { TimePicker } from 'antd';
import type { Dayjs } from 'dayjs';
import axios from 'axios';



const orders = () => {

    
    const selectStatus =['Active',"Processing","Delivered","Canceled"]
    const [firstval,setfirstnameval]= useState("");
    const [startdate, setDateS] = React.useState(false);
    const [imageUrl, setimageurl] = useState(null);
    const [loading, setLoading] = useState(false);
    const [timeval,settimeval]= useState("");
  const [addressval,setemailval]= useState("");
  const [statusval,setselectstatus]= useState("");
  const [timevalue, settimevalue] = React.useState(false);



function setStartDate(startdate, dateString) {
    setDateS(dateString);
  }
  
  const setFirstNameVal = (value:any) =>{
    setfirstnameval(value);
};

  const setAddVal = (value:any) =>{
      setemailval(value);
  };
//   const setTimeVal = (value:any) =>{
//     settimeval(value);
// };
const onChangeTime = (time,timeString) => {
  settimevalue(timeString);
};
const setSelectStatus = (value) =>{
    setselectstatus(value);
};

const setImageUrl = async (info) => {
  if (info.file.status === "done") {
    // const url = URL.createObjectURL(info.file.originFileObj);
    // console.log(info.file);
    // setimageurl(url);
    const file = info.file.originFileObj;
    console.log(file);
    // const blob = new Blob([file], { type: file.type });
    setimageurl(file)
    
  }
  
};


const [dataSource, setDataSource] = useState([
  {
    Id:firstval,
    Date:startdate,
    Time:timevalue,
    Address:addressval,
    Image:imageUrl,
    Status:statusval
  },
]);

    const [isEditing, setIsEditing] = useState(false);
  const [editingPatient, setEditingPatient] = useState(null);
  
  const columns = [
    {
      key: "1",
      title: "Order ID",
      dataIndex: "Id",
    },
    {
      key: "2",
      title: "Date",
      dataIndex: "Date",
    },
    {
      key: "3",
      title: "Time",
      dataIndex: "Time",
    },
    {
      key: "4",
      title: "Address",
      dataIndex: "Address",
    },
    {
        key: "5",
        title: "Prescription",
        dataIndex: "Image",
        
    },
      {
        key: "6",
        title: "Status",
        dataIndex:"Status",
      render:(tag)=>{
        const color =tag.includes('Active')?'#2692df':tag.includes('Processing')?"#3addaa":tag.includes('Delivered')?"#d05f5f"
        :tag.includes('Cancled')?"rgba(0, 0, 0, 0.19)":"White"
        return <Tag color={color} key={tag}>{tag}</Tag>
      }
    },
      
    {
      key: "7",
      title: "Actions",
      render: (record) => {
        return (
          <>
      
            <EditOutlined
              onClick={() => {
                onEditPatient(record) 
              }}   
            />
             
            <DeleteOutlined
              onClick={() => {
                onDeletePatient(record.Id);
              }}
              style={{ color: "red", marginLeft: 12 }}
            />
          </>
        );
      },
    },
  ];

  const onEditPatient = (record) => {
    setIsEditing(true);
    setEditingPatient({ ...record });
  };
  const resetEditing = () => {
    setIsEditing(false);
    setEditingPatient(null);
  };
 
  const handleSave = async (e:React.MouseEvent<HTMLButtonElement, MouseEvent>)=>{
    e.preventDefault();
    const newPaient ={
      Id:firstval,
      Date: startdate,
      Time: timevalue,
      Address:addressval,
      Image:imageUrl.name,
      Status:statusval
      
    }
   
    setDataSource(pre=> {
        return [...pre,newPaient];
      });


      const formData = new FormData();
      formData.append("Image", imageUrl, imageUrl.name);
  
      const response = await fetch("http://localhost:7117/api/FileUpload", {
        method: "POST",
        body: formData,
      });
     
      if (response.ok) {
        console.log("Image uploaded successfully!");
        const data1 = await response.json();
        setimageurl(data1.fileUrl);

        const data ={
          Date:startdate,
          Time:timevalue,  
          Address:addressval,
          Image:data1.fileUrl,
          Status:statusval
         
        };

        console.log('Updated Data:', data);
       
        console.log("abc",data)
        const url ='http://localhost:7117/api/SaveOrders';
        axios.post(url,data).then((result)=>{
        
           alert(result.data)
      
        }).catch((error)=>{
          alert(error);
        });
       
        
      } else {
        console.log("Image upload failed.");
      }
      
//post data
 

  // const data2 ={
  //   Image:imageUrl,
  // }
  // const formData = new FormData();
  // formData.append("Image",imageUrl);
  // // formData.append("Name","Nalin");

  // const url2 ='http://localhost:7117/api/FileUpload';
  // // axios.post(url2,data2).then((result)=>{
  // //   alert(result.data)
  // // }).catch((error)=>{
  // //   alert(error);
  // // });
  // fetch(url2, {
  //   method: 'POST',
  //   body: formData
  // })
    
  //  .catch((error)=>{
  //   alert(error)
  //  })
 
    
 

    
    
}


const [totalPages, setTotalPages] =useState(1);
const [loadingg, setLoadingg] =useState(false);
const [results,setresult] = useState("")

//get data
useEffect(()=>{
  getData(1);
},[])

const getData =async(page:number) =>{
  setLoadingg(true)
  const result = await  axios.get('http://localhost:7117/api/GetOrder?pageSize=10&PageNumber=1');
  console.log(result.data)
  setDataSource(result.data)
  
  setTotalPages(10);
  setLoadingg(false);
 }
 


  const onDeletePatient = (record) => {
    Modal.confirm({
      title: "Are you sure, you want to delete this Patient record?",
      okText: "Yes",
      okType: "danger",
      onOk: () => {
        setDataSource((pre) => {
          return pre.filter( (student) => student.Id !== record);
         
        });
        
        axios.delete(`http://localhost:7117/api/Order/${record}`)
       
        
      },
    });
  };

  // async function updateOrder(orderId, updatedOrder) {
  //   try {
  //     const result = await axios.put(`http://localhost:7117/api/UpdateOrder/${orderId}`, updatedOrder);
  //     console.log(result.data);
  //     // TODO: Update the table data in the frontend.
  //   } catch (err) {
  //     console.error(err);
  //     alert('Failed to update the order.');
  //   }
  // }
  const handleUpdateOrder = async (orderId, updatedOrder) => {
    try {
      const response = await axios.put(`http://localhost:7117/api/UpdateOrder/${orderId}`, updatedOrder);
      console.log(response.data);
      alert('Order updated successfully.');
      // TODO: Update the table data in the frontend.
    } catch (err) {
      console.error(err);
      alert('Failed to update the order.');
    }
  };
  
    return (
      <div >
        <div>
    <Form  className='container'>
     
    <Form.Item>
   <h1 style={{fontWeight:'bold',paddingTop:30,fontSize:20, paddingLeft:20}}>Manage Orders</h1>
  </Form.Item>
  <div style={{ paddingLeft:100}}>
 
     <Space align="center" size={20} style={{paddingTop:20}}>
     
    <p>Date</p>
     <Space>
     <div ><DatePicker onChange={setStartDate}/></div>
     </Space>
  
    
     </Space>
     
     <Space align="center"> 
     
     <p className='time'>Time</p>
      <TimePicker   onChange={onChangeTime}  />
     
      <p>Address</p>
      <Form.Item style={{paddingTop:22}}
       rules={[
        {
          required:true,
          message:"Address is required"
        }
      ]}
       >
      <Input placeholder='Address' value={addressval} 
       onChange={(e)=>{setAddVal(e.target.value)}} style={{width:160}}/>
      </Form.Item>
      
      <p>Status</p>
      <Select   placeholder='Select Course' style={{width:160}} value={statusval} onChange={(value) => {setSelectStatus(value) }}  >
        {selectStatus.map((Status,index)=>{ 
         return  <Select.Option 
         key ={index}  value={Status}>{Status}    </Select.Option> 
        })}
      </Select>
      
      <p>Upload Picture</p>
      <Form.Item>
      <Upload.Dragger listType="picture" onChange={setImageUrl}  >
        Drag Files Or
        <br/>
        <Button>Click Upload</Button>
      </Upload.Dragger>
      {/* {imageUrl && <img src={imageUrl} alt="uploaded"  style={{ width: '100%' }} />} */}
     
      </Form.Item>
      
      
      
      
      </Space>
      
      
     <Form.Item >
      <Button style={{display:'flex',justifyContent:'center'}} htmlType="submit" icon={<PlusOutlined/>} type="primary"   onClick={(e)=>{ handleSave(e) }} > Add a Order</Button>
     </Form.Item>
     </div>
    
     </Form>
     </div>
     

     




        <header className="App-header">
        {/* <Button onClick={onAddStudent}>Add a new Student</Button> */}
        <Table loading={loadingg} columns={columns} dataSource={dataSource} style={{paddingTop:30}}
        pagination={{
          pageSize:5,
          total:totalPages,
          onChange:(page)=>{
            getData(page=1)
          }
         }} 
        ></Table>
        <Modal
          title="Edit Patient"
          open={isEditing}
          okText="Save"
          onCancel={() => {
            resetEditing();
          }}
          onOk={() => {
            setDataSource((pre) => {
              return pre.map((patient) => {
                console.log(patient.Id)
                
                if (patient.Id === editingPatient.Id) {
                  return editingPatient;
                } else {
                  return patient;
                }
              });
            });
            resetEditing();
          }}
        >
          <p>Date of Order</p>
          <DatePicker
              onChange={(date, dateString) =>
                setEditingPatient({ ...editingPatient, date: dateString })
              }
              
            />
          <p>Order Time </p>
          <Input
            value={editingPatient?.time}
            onChange={(e) => {
              setEditingPatient((pre) => {
                return { ...pre, time: e.target.value };
              });
            }}
          />
          <p>Address Of the Patient</p>
          <Input
            value={editingPatient?.address}
            onChange={(e) => {
              setEditingPatient((pre) => {
                return { ...pre, address: e.target.value };
              });
            }}
          />
          <p>Status Of the Order</p>
         <Select
          value={editingPatient?.status}
          onChange={(status) => {
            setEditingPatient((pre) => ({
              ...pre, status
            }));
          }}
>
  {selectStatus.map((status) => {
    return (
      <Select.Option key={status} value={status}>
        {status}
      </Select.Option>
    );
  })}
</Select>
          <p>Image of the Order</p>
          {/* <img src={"/medi.jpg"} alt="profiles" style={{position:"relative",top:"0",left:"30",right:"20"}}/> */}
          {/* {imageUrl && <img src={imageUrl} alt="uploaded"  style={{ width: '100%' }} />} */}
         
         <img src={getData[editingPatient]} alt="order" style={{ width: '100%' }} />
        
 
        
        </Modal>
      </header>
      </div>
       
 
       )
        }



export default orders
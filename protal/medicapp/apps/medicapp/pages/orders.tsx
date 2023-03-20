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


//   const [data , setData2] =useState([{
//     FirstName:firstval,
//     StartDate: startdate,
//     EmailAddress:addressval,
//     Time: timeval,
//     Status: statusval,
//   }]);

//   const setFirstNameVal = (value:any) =>{
//     setfirstnameval(value);
// };
function setStartDate(startdate, dateString) {
    setDateS(dateString);
  }
  
 

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

const setImageUrl = (info) => {
  if (info.file.status === "done") {
    const url = URL.createObjectURL(info.file.originFileObj);
    setimageurl(url);
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



// const handleUpload = (info) => {
//     if (info.file.status === 'uploading') {
       
//       setLoading(true);
//       return;
//     }
//     if (info.file.status === 'done') {
//       // Get the image URL and log it to the console
//       setImageUrl(info.file.response.url);
//       console.log(info.file.response.imageUrl);
//       message.success(`${info.file.name} uploaded successfully`);
//     }
//     if (info.file.status === 'error') {
//       setLoading(false);
//       message.error('Error uploading image');
//     }
//   };

//   const uploadButton = (
//     <div>
//       {loading ? <LoadingOutlined /> : <PlusOutlined />}
//       <div style={{ marginTop: 8 }}>Upload</div>
//     </div>
//   );

// const uploadProps = {
//     name: 'image',
//     action: 'https://www.mocky.io/v2/5cc8019d300000980a055e76', // replace with your upload URL
//     showUploadList: false,
//     onChange: handleUpload,
//   };

//   const renderUploadButton = () => (
//     <div>
//       {loading ? <LoadingOutlined /> : <PlusOutlined />}
//       <div style={{ marginTop: 8 }}>Upload</div>
//     </div>
//   );




 

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
                onEditPatient(record);
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
 
  const handleSave =(e:React.MouseEvent<HTMLButtonElement, MouseEvent>)=>{
    e.preventDefault();
    const newPaient ={
      Id:firstval,
      Date: startdate,
      Time: timevalue,
      Address:addressval,
      Image:imageUrl,
      Status:statusval
      
    }
   
    setDataSource(pre=> {
        return [...pre,newPaient];
      });
      
//post data
  const data ={
    Date:startdate,
    Time:timevalue,
    Address:addressval,
    Status:statusval
   
  };

  console.log("abc",data)
  const url =`${process.env.NEXT_PUBLIC_BASE_URL}api/SaveOrders`;
  axios.post(url,data).then((result)=>{
  
     alert(result.data)

  }).catch((error)=>{
    alert(error);
  });

  // const data2 ={
  //   Image:imageUrl,
  // }
  const formData = new FormData();
  formData.append("Image",imageUrl);
  formData.append("Name","Nalin");

  const url2 =`${process.env.NEXT_PUBLIC_BASE_URL}api/FileUpload`;
  // axios.post(url2,data2).then((result)=>{
  //   alert(result.data)
  // }).catch((error)=>{
  //   alert(error);
  // });
  fetch(url2, {
    method: 'POST',
    body: formData
  })
    
   .catch((error)=>{
    alert(error)
   })
    
}


const [totalPages, setTotalPages] =useState(1);
const [loadingg, setLoadingg] =useState(false);

//get data
useEffect(()=>{
  getData(1);
},[])

const getData =async(page:number) =>{
  setLoadingg(true)
  const result = await  axios.get(`${process.env.NEXT_PUBLIC_BASE_URL}api/GetOrder?pageSize=10&PageNumber=1`);
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
          // (student) => student.Id !== record.Id)
        });
        
        axios.delete(`${process.env.NEXT_PUBLIC_BASE_URL}api/Order/${record}`)
       
        
      },
    });
  };
  const onEditPatient = (record) => {
    setIsEditing(true);
    setEditingPatient({ ...record });
  };
  const resetEditing = () => {
    setIsEditing(false);
    setEditingPatient(null);
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
      <Upload.Dragger listType="picture" onChange={setImageUrl} >
        Drag Files Or
        <br/>
        <Button>Click Upload</Button>
      </Upload.Dragger>
      {/* {imageUrl && <img src={imageUrl} alt="uploaded"  style={{ width: '100%' }} />} */}
     
      </Form.Item>
      
      {/* <Upload
      name="avatar"
      listType="picture-card"
      className="avatar-uploader"
      showUploadList={false}
      action="/api/uploadImage"
      onChange={handleUpload}
    >
      {imageUrl ? (
        <img src={imageUrl} alt="avatar" style={{ width: '100%' }} />
      ) : (
        uploadButton
      )}
    </Upload> 
    
    <Upload {...uploadProps}>
        {imageUrl ? (
          <img src={imageUrl} alt="uploaded image" style={{ maxWidth: 200 }} />
        ) : (
          renderUploadButton()
        )}
      </Upload> */}
      
      
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
          visible={isEditing}
          okText="Save"
          onCancel={() => {
            resetEditing();
          }}
          onOk={() => {
            setDataSource((pre) => {
              return pre.map((patient) => {
                if (patient.Id === editingPatient.id) {
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
          {imageUrl && <img src={imageUrl} alt="uploaded"  style={{ width: '100%' }} />}
        
        </Modal>
      </header>
      </div>
       
 
       )
        }



export default orders
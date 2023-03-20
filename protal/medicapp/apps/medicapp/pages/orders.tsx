/* eslint-disable react/jsx-no-undef */
/* eslint-disable react-hooks/rules-of-hooks */
import React from 'react'
import { Button, Table, Modal, Input, Form, Space, DatePicker, Select,Upload, Statistic, message, Tag } from "antd";
import { useState } from "react";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import {PlusOutlined} from '@ant-design/icons/lib/icons'
import { LoadingOutlined} from '@ant-design/icons';
import { UploadOutlined } from '@ant-design/icons';
import { TimePicker } from 'antd';
import type { Dayjs } from 'dayjs';


const orders = () => {

    
    const selectStatus =['Active',"Processing","Delivered","Canceled"]
    const [firstval,setfirstnameval]= useState("");
    const [startdate, setDateS] = React.useState(false);
    const [imageUrl, setImageUrl] = useState('');
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

  const setFirstNameVal = (value:any) =>{
    setfirstnameval(value);
};
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

const handleUpload = (info) => {
    if (info.file.status === 'uploading') {
       
      setLoading(true);
      return;
    }
    if (info.file.status === 'done') {
      // Get the image URL and log it to the console
      setImageUrl(info.file.response.url);
      console.log(info.file.response.imageUrl);
      message.success(`${info.file.name} uploaded successfully`);
    }
    if (info.file.status === 'error') {
      setLoading(false);
      message.error('Error uploading image');
    }
  };

//   const uploadButton = (
//     <div>
//       {loading ? <LoadingOutlined /> : <PlusOutlined />}
//       <div style={{ marginTop: 8 }}>Upload</div>
//     </div>
//   );

const uploadProps = {
    name: 'image',
    action: 'https://www.mocky.io/v2/5cc8019d300000980a055e76', // replace with your upload URL
    showUploadList: false,
    onChange: handleUpload,
  };

  const renderUploadButton = () => (
    <div>
      {loading ? <LoadingOutlined /> : <PlusOutlined />}
      <div style={{ marginTop: 8 }}>Upload</div>
    </div>
  );






    const [isEditing, setIsEditing] = useState(false);
  const [editingPatient, setEditingPatient] = useState(null);
  const [dataSource, setDataSource] = useState([
    {
      id: 1,
      date: "2023-03-03",
      time: "10:30",
      address: "John Address",
      prescription:"image1.png",
      status:"Active"
      
    },
    {
      id: 2,
      date: "2023-03-05",
      time: "10:30",
      address: "Colombo",
      prescription:"image2.png",
      status:"Processing"
    },
    {
      id: 3,
      date: "2023-03-12",
      time: "10:30",
      address: "Kurunegala",
      prescription:"image3.png",
      status:"Delivered"
    },
  
  ]);
  const columns = [
    {
      key: "1",
      title: "Order ID",
      dataIndex: "id",
    },
    {
      key: "2",
      title: "Date",
      dataIndex: "date",
    },
    {
      key: "3",
      title: "Time",
      dataIndex: "time",
    },
    {
      key: "4",
      title: "Address",
      dataIndex: "address",
    },
    {
        key: "5",
        title: "Prescription",
        dataIndex: "prescription",
      },
      {
        key: "6",
        title: "Status",
        dataIndex:"status",
      //   render: (record) => {
      //     return (
      //       <>
      //       if ()
      //       </>
      //     )
      // },
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
                onDeletePatient(record);
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
      
      id:firstval,
      date: startdate,
      time: timevalue,
      address:addressval,
      prescription:imageUrl,
      status:statusval
      
    }
   
    // setData2(pre=>{
    //   return[...pre,newPaient]
    // })
    setDataSource((pre:any)=> {
        return [...pre,newPaient];
      });
      

  const data ={
    FirstName: firstval,
    StartDate: startdate,
    Time: timevalue,
    EmailAddress : addressval,
    prescription:imageUrl,
    Status: statusval,
   
  };
}


//   const onAddStudent = () => {
//     const randomNumber = parseInt("100");
//     const newStudent = {
//       id: randomNumber,
//       name: "Name " + randomNumber,
//       email: randomNumber + "@gmail.com",
//       address: "Address " + randomNumber,
//     };
//     setDataSource((pre) => {
//       return [...pre, newStudent];
//     });
//   };
  const onDeletePatient = (record) => {
    Modal.confirm({
      title: "Are you sure, you want to delete this Patient record?",
      okText: "Yes",
      okType: "danger",
      onOk: () => {
        setDataSource((pre) => {
          return pre.filter((student) => student.id !== record.id);
        });
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
    <Form >
    <Form.Item>
   <h1 style={{fontWeight:'bold',paddingTop:30,fontSize:20, paddingLeft:20}}>Manage Orders</h1>
  </Form.Item>
  <div style={{ paddingLeft:100}}>
     <Space align="center" size={20} style={{paddingTop:20}}>
    <p>OrderId</p>         
      <Form.Item style={{paddingTop:22}}
      rules={[
        {
          required:true,
          message:"Order Id is required"
        }]}>
      <Input placeholder='Order Id' value={firstval} 
      onChange={(e)=>{setFirstNameVal(e.target.value)}} style={{width:160}} />
      </Form.Item>
      
    <p>Date</p>
     <Space>
     <div ><DatePicker onChange={setStartDate}/></div>
     </Space>
     </Space>
     <Space align="center">
       
     <p>Time</p>
     {/* <Form.Item style={{paddingTop:22}}
      rules={[
        {
          required:true,
          message:"Time is required"
        } ]}>
      <Input placeholder='Time' value={timeval} 
      onChange={(e)=>{setTimeVal(e.target.value)}} style={{width:160}} />
      </Form.Item> */}
      <TimePicker   onChange={onChangeTime}  />;
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
      </Space>
      <p>Upload Picture</p>
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
    </Upload>  */}
    
    <Upload {...uploadProps}>
        {imageUrl ? (
          <img src={imageUrl} alt="uploaded image" style={{ maxWidth: 200 }} />
        ) : (
          renderUploadButton()
        )}
      </Upload>


     <Form.Item style={{display:'flex',justifyContent:'center'}}>
      <Button htmlType="submit" icon={<PlusOutlined/>} type="primary"   onClick={(e)=>{ handleSave(e) }} > Add a Patient</Button>
     </Form.Item>
     </div>
     </Form>
     </div>
     

     




        <header className="App-header">
        {/* <Button onClick={onAddStudent}>Add a new Student</Button> */}
        <Table columns={columns} dataSource={dataSource} style={{paddingTop:30}}></Table>
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
                if (patient.id === editingPatient.id) {
                  return editingPatient;
                } else {
                  return patient;
                }
              });
            });
            resetEditing();
          }}
        >
          <DatePicker
              onChange={(date, dateString) =>
                setEditingPatient({ ...editingPatient, date: dateString })
              }
              
            />
          <Input
            value={editingPatient?.time}
            onChange={(e) => {
              setEditingPatient((pre) => {
                return { ...pre, time: e.target.value };
              });
            }}
          />
          <Input
            value={editingPatient?.address}
            onChange={(e) => {
              setEditingPatient((pre) => {
                return { ...pre, address: e.target.value };
              });
            }}
          />
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
        
        </Modal>
      </header>
      </div>
       
 
       )
        }



export default orders
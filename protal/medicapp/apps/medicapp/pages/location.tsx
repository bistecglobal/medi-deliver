/* eslint-disable @typescript-eslint/no-use-before-define */
/* eslint-disable react/jsx-no-undef */
/* eslint-disable react-hooks/rules-of-hooks */
import React from 'react'
import { Button, Table, Form, Input, Space, Modal } from "antd";
import {useState,useEffect} from 'react';
import axios from 'axios';




const location = () => {
  const [firstval,setfirstnameval]= useState("");
  const [editingRow, setEditingRow] = useState(null);
  const [form] = Form.useForm();
  const [nameval,setnameval]= useState("");
  const [locationval,setlocationval]= useState("");
  const [dataSource, setDataSource] = useState([
    {
      Id:firstval,
      M_Name :nameval,
      M_Location:locationval,
    }
  ]);

  // useEffect(() => {
  //   const data = [];
  //   for (let index = 0; index <7; index++) {
  //     data.push({
  //       key: `${index}`,
  //       name: `Hospital Name ${index}`,
  //       address: `Hospital Location ${index}`,
  //     });
  //   }
  //   setDataSource(data);
  // }, []);

const setNameVal = (value:any) =>{
   setnameval(value);
};
const setLocationVal = (value:any) =>{
    setlocationval(value);
 };
//  const x= Math.random()*10

  const columns = [
   
    {
      title: "Hospital Name",
      dataIndex: "M_Name",
      render: (text, record) => {
        if (editingRow === record.Id) {
          return (
            <Form.Item
              name="M_Name">
              <Input />
            </Form.Item>
          );
        } else {
          return <p>{text}</p>;
        }
      },
    },
    {
      title: "Hospital Location",
      dataIndex: "M_Location",
      render: (text, record) => {
        if (editingRow === record.Id) {
          return (
            <Form.Item name="M_Location">
              <Input />
            </Form.Item>
          );
        } else {
          return <p>{text}</p>;
        }
      },
    },
    {
      title: "Actions",
      render: (_,record) => {
        return (
          <>
            <Button type="link"
               style={{ color: "green"}}
              onClick={() => {
                setEditingRow(record.Id);
                form.setFieldsValue({
                  name: record.name,
                  address: record.address,
                });
              }}
            >
              Edit
            </Button>
            <Button type="link" htmlType="submit" style={{ color: "blue"}} >
              Save
            </Button>
            <Button type="link"
              onClick={() => {
                onDeletePatient(record.Id);
              }}
              style={{ color: "red"}}
            >
              Delete
            </Button>
      
          </>
        );
      },
    },
  ];
 
  const handleSave =( e:React.MouseEvent<HTMLButtonElement, MouseEvent>)=>{
    e.preventDefault();
  
    const manageLocation ={
      Id:firstval,
      M_Name :nameval,
      M_Location:locationval,
      
    }
    setDataSource(pre=>{
      return[...pre,manageLocation]
    });

    //post data
  const data ={
     M_Name :nameval,
     M_Location:locationval,
   
  };

  console.log("abc",data)
  const url ='http://localhost:7117/api/SaveMedicalCenters';
  axios.post(url,data).then((result)=>{
  
     alert(result.status)

  }).catch((error)=>{
    alert(error);
  });
}
//get data
useEffect(() => {
  fetchData();
}, []);

const fetchData =async() => {
  const result = await axios.get('http://localhost:7117/api/GetMedicalCenters?pageSize=10&PageNumber=1');
  
  setDataSource(result.data);
}





  const onFinish = (values) => {
    console.log(values)
    const updatedDataSource = [...dataSource];
    updatedDataSource.splice(editingRow,1,{...values, Id: editingRow })
    console.log(updatedDataSource)
    setDataSource(updatedDataSource);
    setEditingRow(null);
  };

  const onDeletePatient = (record) => {
    Modal.confirm({
      title: "Are you sure, you want to delete this Patient record?",
      okText: "Yes",
      okType: "danger",
      onOk: () => {
        setDataSource((pre) => {
          return pre.filter((patient) => patient.Id !== record);
        });
        axios.delete(`http://localhost:7117/api/MedicalCenter/${record}`)
      },
    });
  };


    return (
        <div className="App">
      <header className="App-header">

        <Form>
        <Space  size={20} style={{paddingTop:50,display:'flex',justifyContent:'center'}} >
   
        <p>Name</p>         
      <Form.Item style={{paddingTop:22}} >
      <Input placeholder='Hospital name' value={nameval} 
      onChange={(e)=>{setNameVal(e.target.value)}} style={{width:160}} />
      </Form.Item>
      <p>Location</p> 
      <Form.Item style={{paddingTop:22}} >
      <Input placeholder='Hospital Location' value={locationval} 
      onChange={(e)=>{setLocationVal(e.target.value)}} style={{width:160}} />
      </Form.Item>
      </Space>
      <Form.Item style={{display:'flex',justifyContent:'center'}}>
      <Button   type="primary"   onClick={(e)=>{ handleSave(e) }} > Add a Hospital</Button>
      
     </Form.Item>
      
        </Form>
        <Form  form={form} onFinish={onFinish}>
            <Form.Item>
                <h1 style={{fontWeight:'bold',paddingLeft:30,paddingTop:30,fontSize:20}}>Manage Locations</h1>
            </Form.Item>
            <Table columns={columns} dataSource={dataSource}></Table>
        </Form>
        
      </header>
    </div>
       
    )
}

export default location


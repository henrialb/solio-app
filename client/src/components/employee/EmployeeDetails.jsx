import React, { useState, useEffect } from 'react'
import { Link, useParams } from "react-router-dom"
import { client } from '../../Api'

const EmployeeDetails = () => {

  const [employee, setEmployee] = useState({})
  const [error, setError] = useState(null)
  const { id } = useParams()

  useEffect(() => {
    if (id) {
      client.get(`/employees/${id}`).then((response) => {
        setEmployee(response.data)
      }).catch(error => {
        setError(error)
      })
    }
  }, [id]) // with an empty array the code will only run once

  if (error) {
    return (
      <>
        <h1>{error.message}</h1>
        <p>{JSON.stringify(error, null, 2)}</p>
      </>
    )
  } else {
    return (
      <>
        <Link to="/employees" >Go back</Link>
        <Link to={`/employees/${id}/edit`} >Edit</Link>
        <p>User ID:{employee.userId}</p>
        <p>Full Name: {employee.fullName}</p>
        <p>Name: {employee.name}</p>
        <p>Role: {employee.role}</p>
        <p>Date of Birth: {employee.dob}</p>
        <p>Address: {employee.address}</p>
        <p>Phone: {employee.phone}</p>
        <p>Email: {employee.email}</p>
        <p>Nationality: {employee.nationality}</p>
        <p>Citizen No: {employee.citizenNo}</p>
        <p>Health No: {employee.healthNo}</p>
        <p>NIF: {employee.nifNo}</p>
        <p>Is Active? {employee.isActive}</p>
      </>
    )
  }
}

export default EmployeeDetails

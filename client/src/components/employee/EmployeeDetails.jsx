import React, { useState, useEffect } from 'react'
import { Link, Redirect, useParams } from "react-router-dom"

const Api = require('./Api.js')

const EmployeeDetails = () => {

  const [employee, setEmployee] = useState({});
  const [redirect, setRedirect] = useState(null) // TODO: setRedirect is never used
  const [errors, setErrors] = useState(null)
  const { id } = useParams(); // TODO: check if this is the correct way!

  useEffect(() => {
    if (id) {
      Api.getEmployee(id)
        .then(response => {
          const [error, data] = response
          if (error) {
            return setErrors(data)
          }
          setEmployee(data)
        })
    }
  }, [id]) // with an empty array the code will only run once

  if (redirect) {
    return (
      <Redirect to={redirect} />
    )
  } else {
    if (errors) {
      return <h1>{errors}</h1>
    }
    return (
      <>
        <Link to="/employees" >Go back</Link>
        <p>User ID:{employee.user_id}</p>
        <p>Full Name: {employee.full_name}</p>
        <p>Name: {employee.name}</p>
        <p>Role: {employee.role}</p>
        <p>Date of Birth: {employee.dob}</p>
        <p>Address: {employee.address}</p>
        <p>Phone: {employee.phone}</p>
        <p>Email: {employee.email}</p>
        <p>Nationality: {employee.nationality}</p>
        <p>Citizen No: {employee.citizen_no}</p>
        <p>Health No: {employee.health_no}</p>
        <p>NIF: {employee.nif_no}</p>
        <p>Is Active? {employee.is_active}</p>
      </>
    )
  }
}

export default EmployeeDetails;

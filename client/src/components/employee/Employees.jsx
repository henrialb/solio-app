import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { client } from '../../Api'
import EmployeesTable from './EmployeesTable'

const Employees = () => {

  const [employees, setEmployees] = useState([])
  const [error, setError] = useState(null)

  useEffect(() => {
    client.get('/employees').then((response) => {
      setEmployees(response.data)
    }).catch(error => {
        setError(error)
      })
  }, [])

  if (error) {
    return (
      <>
        <h1>{error.message}</h1>
        <p>{JSON.stringify(error, null, 2)}</p>
      </>
    )
  } else {
    return (
      <div className="container">
        <div className="row">
          <div className="col">
            <EmployeesTable employees={employees}></EmployeesTable>
            <Link className="btn btn-primary" to="/employees/new">Add Employee</Link>
          </div>
        </div>
      </div>
    )
  }
}

export default Employees

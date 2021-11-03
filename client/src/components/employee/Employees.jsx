import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

const Api = require("./Api.js");

const Employees = () => {

  const [employees, setEmployees] = useState([]);
  const [errors, setErrors] = useState(null)

  useEffect(() => {
    Api.getEmployees()
      .then(response => {
        const [error, data] = response
        if(error) {
          return setErrors(data)
        }
        setEmployees(data)
      })
  }, []) // with an empty array the code will only run once

  return (
    <>
      {employees.map(employee => {
        return (
          <>
            <p key={employee.id}>{employee.name}</p>
            <p><Link className="btn btn-danger" to={`/employees/${employee.id}/delete`}>Delete</Link></p>
          </>
        )
      })}
  </>
  )
}

export default Employees

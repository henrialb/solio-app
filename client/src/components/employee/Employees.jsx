import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

const Api = require("./Api.js");

const Employees = () => {

  const [employees, setEmployees] = useState([]);
  const [errors, setErrors] = useState(null) // TODO: not using erros

  useEffect(() => {
    axios.get('http://localhost:3000/employees').then((response) => {
      setEmployees(response.data);
    });
  }, []);

  // useEffect(() => {
  //   Api.getEmployees()
  //     .then(response => {
  //       const [error, data] = response
  //       if(error) {
  //         return setErrors(data)
  //       }
  //       setEmployees(data)
  //     })
  // }, []) // with an empty array the code will only run once

  return (
    <>
      {employees.map(employee => {
        return (
          <>
            <p key={employee.id}>
              {employee.name} – <Link to={`/employees/${employee.id}/edit`}>Edit</Link> <Link to={`/employees/${employee.id}/delete`}>Delete</Link></p>
          </>
        )
      })}
  </>
  )
}

export default Employees

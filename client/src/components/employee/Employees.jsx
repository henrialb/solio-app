import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

const Employees = () => {

  const [employees, setEmployees] = useState([]);
  const [errors, setErrors] = useState(null) // TODO: not using errors

  useEffect(() => {
    axios.get('http://localhost:3000/employees').then((response) => {
      setEmployees(response.data);
    });
  }, []);

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

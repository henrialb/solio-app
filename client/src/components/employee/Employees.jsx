import React, { useState, useEffect } from 'react';
// import { useState, useEffect } from 'react';

// const API_URL = 'http://localhost:3000/employees'

// const Employees = () => {

  const [employees, setEmployees] = useState({});

  useEffect(() => {
    fetch(API_URL)
      .then(data => data.json())
      .then(json => {
        setEmployees(json);
      });
  }, [])

  return (
    <>
    {employees.map(employee => {
      return <div>{employee.name}</div>
    })}
    </>
  )
}

// export default Employees;

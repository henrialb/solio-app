// import React from 'react'
// import { useState, useEffect } from 'react';

// const API_URL = 'http://localhost:3000/employees'

// const Employees = () => {

//   const [employees, setEmployees] = useState({});
//   const [status, setStatus] = useState(false);

//   useEffect(() => {
//     fetch(API_URL)
//       .then(data => data.json())
//       .then(json => {
//         setEmployees(json);
//       });
//   }, [status])

//  return (
//   <>
//     employees.forEach(employee => {
//       console.log(employee)
//     });
//   </>
//  )
// }

// export default Employees;

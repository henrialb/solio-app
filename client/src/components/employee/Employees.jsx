import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { client } from '../../Api'

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
      <>
        {employees.map(employee => {
          return (
            <>
              <p key={employee.id}>
                <Link to={`employees/${employee.id}`} > {employee.name}</Link > – <Link to={`/employees/${employee.id}/edit`}>Edit</Link> <Link to={`/employees/${employee.id}/delete`}>Delete</Link></p>
            </>
          )
        })}
    </>
    )
  }
}

export default Employees

import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { client } from '../../../Api'
import PatientExpensesTable from './PatientExpensesTable'

const Expenses = () => {

  const [patientExpenses, setPatientExpenses] = useState([])
  const [error, setError] = useState(null)

  useEffect(() => {
    client.get('/patient_expenses').then((response) => {
      setPatientExpenses(response.data)
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
            < PatientExpensesTable patientExpenses={patientExpenses} ></PatientExpensesTable >
            {console.log(patientExpenses)}
            <Link className="btn btn-primary" to="#">Add Expense</Link>
          </div>
        </div>
      </div>
    )
  }
}

export default Expenses
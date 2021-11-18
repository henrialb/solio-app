import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { client } from '../../../Api'
import MonthlyAccountsTable from '../monthly-accounts/MonthlyAccountsTable'
import ExpensesTable from './ExpensesTable'

const Expenses = () => {

  const [monthlyAccounts, setMonthlyAccounts] = useState([])
  const [patientExpenses, setPatientExpenses] = useState([])
  const [error, setError] = useState(null)

  useEffect(() => {
    client.get('/patient_expenses').then((response) => {
      setPatientExpenses(response.data)
    }).catch(error => {
      setError(error)
    })
  }, [])
  useEffect(() => {
    client.get('/patient_monthly_accounts').then((response) => {
      setMonthlyAccounts(response.data)
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
            <h1>Contas do mês</h1>
            <MonthlyAccountsTable monthlyAccounts={monthlyAccounts} ></MonthlyAccountsTable>
            <h1>Despesas</h1>
            <ExpensesTable patientExpenses={patientExpenses}></ExpensesTable>
            {console.log(monthlyAccounts)}
            <Link className="btn btn-primary" to="/despesas/new">Add Expense</Link>
          </div>
        </div>
      </div>
    )
  }
}

export default Expenses

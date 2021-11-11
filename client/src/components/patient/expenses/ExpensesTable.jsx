import React from 'react'
import { Link } from "react-router-dom"

const ExpensesTable = ({ patientExpenses }) => {

  if (patientExpenses.length === 0) {
    return <div></div>
  } else {
    return (
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Patient File ID</th> {/* TODO: change to patient name */}
            <th>Amount</th>
            <th>Date</th>
            <th>Description</th>
            <th>Note</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {patientExpenses.map(expense => (
            <tr key={expense.id}>
              <td>{expense.id}</td>
              <td>{expense.patientFileId}</td> {/* TODO: Patient name instead */}
              <td>{expense.amount}</td>
              <td>{expense.date}</td>
              <td>{expense.description}</td>
              <td>{expense.note}</td>
              <td>
                <Link className="btn btn-success" to={`/despesas/${expense.id}/edit`}>Edit</Link>{' '}
                <Link className="btn btn-danger" to={`/despesas/${expense.id}/delete`}>Delete</Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    )
  }
}

export default ExpensesTable;

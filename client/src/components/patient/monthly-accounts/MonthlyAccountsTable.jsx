import React from 'react'
import { Link } from 'react-router-dom'

const MonthlyAccountsTable = ({monthlyAccounts}) => {
  return (
    <table className="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>File ID [Utente]</th>
          <th>Total</th>
          <th>Expenses</th>
          <th>Pago</th>
          <th>Nota</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {monthlyAccounts.map(account => (
          <tr key={account.id}>
            <td>{account.id}</td>
            <td>{account.patientFileId} [{/*TODO: */} nome utente]</td>
            <td>{account.total}</td>
            <td><Link to={`/accounts/${account.id}`}>[details]</Link></td>
            <td>{String(account.isPaid)}</td>
            <td>{account.note}</td>
            <td>
              <Link className="btn btn-success" to={`/accounts/${account.id}/edit`}>Edit</Link>{' '}
              <Link className="btn btn-danger" to={`/accounts/${account.id}/delete`}>Delete</Link>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}

export default MonthlyAccountsTable

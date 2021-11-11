import React from 'react'
import { Link } from 'react-router-dom'
import { age } from '../../functions'

const EmployeesTable = ({employees}) => {
  if (employees.length === 0) {
      return <div></div>
    } else {
      return (
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Turno</th>
              <th>Função</th>
              <th>Telefone</th>
              <th>Idade</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {employees.map(employee => (
              <tr key={employee.id}>
                <td>{employee.id}</td>
                <td><Link to={`/employees/${employee.id}`} >{employee.name}</Link></td>
                <td>(TODO)</td>
                <td>{employee.role}</td>
                <td>{employee.phone}</td>
                <td>{age(employee.dob)}</td>
                <td>
                  <Link className="btn btn-success" to={`/employees/${employee.id}/edit`}>Edit</Link>{' '}
                  <Link className="btn btn-danger" to={`/employees/${employee.id}/delete`}>Delete</Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )
    }
}

export default EmployeesTable

import React from 'react'
import { Link } from 'react-router-dom'
import { age } from '../../functions'

const PatientsTable = ({patients}) => {
  if (patients.length === 0) {
      return <div></div>
    } else {
      return (
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Full Name</th>
              <th>Idade</th>
              <th>Cartão Cidadão</th>
              <th>Data de Nascimento</th>
              <th>Is Active</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {patients.map(patient => (
              <tr key={patient.id}>
                <td>{patient.id}</td>
                <td><Link to={`/patients/${patient.id}`} >{patient.fullName}</Link></td>
                <td>{age(patient.dob)}</td>
                <td>{patient.citizenNo}</td>
                <td>{patient.dob}</td>
                <td>{String(patient.isActive)}</td>
                <td>
                  <Link className="btn btn-success" to={`/patients/${patient.id}/edit`}>Edit</Link>{' '}
                  <Link className="btn btn-danger" to={`/patients/${patient.id}/delete`}>Delete</Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )
    }
}

export default PatientsTable

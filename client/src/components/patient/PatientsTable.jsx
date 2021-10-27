import React, { Component } from 'react'
import { Link } from "react-router-dom"

class PatientsTable extends Component {
  constructor(props) {
    super(props)
    this.state = {
      patients: props.patients
    }
  }

  render() {
    const patients = this.state.patients
    if (patients.length === 0) {
      return <div></div>
    } else {
      return (
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Sex</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {patients.map(patient => (
              <tr key={patient.id}>
                <td>{patient.id}</td>
                <td>{patient.name}</td>
                <td>{patient.sex}</td>
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
}

export default PatientsTable;
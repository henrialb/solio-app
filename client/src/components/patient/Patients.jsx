import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { client } from '../../Api'
import PatientsTable from './PatientsTable'
import PatientFilesTable from './PatientFilesTable'


const Patients = () => {

  const [patients, setPatients] = useState([])
  const [error, setError] = useState(null)

  useEffect(() => {
    client.get('/patients').then((response) => {
      setPatients(response.data)
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
            <PatientsTable patients={patients}></PatientsTable>
            <Link className="btn btn-primary" to="/patients/new">Add Patient</Link>
          </div>
        </div>
      </div>
    )
  }
}

export default Patients

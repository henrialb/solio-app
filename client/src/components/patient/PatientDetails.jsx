import React, { useState, useEffect } from 'react'
import { Link, Redirect, useParams } from "react-router-dom"

const Api = require('./Api.js')

const PatientDetails = () => {

  const [patient, setPatient] = useState({});
  const [redirect, setRedirect] = useState(null) // TODO: setRedirect is never used
  const [errors, setErrors] = useState(null)
  const { id } = useParams(); // TODO: check if this is the correct way!

  useEffect(() => {
    if(id) {
      Api.getPatient(id)
        .then(response => {
          const [error, data] = response
          if(error) {
            return setErrors(data)
          }
          setPatient(data)
        })
    }
  }, [id]) // with an empty array the code will only run once

  if (redirect) {
    return (
      <Redirect to={redirect} />
    )
  } else {
    if(errors) {
      return <h1>{errors}</h1>
    }
    return (
      <>
        <Link to="/patients" >Go back</Link>
        <p>{patient.fullName}</p>
        <p>{patient.name}</p>
        <p>{patient.sex}</p>
        <p>{patient.dob}</p>
        <p>{patient.citizenNo}</p>
        <p>{patient.nifNo}</p>
        <p>{patient.healthNo}</p>
        <p>{patient.socialSecurityNo}</p>
        <p>{patient.clothesTag}</p>
      </>
    )
  }
}

export default PatientDetails;

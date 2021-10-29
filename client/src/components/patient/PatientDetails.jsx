import React, { useState, useEffect } from 'react'
import { Redirect } from 'react-router'

const Api = require('./Api.js')

const PatientDetails = ({match}) => {

  const [patient, setPatient] = useState({});
  const [redirect, setRedirect] = useState(null) // TODO: setRedirect is never used
  const [errors, setErrors] = useState(null)
  const id = match?.params?.id

  useEffect(() => {
    if(id) {
      Api.getPatient(id)
        .then(response => {
          const [error, data] = response
          if(error) {
            return setErrors(data)
          }
          setPatient(data)

          // if (error) {
          //   this.setState({
          //     errors: data
          //   })
          // } else {
          //   this.setState({
          //     patient: data,
          //     errors: []
          //   })
          // }
        })
    }
  }, [id]) // with an empty array the code will only run once

  if (redirect) {
    return (
      <Redirect to={redirect} />
    )
  } else {
    if(errors) {
      return <h1>ups</h1>
    }
    return (
      <>
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

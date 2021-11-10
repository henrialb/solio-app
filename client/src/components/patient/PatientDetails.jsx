import React, { useState, useEffect } from 'react'
import { Link, useParams } from "react-router-dom"
import { client } from '../../Api'

const PatientDetails = () => {

  const [patient, setPatient] = useState({})
  const [error, setError] = useState(null)
  const { id } = useParams()

  useEffect(() => {
    if (id) {
      client.get(`/patients/${id}`).then((response) => {
        setPatient(response.data)
      }).catch(error => {
        setError(error)
      })
    }
  }, [id]) // with an empty array the code will only run once

  if (error) {
    return (
      <>
        <h1>{error.message}</h1>
        <p>{JSON.stringify(error, null, 2)}</p>
      </>
    )
  } else {
    return (
      <>
        <Link to="/patients" >Go back</Link>
        <p>Full name: {patient.fullName}</p>
        <p>Name: {patient.name}</p>
        <p>Sex: {patient.sex}</p>
        <p>Nascimento: {patient.dob}</p>
        <p>Cartão de Cidadão{patient.citizenNo}</p>
        <p>NIF: {patient.nifNo}</p>
        <p>Número de utente SNS: {patient.healthNo}</p>
        <p>Seg. Social: {patient.socialSecurityNo}</p>
        <p>Etiqueta roupa: {patient.clothesTag}</p>
        <p>Is Active?: {String(patient.isActive)}</p>
      </>
    )
  }
}

export default PatientDetails;

import React, { useEffect, useState } from 'react'
import { Redirect, useParams } from 'react-router-dom'
import { client } from '../../Api'

const PatientDelete = () => {

  const [error, setError] = useState(null)
  const { id } = useParams()

  useEffect(() => {
    if(id) {
      client.delete(`/patients/${id}`).then(() => {
        alert("Patient deleted!")
      }).catch(error => {
        setError(error) // TODO: this is not working.
      })}
  }, [id])

  console.log(error)
  if (error) { // TODO: error has not been set
    <>
      <h1>{error.message}</h1>
      <p>{JSON.stringify(error, null, 2)}</p>
    </>
  } else {
    return <Redirect to='/patients' /> // TODO: make it redirect correctly
  }
}

export default PatientDelete

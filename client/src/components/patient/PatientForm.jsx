import React, { useState, useEffect } from 'react'
import { useParams, useHistory } from 'react-router-dom'
import { client } from '../../Api'

const PatientForm = () => {
  const history = useHistory()
  const [patient, setPatient] = useState({})
  const [error, setError] = useState(null)
  const { id } = useParams()

  useEffect(() => {
    if(id) {
      client.get(`/patients/${id}`)
      .then((response) => {
        setPatient(response.data)
      }).catch(error => {
        setError(error)
      })
    }
  }, [id])

  const handleChange = (event) => {
    setPatient((prevalue) => {
      return {
        ...prevalue,
        [event.target.name]: event.target.value
      }
    })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    client.put(`/patients/${id}`, patient)
      .then((response) => {
        setPatient(response.data)
        alert("Patient edited!") // TODO: change this
      })

    // TODO: with useHistory, changes are not reflected in new path
    history.push('/patients')
  }

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
            <form onSubmit={handleSubmit}>
              <div className="input-group">
                <label htmlFor="fullName" className="form-label">Full name</label>
                <input type="text" name="fullName" id="fullName" value={patient.fullName} placeholder="Enter full name" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="name" className="form-label">Name</label>
                <input type="text" name="name" id="name" value={patient.name} placeholder="Enter name" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="sex" className="form-label">Sex</label>
                <select name="sex" id="sex" value={patient.sex} onChange={handleChange} className="form-control" >
                  <option value="male">male</option>
                  <option value="female">female</option>
                </select>
              </div>
              <div className="input-group">
                <label htmlFor="dob" className="form-label">Date of birth</label>
                <input type="date" name="dob" id="dob" value={patient.dob} placeholder="Enter date of birth" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="citizenNo" className="form-label">Citizen number</label>
                <input type="text" name="citizenNo" id="citizenNo" value={patient.citizenNo} placeholder="Enter citizen number" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="nifNo" className="form-label">Nif number</label>
                <input type="text" name="nifNo" id="nifNo" value={patient.nifNo} placeholder="Enter nif number" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="healthNo" className="form-label">Health number</label>
                <input type="text" name="healthNo" id="healthNo" value={patient.healthNo} placeholder="Enter health number" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="socialSecurityNo" className="form-label">Social security number</label>
                <input type="text" name="socialSecurityNo" id="socialSecurityNo" value={patient.socialSecurityNo} placeholder="Enter social security number" onChange={handleChange} className="form-control" />
              </div>
              {/* TODO: fix isActive, info is not being sent to db */}
              <div className="input-group">
                <label htmlFor="isActive" className="form-label">Is active?</label>
                <select name="isActive" id="isActive" value={patient.isActive} onChange={handleChange} className="form-control" >
                  <option value="1">true</option>
                  <option value="0">false</option>
                </select>
              </div>
              <button className="btn btn-success">Submit</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

export default PatientForm

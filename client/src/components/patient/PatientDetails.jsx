import React, { Component } from 'react'
import { Redirect } from 'react-router'

const Api = require('./Api.js')

class PatientDetails extends Component {
  constructor(props) {
    super(props)

    this.state = {
      id: props.match.params.id,
      redirect: null
    }
  }

  componentDidMount() {
    if (this.state.patient.id) {
      Api.getPatient(this.state.patient.id)
        .then(response => {
          const [error, data] = response
          if (error) {
            this.setState({
              errors: data
            })
          } else {
            this.setState({
              patient: data,
              errors: []
            })
          }
        })
    }
  }

  render() {
    const { redirect, patient } = this.state

    if (redirect) {
      return (
        <Redirect to={redirect} />
      )
    } else {
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
}

export default PatientDetails;

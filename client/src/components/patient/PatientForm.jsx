import React, { Component } from 'react'
import { Redirect } from 'react-router'

const Api = require('../../Api.js')

class PatientForm extends Component {
  constructor(props) {
    super(props)

    this.state = {
      patient: {
        id: this.getPatientId(props),
        name: '',
        full_name: '',
        sex: '',
      },
      redirect: null,
      errors: []
    }

    this.setName = this.setName.bind(this)
    this.setFullName = this.setFullName.bind(this)
    this.setSex = this.setSex.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  getPatientId(props) {
    try {
      return props.match.params.id
    } catch (error) {
      return null
    }
  }

  setName(event) {
    let newVal = event.target.value || ''
    this.setFieldState('name', newVal)
  }

  setFullName(event) {
    let newVal = event.target.value || ''
    this.setFieldState('fullName', newVal)
  }

  setSex(event) {
    let newVal = event.target.value || ''
    this.setFieldState('sex', newVal)
  }

  setFieldState(field, newVal) {
    this.setState((prevState) => {
      let newState = prevState
      newState.patient[field] = newVal
      return newState
    })
  }

  handleSubmit(event) {
    event.preventDefault()

    let patient = {
      name: this.state.patient.name,
      full_name: this.state.patient.fullName,
      sex: this.state.patient.sex
    }

    Api.savePatient(patient, this.state.patient.id)
      .then(response => {
        const [error, errors] = response
        if (error) {
          this.setState({
            errors: errors
          })
        } else {
          this.setState({
            redirect: '/patients'
          })
        }
      })
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
    const { redirect, patient, errors } = this.state

    if (redirect) {
      return (
        <Redirect to={redirect} />
      )
    } else {

      return (
        <div className="container">
          <div className="row">
            <div className="col">
              <h3>Edit Patient</h3>

              {errors.length > 0 &&
                <div>
                  {errors.map((error, index) =>
                    <div className="alert-danger" key={index}>
                      {error}
                    </div>
                  )}
                </div>
              }

              <form onSubmit={this.handleSubmit}>
                <div className="input-group">
                  <label htmlFor="name" className="form-label">Name</label>
                  <input type="text" name="name" id="name" value={patient.name} placeholder="Enter name" onChange={this.setName} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="fullName" className="form-label">Full name</label>
                  <input type="text" name="fullName" id="fullName" value={patient.fullName} placeholder="Enter full name" onChange={this.setFullName} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="sex" className="form-label">Sex</label>
                  <input type="text" name="sex" id="sex" value={patient.sex} placeholder="Enter sex" onChange={this.setSex} className="form-control" />
                </div>
                <button className="btn btn-success">Submit</button>
              </form>
            </div>
          </div>
        </div>
      )
    }
  }
}

export default PatientForm;

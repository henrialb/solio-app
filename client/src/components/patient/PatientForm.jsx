import React, { Component } from 'react'
import { Redirect } from 'react-router'

const Api = require('./Api.js')

class PatientForm extends Component {
  constructor(props) {
    super(props)

    this.state = {
      patient: {
        id: this.getPatientId(props),
        full_name: '',
        name: '',
        sex: '',
        dob: '',
        citizen_no: '',
        nif_no: '',
        health_no: '',
        social_security_no: '',
        clothes_tag: '',
        is_active: '', // TODO: only allow admin profile to be able to change this
      },
      redirect: null,
      errors: []
    }

    this.setfullName = this.setfullName.bind(this)
    this.setName = this.setName.bind(this)
    this.setSex = this.setSex.bind(this)
    this.setDob = this.setDob.bind(this)
    this.setCitizenNo = this.setCitizenNo.bind(this)
    this.setNifNo = this.setNifNo.bind(this)
    this.setHealthNo = this.setHealthNo.bind(this)
    this.setSocialSecurityNo = this.setSocialSecurityNo.bind(this)
    this.setClothesTag = this.setClothesTag.bind(this)
    this.setIsActive = this.setIsActive.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  getPatientId(props) {
    try {
      return props.match.params.id
    } catch (error) {
      return null
    }
  }

  setfullName(event) {
    let newVal = event.target.value || ''
    this.setFieldState('fullName', newVal)
  }

  setName(event) {
    let newVal = event.target.value || ''
    this.setFieldState('name', newVal)
  }

  setSex(event) {
    let newVal = event.target.value || ''
    this.setFieldState('sex', newVal)
  }

  setDob(event) {
    let newVal = event.target.value || ''
    this.setFieldState('dob', newVal)
  }

  setCitizenNo(event) {
    let newVal = event.target.value || ''
    this.setFieldState('citizenNo', newVal)
  }

  setNifNo(event) {
    let newVal = event.target.value || ''
    this.setFieldState('nifNo', newVal)
  }

  setHealthNo(event) {
    let newVal = event.target.value || ''
    this.setFieldState('healthNo', newVal)
  }

  setSocialSecurityNo(event) {
    let newVal = event.target.value || ''
    this.setFieldState('socialSecurityNo', newVal)
  }

  setClothesTag(event) {
    let newVal = event.target.value || ''
    this.setFieldState('clothesTag', newVal)
  }

  setIsActive(event) {
    let newVal = event.target.value || ''
    this.setFieldState('isActive', newVal)
  } // TODO: make this work

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
      full_name: this.state.patient.fullName,
      name: this.state.patient.name,
      sex: this.state.patient.sex,
      dob: this.state.patient.dob,
      citizenNo: this.state.patient.citizenNo,
      nifNo: this.state.patient.nifNo,
      healthNo: this.state.patient.healthNo,
      socialSecurityNo: this.state.patient.socialSecurityNo,
      clothesTag: this.state.patient.clothesTag,
      isActive: this.state.patient.isActive
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
                  <label htmlFor="fullName" className="form-label">Full name</label>
                  <input type="text" name="fullName" id="fullName" value={patient.fullName} placeholder="Enter full name" onChange={this.setfullName} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="name" className="form-label">Name</label>
                  <input type="text" name="name" id="name" value={patient.name} placeholder="Enter name" onChange={this.setName} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="sex" className="form-label">Sex</label>
                  <select name="sex" id="sex" value={patient.sex} onChange={this.setSex} className="form-control" >
                    <option value="male">male</option>
                    <option value="female">female</option>
                  </select>
                </div>
                <div className="input-group">
                  <label htmlFor="dob" className="form-label">Date of birth</label>
                  <input type="date" name="dob" id="dob" value={patient.dob} placeholder="Enter date of birth" onChange={this.setDob} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="citizenNo" className="form-label">Citizen number</label>
                  <input type="text" name="citizenNo" id="citizenNo" value={patient.citizenNo} placeholder="Enter citizen number" onChange={this.setCitizenNo} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="nifNo" className="form-label">Nif number</label>
                  <input type="text" name="nifNo" id="nifNo" value={patient.nifNo} placeholder="Enter nif number" onChange={this.setNifNo} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="healthNo" className="form-label">Health number</label>
                  <input type="text" name="healthNo" id="healthNo" value={patient.healthNo} placeholder="Enter health number" onChange={this.setHealthNo} className="form-control" />
                </div>
                <div className="input-group">
                  <label htmlFor="socialSecurityNo" className="form-label">Social security number</label>
                  <input type="text" name="socialSecurityNo" id="socialSecurityNo" value={patient.socialSecurityNo} placeholder="Enter social security number" onChange={this.setSocialSecurityNo} className="form-control" />
                </div>
                {/* TODO: fix isActive, info is not being sent to db */}
                <div className="input-group">
                  <label htmlFor="isActive" className="form-label">Is active?</label>
                  <select name="isActive" id="isActive" value={patient.isActive} onChange={this.setIsActive} className="form-control" >
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
}

export default PatientForm;

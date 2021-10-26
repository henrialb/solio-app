import React, { Component } from 'react'
import { Link } from "react-router-dom"
import PatientsTable from './PatientsTable'

const Api = require('../../Api.js')

class Patients extends Component {
  constructor(props) {
    super(props)
    this.state = {
      patients: [],
      isLoaded: false,
      error: null
    }
  }

  componentDidMount() {
    Api.getPatients()
      .then(response => {
        const [error, data] = response
        if (error) {
          this.setState({
            isLoaded: true,
            patients: [],
            error: data
          })
        } else {
          this.setState({
            isLoaded: true,
            patients: data
          })
        }
      })
  }

  render() {
    const { error, isLoaded, patients } = this.state

    if (error) {

      return (
        <div className="alert-danger">
          Error: {error}
        </div>
      )

    } else if (!isLoaded) {

      return (
        <div className="alert-primary">
          Loading...
        </div>
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
}

export default Patients;

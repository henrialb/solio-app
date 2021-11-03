import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'

const Api = require('./Api.js')

class PatientDelete extends Component {

  constructor(props) {
    super(props)

    this.state = {
      id: props.match.params.id,
      redirect: null
    }
  }

  componentDidMount() {
    Api.deletePatient(this.state.id)
      .then(response => {
        const [error] = response
        if (error) {
          // TODO: set flash
        }
        this.setState({
          redirect: '/patients'
        })
      })
  }

  render() {
    if (this.state.redirect) {
      return (
        <Redirect to={this.state.redirect} />
      )
    } else {
      return (
        <div></div>
      )
    }
  }

}

export default PatientDelete;

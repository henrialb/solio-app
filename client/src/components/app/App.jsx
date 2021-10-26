import React, { Component } from 'react'

import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom'

import './App.scss';

import Patients from '../patient/Patients'
import PatientForm from '../patient/PatientForm'
import PatientDelete from '../patient/PatientDelete'

class App extends Component {
  render() {
    return (
      <Router>
        <div>
          <Route exact path='/' component={Patients} />
          <Route exact path='/patients' component={Patients} />
          <Route exact path='/patients/new' component={PatientForm} />
          <Route
            exact path="/patients/:id/edit"
            render={(routeProps) => (
              <PatientForm {...routeProps} />
            )}
          />
          <Route
            exact path="/patients/:id/delete"
            render={(routeProps) => (
              <PatientDelete {...routeProps} />
            )}
          />
        </div>
      </Router>
    )
  }
}

export default App;

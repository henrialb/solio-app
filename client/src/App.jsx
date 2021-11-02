// import React, { Component } from 'react' TODO: remove this
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import { Header, Footer, Menu } from './components/layout/Layout'

// import './App.scss'; TODO: remove
import Employees from './components/employee/Employees'


import Patients from './components/patient/Patients'
import PatientForm from './components/patient/PatientForm'
import PatientDelete from './components/patient/PatientDelete'
import PatientDetails from './components/patient/PatientDetails'

import './App.scss';

const App = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <div className="main">
          <Menu />
          <div className="content">
            <Switch>
              <Route exact path='/'>
                <Patients />
              </Route>
              <Route exact path='/patients'>
                <Patients />
              </Route>

              <Route exact path='/employees'>
                <Employees />
              </Route>


              <Route exact path='/patients/new'>
                <PatientForm />
              </Route>
              <Route exact path='/patients/:id'>
                <PatientDetails />
              </Route>
              {/* TODO: Refactor this */}
              <Route
                exact path="/patients/:id/edit"
                render={(routeProps) => (
                  <PatientForm {...routeProps} />
                )}
              />
              <Route
                exact path="/patients/:id/delete">
                  <PatientDelete />
              </Route>

            </Switch>
          </div>
        </div>
        <Footer />
      </div>
    </Router>
  );
}

export default App;

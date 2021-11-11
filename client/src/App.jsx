import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import { Header, Footer, Menu } from './components/layout/Layout'

import Employees from './components/employee/Employees'
import EmployeeDelete from "./components/employee/EmployeeDelete"
import EmployeeForm from "./components/employee/EmployeeForm"
import EmployeeDetails from './components/employee/EmployeeDetails'

import Patients from './components/patient/Patients'
import PatientForm from './components/patient/PatientForm'
import PatientDelete from './components/patient/PatientDelete'
import PatientDetails from './components/patient/PatientDetails'

import './App.scss'

import Expenses from './components/patient/expenses/Expenses'
import ExpenseDelete from './components/patient/expenses/ExpenseDelete'
import ExpenseForm from './components/patient/expenses/ExpenseForm'

const App = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <div className="wrapper d-flex">
          <div className="sticky-top">
            <Menu />
          </div>
          <main className="flex-grow-1 d-flex flex-column vh-100">
            <Switch>
              <Route exact path="/">
                <h1>WIP: home page</h1>
              </Route>
              <Route exact path="/patients">
                <Patients />
              </Route>
              <Route exact path="/employees">
                <Employees />
              </Route>
              <Route exact path="/despesas">
                <Expenses />
              </Route>
              <Route exact path="/patients/new">
                <PatientForm />
              </Route>
              <Route exact path="/patients/:id">
                <PatientDetails />
              </Route>
              <Route exact path="/employees/:id">
                <EmployeeDetails />
              </Route>
              <Route exact path="/employees/:id/edit">
                <EmployeeForm />
              </Route>
              {/* TODO: Refactor this – check https://reactrouter.com/web/example/url-params */}
              <Route
                exact
                path="/patients/:id/edit"
                render={(routeProps) => <PatientForm {...routeProps} />}
              />
              <Route
                exact
                path="/patients/:id/delete"
                render={(routeProps) => <PatientDelete {...routeProps} />}
              />
              <Route exact path="/employees/:id/delete">
                <EmployeeDelete />
              </Route>
              <Route exact path="/despesas/:id/delete">
                <ExpenseDelete />
              </Route>
              <Route exact path="/despesas/:id/edit">
                <ExpenseForm />
              </Route>
            </Switch>
            <Footer />
          </main>
        </div>
      </div>
    </Router>
  )
}

export default App

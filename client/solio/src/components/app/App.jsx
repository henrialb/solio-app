import { BrowserRouter as Router, Link, Route } from 'react-router-dom'
import {useState, useEffect} from 'react';
import './App.scss';
import Patient from '../patient/Patient';
import PatientDetail from '../PatientDetail/PatientDetail';

const API_URL = 'http://localhost:3000/patients'

const App = () => {
  const[patients, setPatients] = useState([]);
  const[currentPatient, setCurrentPatient] = useState();

  useEffect(() => {
    fetch(API_URL)
      .then(data => data.json())
      .then(json => { setPatients(json) });
  }, []) // with this empty array the code will only run once

  return (
    <Router>
      {/* Index */}
      <Route exact={true} path="/patients" render={() => (
        patients.map(patient => {
          return (
            <Link to={`/patients/${patient.id}`}>
              <Patient key={patient?.id} {...patient} setCurrentPatient={setCurrentPatient} />
            </Link>
          )
        })
        )}/>
      {/* Show */}
      <Route path="/patients/:patientId" render={() => (
        <PatientDetail name={currentPatient?.name} sex={currentPatient?.sex} />
      )} />
    </Router>
  );
}

export default App;

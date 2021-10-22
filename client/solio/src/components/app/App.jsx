import {useState, useEffect} from 'react';
import './App.scss';
import Patient from '../patient/Patient';

const API_URL = 'http://localhost:3000/patients'

const App = () => {
  const[patients, setPatients] = useState([]);

  useEffect(() => {
    fetch(API_URL)
      .then(data => data.json())
      .then(json => { setPatients(json) });
  }, []) // with this empty array the code will only run once

  return (
    <div className="app">
      <div className="main">
        <div className="patients">
          {patients.map(patient => {
            return <Patient key={patient.id} {...patient} />;
          })}
        </div>
      </div>
    </div>
  );
}

export default App;

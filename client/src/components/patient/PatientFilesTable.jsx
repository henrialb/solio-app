import React from 'react'
import { Link } from "react-router-dom"

const PatientFilesTable = ({ patientFiles }) => {

  if (patientFiles.length === 0) { // TODO: improve this
    return <div></div>
  } else {
    return (
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Patient Admission ID</th> {/* TODO: change to patient name */}
            <th>Open Date</th>
            <th>Close Date</th>
            <th>Note</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {patientFiles.map(file => (
            <tr key={file.id}>
              <td>{file.id}</td>
              <td>{file.patientAdmissionId}</td> {/* TODO: Patient name instead */}
              <td>{file.openDate}</td>
              <td>{file.closeDate}</td>
              <td>{file.note}</td>
              <td>
                <Link className="btn btn-success" to={`/patients/files${file.id}/edit`}>Edit</Link>{' '}
                <Link className="btn btn-danger" to={`/patients/files${file.id}/delete`}>Delete</Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    )
  }
}

export default PatientFilesTable;

// DISPLAY IN OTHER PAGES

// const [patientFiles, setPatientFiles] = useState([])

// useEffect(() => {
//   client.get('/patient_files').then((response) => {
//     setPatientFiles(response.data)
//   }).catch(error => {
//     setError(error)
//   })
// }, [])

//   < PatientFilesTable patientFiles = { patientFiles } ></PatientFilesTable >

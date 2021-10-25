const PatientsIndex = ({fullName, setCurrentPatient, name, sex}) => {
  return (
    <div onClick={() => { setCurrentPatient({ name, sex }) }} className="patient">
      <div className="patient-name">
        {fullName}
      </div>
    </div>
  );
}
export default PatientsIndex;

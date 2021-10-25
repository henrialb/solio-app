const PatientsIndex = ({name, setCurrentPatient, sex}) => {
  return (
    <div onClick={() => { setCurrentPatient({ name, sex }) }} className="patient">
      <div className="patient-name">
        {name}
      </div>
    </div>
  );
}
export default PatientsIndex;

const Patient = ({name, sex, dob, setCurrentPatient}) => {
  return (
    <div onClick={() => { setCurrentPatient({ name, sex }) }} className="patient">
      <div className="patient-name">
        {name} - {sex} - {dob}
      </div>
    </div>
  );
}
 export default Patient;

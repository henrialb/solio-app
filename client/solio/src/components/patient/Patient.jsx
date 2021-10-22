const Patient = ({name, sex, dob}) => {
  return (
    <div className="patient">
      <div className="patient-name">
        {name} - {sex} - {dob}
      </div>
    </div>
  );
}
 export default Patient;

const PatientDetail = ({ name, sex }) => {
  return (
    <div className="patient">
      <div className="patient-name">
        <h1>{name}</h1>
        <h3>{sex}</h3>
      </div>
    </div>
  );
}
export default PatientDetail;

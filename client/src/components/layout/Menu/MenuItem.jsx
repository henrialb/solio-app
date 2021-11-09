import { Link } from 'react-router-dom'
import './Menu.scss';

const MenuItem = ({ icon, label }) => {
  return(
    <div className="menu-item py-2 position-relative">
      <i className={`fas fa-${icon} d-block fs-3 pb-1`}></i>
      <span className="fw-light">{label}</span>
    </div>
  )
}

export default MenuItem;

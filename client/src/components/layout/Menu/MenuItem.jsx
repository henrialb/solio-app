import { Link } from 'react-router-dom'
import './Menu.scss';

const MenuItem = ({ icon, label, path }) => {
  return(
    <div className="menu-item py-3 position-relative">
      <Link to={path} className="stretched-link">
        <i className={`fas fa-${icon} d-block fs-3 pb-1`}></i>
      </Link>
      <span className="fw-light">{label}</span>
    </div>
  )
}

export default MenuItem;

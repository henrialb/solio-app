import './Menu.scss';
import MenuItem from './MenuItem';

const Menu = () => {
  return (
    // TODO: add fixed-top to menu div class?
    <div className="menu text-center pt-3">
      <MenuItem icon="home" label="Início" path="/" />
      <MenuItem icon="user-friends" label="Utentes" path="/patients" />
      <MenuItem icon="receipt" label="Despesas" path="/despesas" />
      <MenuItem icon="calendar-alt" label="Visitas" path="/visitas" />
      <MenuItem icon="mortar-pestle" label="Farmácia" path="/farmacia" />
      <MenuItem icon="cubes" label="Stocks" path="/stocks" />


      {/* <div className="menu-item py-3">
        <i className="fas fa-home d-block fs-3 pb-1"></i>
        <span className="fw-light">Início</span>
      </div>
      <div className="menu-item py-3">
        <i className="fas fa-user-friends d-block fs-3 pb-1"></i>
        <span className="fw-light">Utentes</span>
      </div>
      <div className="menu-item py-3">
        <i className="fas fa-receipt d-block fs-3 pb-1"></i>
        <span className="fw-light">Despesas</span>
      </div>
      <div className="menu-item py-3">
        <i className="fas fa-calendar-alt d-block fs-3 pb-1"></i>
        <span className="fw-light">Visitas</span>
      </div>
      <div className="menu-item py-3">
        <i className="fas fa-mortar-pestle d-block fs-3 pb-1"></i>
        <span className="fw-light">Farmácia</span>
      </div>
      <div className="menu-item py-3">
        <i className="fas fa-cubes d-block fs-3 pb-1"></i>
        <span className="fw-light">Stocks</span>
      </div> */}
    </div>
  )
}

export default Menu

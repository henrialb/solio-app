import './Menu.scss';

const Menu = () => {
  return (
    <div className="menu text-center pt-3 fixed-top">
      <div className="menu-item py-3">
        <i class="fas fa-home d-block fs-3 pb-1"></i>
        <span className="fw-light">Início</span>
      </div>
      <div className="menu-item py-3">
        <i class="fas fa-user-friends d-block fs-3 pb-1"></i>
        <span className="fw-light">Utentes</span>
      </div>
      <div className="menu-item py-3">
        <i class="fas fa-receipt d-block fs-3 pb-1"></i>
        <span className="fw-light">Despesas</span>
      </div>
      <div className="menu-item py-3">
        <i class="fas fa-calendar-alt d-block fs-3 pb-1"></i>
        <span className="fw-light">Visitas</span>
      </div>
      <div className="menu-item py-3">
        <i class="fas fa-prescription-bottle-alt d-block fs-3 pb-1"></i>
        <span className="fw-light">Farmácia</span>
      </div>
      <div className="menu-item py-3">
        <i class="fas fa-cubes d-block fs-3 pb-1"></i>
        <span className="fw-light">Stocks</span>
      </div>
    </div>
  )
}

export default Menu

import './Menu.scss';
import MenuItem from './MenuItem';

const Menu = () => {
  return (
    // TODO: add fixed-top to menu div class?
    <aside className="menu text-center pt-3">
      <MenuItem icon="home" label="Início" path="/" />
      <MenuItem icon="user-friends" label="Utentes" path="/patients" />
      <MenuItem icon="receipt" label="Despesas" path="/despesas" />
      <MenuItem icon="calendar-alt" label="Visitas" path="/visitas" />
      <MenuItem icon="mortar-pestle" label="Farmácia" path="/farmacia" />
      <MenuItem icon="cubes" label="Stocks" path="/stocks" />
    </aside>
  )
}

export default Menu

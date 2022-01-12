import './Menu.scss'
import { Nav } from 'react-bootstrap'
import MenuItem from './MenuItem'

const Menu = () => {
  return (
    <nav className="sidenav text-center pt-3 d-flex flex-column">
      <Nav defaultActiveKey="/" className="flex-column">
        <Nav.Link href="/">
          <MenuItem icon="home" label="Início" />
        </Nav.Link>
        <Nav.Link href="/patients" eventKey="patients">
          <MenuItem icon="user-friends" label="Utentes" />
        </Nav.Link>
        <Nav.Link href="/despesas" eventKey="despesas">
          <MenuItem icon="receipt" label="Despesas" />
        </Nav.Link>
        <Nav.Link href="/visitas" eventKey="visitas" disabled>
          <MenuItem icon="calendar-alt" label="Visitas" />
        </Nav.Link>
        <Nav.Link href="/farmacia" eventKey="farmacia" disabled>
          <MenuItem icon="mortar-pestle" label="Farmácia" />
        </Nav.Link>
        <Nav.Link href="/stocks" eventKey="stocks" disabled>
          <MenuItem icon="cubes" label="Stocks" />
        </Nav.Link>
      </Nav>
      <Nav defaultActiveKey="/" className="flex-column mt-auto pb-5">
        <Nav.Link href="/logout">
          <MenuItem icon="sign-out-alt" label="Sair" />
        </Nav.Link>
      </Nav>
    </nav>
  )
}

export default Menu

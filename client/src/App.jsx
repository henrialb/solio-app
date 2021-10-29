import { Header, Footer, Menu } from './components/layout/Layout'

import './App.scss';

const App = () => {
  return (
    <div className="app">
      <Header />
      <div className="main">
        <Menu />
        <div className="content">Hello 🧐</div>
      </div>
      <Footer />
    </div>
  );
}

export default App;

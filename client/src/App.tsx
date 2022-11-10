import ToppingsView from './views/ToppingsView';
import PizzasView from './views/PizzasView';
import BuildView from './views/BuildView';
import { Routes, Route, Link } from 'react-router-dom';
import Layout from './components/Layout';
import HomeView from './views/HomeView';
import routes from './routes';

function App() {
  return (
    <Routes>
      <Route path={routes.HOME} element={<Layout />}>
        <Route index element={<HomeView />} />
        <Route path={routes.TOPPINGS} element={<ToppingsView />} />
        <Route path={routes.PIZZAS} element={<PizzasView />} />
        <Route path={routes.BUILD_A_PIZZA} element={<BuildView />} />
        <Route path={routes.NO_MATCH} element={<NoMatch />} />
      </Route>
    </Routes>
  );
}

function NoMatch() {
  return (
    <div>
      <h2>Nothing to see here!</h2>
      <p>
        <Link to='/'>Go to the home page</Link>
      </p>
    </div>
  );
}

export default App;

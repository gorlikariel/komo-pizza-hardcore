import styled from 'styled-components';
import { NavLink, useNavigate, useLocation } from 'react-router-dom';
import routes from '../routes';

const navRoutes = [
  { to: routes.PIZZAS, title: 'Our Pizzas' },
  { to: routes.TOPPINGS, title: 'Our Toppings' },
  { to: routes.BUILD_A_PIZZA, title: 'Build your own!' },
];

const Nav = styled.nav`
  padding: 1.5rem 0 1.5rem 0;
  align-items: center;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  @media (max-width: 600px) {
    grid-template-columns: 1fr 1fr 1fr;
  }
`;

const StyledLink = styled(NavLink)<{ $selected?: boolean }>`
  color: ${(props) => (props.$selected ? 'green' : '#0f0f0f')};
  font-weight: ${(props) => (props.$selected ? 600 : 400)};
  box-shadow: ${(props) =>
    props.$selected ? ' 0px 0px 19px 10px #8b4513;' : null};
  padding: 0.6em;
  border-radius: 50% 10px 10px;
  text-decoration: none;
  font-size: ${(props) => (props.$selected ? '1.7rem' : '1.2rem')};

  text-transform: uppercase;
  transition: transform 0.1s ease-in-out;
  justify-self: center;
  &:hover {
    transform: scale(1.5);
  }

  @media (max-width: 600px) {
    grid-template-columns: 1fr 1fr 1fr;
    font-size: 0.7rem;
  }
`;

const LinkContainer = styled.div`
  display: flex;
  justify-content: center;
`;

const Logo = styled.img`
  border-radius: 50%;
  animation: glow 1.5s linear infinite alternate;
  transition: transform 3.5s ease-in-out;
  box-shadow: 0px 0px 9px 4px #8b4513;
  justify-self: center;
  cursor: pointer;
  &:hover {
    transform: rotate(4000deg) scale(1.8);
  }
  @media (max-width: 600px) {
    display: none;
  }

  width: 7em;
`;

const NavContainer = styled.div`
  width: 100%;
  background-color: #ffff;
  opacity: 0.9;
  box-shadow: rgba(0, 0, 0, 0.15) 0px 2px 8px;
`;

const NavBar = () => {
  const navigate = useNavigate();
  const location = useLocation();
  return (
    <NavContainer>
      <Nav>
        <Logo
          onClick={() => navigate('')}
          src='https://i.ibb.co/WyrX4yV/ugly-pizza-modified.png'
          alt='pizza logo'
        />

        {navRoutes.map(({ to, title }) => (
          <LinkContainer key={`${title}${to}`}>
            <StyledLink to={to} $selected={`/${to}` === location.pathname}>
              {title}
            </StyledLink>
          </LinkContainer>
        ))}
      </Nav>
    </NavContainer>
  );
};

export default NavBar;

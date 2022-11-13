import { Outlet } from 'react-router';
import styled from 'styled-components';
import NavBar from './NavBar';

const Container = styled.div`
  padding: 3.5em;
  @media (max-width: 600px) {
    padding: 2.2em;
  }
`;

const Layout = () => {
  return (
    <>
      <NavBar />
      <Container>
        <Outlet />
      </Container>
    </>
  );
};

export default Layout;

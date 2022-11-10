import { Outlet } from 'react-router';
import styled from 'styled-components';
import NavBar from './NavBar';

export default function Layout() {
  return (
    <div>
      <NavBar />
      <Container>
        <Outlet />
      </Container>
    </div>
  );
}

const Container = styled.div`
  padding: 40px;
  @media (max-width: 600px) {
    padding: 15px;
  }
`;

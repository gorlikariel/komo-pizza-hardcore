import styled from 'styled-components';

const Container = styled.div`
  color: white;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
`;

const PhoneLink = styled.a`
  color: red;
  cursor: pointer;
`;

const HomeView = () => {
  return (
    <Container>
      <h1>WELCOME TO KOMO PIZZA!</h1>
      <span>
        For orders call Ariel at -{' '}
        <PhoneLink href='tel:0509012770'>0509012770</PhoneLink>
      </span>
      <code>* online orders coming soon</code>
    </Container>
  );
};

export default HomeView;

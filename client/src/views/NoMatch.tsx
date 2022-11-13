import { Link } from 'react-router-dom';
import styled from 'styled-components';
import Label from '../components/Label';

const Container = styled.div`
  color: white;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-container: center;
`;

const NoMatch = () => {
  return (
    <Container>
      <Label text='Nothing to see here!' />
      <Link to='/'>Go to the home page</Link>
    </Container>
  );
};

export default NoMatch;

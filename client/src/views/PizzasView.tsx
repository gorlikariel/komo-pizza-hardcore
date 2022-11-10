import styled from 'styled-components';
import { useQuery } from 'urql';
import Pizza, { PizzaToppingData } from '../components/Pizza';
import { PizzasQuery } from '../data/query';

interface PizzaData {
  id: number;
  name: string;
  price: number;
  crust: string;
  image: string;
  pizza_toppings: PizzaToppingData[];
}

interface PizzasData {
  pizzas: PizzaData[];
}

const PizzasContainer = styled.div`
  display: grid;
  justify-content: center;
  grid-template-columns: repeat(1fr);
  grid-gap: 5vmax;
  @media (max-width: 600px) {
    grid-template-columns: 1fr;
    grid-gap: 2vmax;
  }
`;

const PizzasView = () => {
  const [{ fetching, data }] = useQuery<PizzasData>({ query: PizzasQuery });

  return fetching ? null : (
    <PizzasContainer>
      {data?.pizzas.map(({ pizza_toppings, id, crust, name, price, image }) => {
        return (
          <Pizza
            crust={crust}
            image={image}
            key={`${name}${id}`}
            id={id}
            name={name}
            price={price}
            toppings={pizza_toppings}
          />
        );
      })}
    </PizzasContainer>
  );
};

export default PizzasView;

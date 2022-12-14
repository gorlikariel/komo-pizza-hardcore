import { useState } from 'react';
import styled from 'styled-components';
import { useQuery } from 'urql';
import Label from '../components/Label';
import SelectTopping from '../components/SelectTopping';
import { ToppingsQuery } from '../data/query';

export interface ToppingData {
  id: number;
  image: string;
  name: string;
  price: number;
}

interface ToppingsData {
  toppings: ToppingData[];
}

const ToppingsGrid = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(600px, 1fr));
  justify-items: center;
  @media (max-width: 700px) {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
`;

const Container = styled.div`
  display: flex;
  flex-direction: column;
  justify-items: center;
  align-items: center;
  color: white;
`;

const OrderButton = styled.a`
  left: 0;
  color: red;
  font-size: 1.5em;
  margin: 1em;
  padding: 1em;
  border: 4px solid black;
  background-color: white;
  border-radius: 25px;
`;

const BuildView = () => {
  const [{ data }] = useQuery<ToppingsData>({ query: ToppingsQuery });
  const [totalPrice, setTotalPrice] = useState(0);
  // const [selectedToppings, setSelectedToppings] = useState([]);
  const addTopping = (topping: ToppingData) => {
    const { price } = topping;
    setTotalPrice(totalPrice + price);
  };

  const removeTopping = (topping: ToppingData) => {
    const { price } = topping;
    setTotalPrice(totalPrice - price);
  };

  return (
    <>
      <Container>
        <Label
          fontSize='2em'
          color='white'
          text={`Total Price: ${totalPrice / 100}$`}
        />
        <OrderButton href='tel:0509012770'>!!ORDER NOW!!</OrderButton>
      </Container>
      <ToppingsGrid>
        {data?.toppings.map((topping) => {
          return (
            <SelectTopping
              addTopping={addTopping}
              removeTopping={removeTopping}
              topping={topping}
              key={topping.image + topping.price}
            />
          );
        })}
      </ToppingsGrid>
    </>
  );
};

export default BuildView;

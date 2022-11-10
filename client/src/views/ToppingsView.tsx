import * as React from 'react';
import styled from 'styled-components';
import { useQuery } from 'urql';
import EditableTopping from '../components/EditableTopping';
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

export default function ToppingsView() {
  const [{ fetching, data }] = useQuery<ToppingsData>({ query: ToppingsQuery });

  return fetching ? null : (
    <ToppingsContainer>
      {data?.toppings.map(({ id, name, price, image }) => {
        return (
          <EditableTopping
            image={image}
            key={`${name}${id}`}
            id={id}
            name={name}
            price={price}
          />
        );
      })}
    </ToppingsContainer>
  );
}

const ToppingsContainer = styled.div`
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  grid-gap: 40px;
  @media (max-width: 600px) {
    grid-template-columns: 1fr;
    grid-gap: 20px;
  }
`;

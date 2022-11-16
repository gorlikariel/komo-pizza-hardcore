import styled from "styled-components";
import { useQuery } from "urql";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
import EditableTopping from "../components/EditableTopping";
import { ToppingsQuery } from "../data/query";

export interface ToppingData {
  id: number;
  image: string;
  name: string;
  price: number;
}
interface ToppingsData {
  toppings: ToppingData[];
}

const ToppingsContainer = styled.div`
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  grid-gap: 5vmax;
  @media (max-width: 600px) {
    grid-template-columns: 1fr;
    grid-gap: 2vmax;
  }
`;

const ToppingsView = () => {
  const [{ fetching, data }] = useQuery<ToppingsData>({ query: ToppingsQuery });

  return fetching ? (
    <ToppingsContainer>
      {[...new Array(9)].map(() => {
        return (
          <>
            <Skeleton height="10em" width="17em" count={1} />
          </>
        );
      })}
    </ToppingsContainer>
  ) : (
    <ToppingsContainer>
      {data?.toppings.map(({ id, name, price, image }) => {
        return (
          <>
            <EditableTopping
              image={image}
              key={`${name}${id}`}
              id={id}
              name={name}
              price={price}
            />
          </>
        );
      })}
    </ToppingsContainer>
  );
};

export default ToppingsView;

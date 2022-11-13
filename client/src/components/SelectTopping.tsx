import { useState } from 'react';
import styled from 'styled-components';
import { ToppingData } from '../views/ToppingsView';
import Icon from './Icon';
import Label from './Label';

interface SelectToppingProps {
  addTopping: (topping: ToppingData) => void;
  removeTopping: (topping: ToppingData) => void;
  topping: ToppingData;
}

interface StarProps {
  width?: string;
}

const StarDropShadow = styled.div`
  filter: drop-shadow(-1px 26px 3px rgba(123, 92, 0, 0.6));
`;

const Star = styled.div<StarProps>`
  
  aspect-ratio: 1;  
  clip-path: polygon(
    50% 0%,
    61% 35%,
    98% 35%,
    68% 57%,
    79% 91%,
    50% 70%,
    21% 91%,
    32% 57%,
    2% 35%,
    39% 35%
  );
  box-shadow: 0px 0px 9px 4px #8b4513;
  min-height: 12em;
  background-color: green;
  display: flex;
  flex-direction: column;
  width: ${({ width }) => width || '35em'}}
  justify-content: center;
  align-items: center;
  transition: transform 0.2s, box-shadow 0.3s;
  &:hover {
    transform: perspective(0px);
    box-shadow: rgb(85, 91, 255) 0px 0px 0px 3px,
      rgb(31, 193, 27) 0px 0px 0px 6px, rgb(255, 217, 19) 0px 0px 0px 9px,
      rgb(255, 156, 85) 0px 0px 0px 12px, rgb(255, 85, 85) 0px 0px 0px 15px;
  }
  @media (max-width: 600px) {
    width: 25em;
  }
`;

const ToppingSelector = styled.div`
  display: flex;
  cursor: pointer;
  align-items: center;
  padding-bottom: 0.4em;
`;

const SelectTopping = ({
  addTopping,
  removeTopping,
  topping,
}: SelectToppingProps) => {
  const [count, setCount] = useState(0);
  const { image, name, price } = topping;
  const add = () => {
    setCount(count + 1);
    addTopping(topping);
  };

  const remove = () => {
    if (!count) {
      return;
    }
    setCount(count - 1);
    removeTopping(topping);
  };
  return (
    <StarDropShadow>
      <Star width='32em'>
        <Label title='counter' text={`${count}`} />
        <Label text={name} />
        <ToppingSelector>
          <Icon
            width='1.8em'
            onClick={remove}
            src='https://cdn-icons-png.flaticon.com/512/929/929430.png'
            alt='minus'
          />
          <Icon width='3em' alt={name} src={image} />
          <Icon
            onClick={add}
            width='1.8em'
            src='https://cdn-icons-png.flaticon.com/512/148/148764.png'
            alt='plus'
          />
        </ToppingSelector>
        <Label text={`Price: ${price / 100}$`} />
      </Star>
    </StarDropShadow>
  );
};

export default SelectTopping;

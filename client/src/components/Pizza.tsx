import styled from 'styled-components';
import ReactTooltip from 'react-tooltip';
import { ToppingData } from '../views/ToppingsView';
import Label from './Label';

export interface PizzaToppingData {
  topping: ToppingData;
}

interface PizzaProps {
  id: number;
  name: string;
  crust: string;
  price: number;
  image: string;
  toppings: PizzaToppingData[];
}

interface StyledIconProps {
  width?: string;
  noGlow?: boolean;
}

export default function Pizza(props: PizzaProps) {
  const { name, price, image, toppings, crust } = props;

  return (
    <Container>
      <ToppingsList>
        <Label text='On Top: ' color='black' />
        <List>
          {toppings.map(({ topping: { name, image: toppingImage } }) => {
            return (
              <li data-tip={name} key={`${toppingImage}${name}`}>
                <Icon noGlow width='50px' alt={name} src={toppingImage} />
              </li>
            );
          })}
        </List>
        <Label text={`${crust} Crust!`} color='black' />
      </ToppingsList>
      <StarBurstDropShadow>
        <StarBurst>
          <Label text={name} />
          <Icon width='35%' alt={name} src={image} />
          <PriceDisplay>Price: {`${price / 100}$`}</PriceDisplay>
        </StarBurst>
      </StarBurstDropShadow>
      <ReactTooltip />
    </Container>
  );
}

const StarBurst = styled.div`
  aspect-ratio: 1;
  clip-path: polygon(
    100% 50%,
    78.19% 60.26%,
    88.3% 82.14%,
    65% 75.98%,
    58.68% 99.24%,
    44.79% 79.54%,
    25% 93.3%,
    27.02% 69.28%,
    3.02% 67.1%,
    20% 50%,
    3.02% 32.9%,
    27.02% 30.72%,
    25% 6.7%,
    44.79% 20.46%,
    58.68% 0.76%,
    65% 24.02%,
    88.3% 17.86%,
    78.19% 39.74%
  );
  box-shadow: 0px 0px 9px 4px #8b4513;
  min-height: 12em;
  background-color: #8b4513;
  display: flex;
  flex-direction: column;
  width: 700px;
  justify-content: center;
  color: #ffff;
  align-items: center;
  transition: transform 0.2s, box-shadow 0.3s;
  &:hover {
    transform: perspective(0px);
    box-shadow: rgb(85, 91, 255) 0px 0px 0px 3px,
      rgb(31, 193, 27) 0px 0px 0px 6px, rgb(255, 217, 19) 0px 0px 0px 9px,
      rgb(255, 156, 85) 0px 0px 0px 12px, rgb(255, 85, 85) 0px 0px 0px 15px;
  }
  @media (max-width: 700px) {
    width: 250px;
  }
`;

const Icon = styled.img<StyledIconProps>`
  width: ${(props) => (props.width ? props.width : '70px')};

  box-shadow: ${(props) =>
    props.noGlow ? '' : '0px 29px 30px 30px rgba(255, 149, 5, 0.7)'};

  border-radius: 70%;
  padding: 2px;
`;

const StarBurstDropShadow = styled.div`
  filter: drop-shadow(-1px 26px 3px rgba(50, 50, 0, 0.5));
`;

const Container = styled.div`
  display: flex;
  background-color: white;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 40%;
  color: black;
  @media (max-width: 700px) {
    background-color: transparent;
  }
`;

const PriceDisplay = styled.span`
  font-style: italic;
  color: #ffff;
  font-size: 1em;
  padding-top: 7px;
  font-weight: 100;
  letter-spacing: 0.1em;
  @media (max-width: 700px) {
    font-size: 0.6em;
  }
`;

const ToppingsList = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-right: 6em;
  padding: 1em;
  margin-left: 5em;
  @media (max-width: 700px) {
    background-color: white;
    border-radius: 12%;
    margin-right: 0;
  }
`;

const List = styled.ul`
  list-style-image: url('https://yari-demos.prod.mdn.mozit.cloud/en-US/docs/Web/CSS/list-style-image/starsolid.gif');
`;

import { useState } from 'react';
import { useMutation } from 'urql';
import styled from 'styled-components';
import { ToppingPriceMutation } from '../data/query';
import Icon from './Icon';

const icons = {
  edit: 'https://i.ibb.co/s9ZpDJC/pencil.png',
  save: 'data:image/png;base64,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',
};

interface IEditableToppingProps {
  id: number;
  name: string;
  price: number;
  image: string;
}

export default function EditableTopping(props: IEditableToppingProps) {
  const [mutationState, executeMutation] = useMutation(ToppingPriceMutation);
  const { id, name, price: initialPrice, image } = props;
  const [editMode, setEditMode] = useState(false);
  const [edited, setEdited] = useState(false);
  const [currentValue, setCurrentValue] = useState<number | string>(
    initialPrice / 100
  );

  const savePrice: React.MouseEventHandler<HTMLButtonElement> = (
    event: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => {
    executeMutation({
      id,
      newPrice: Number(currentValue) * 100,
    });
    setEdited(false);
  };

  return (
    <Card>
      <Label>{name}</Label>
      <Preview>
        <Icon alt={name} src={image} />
        <EditablePrice>
          {editMode ? (
            <PriceEdit
              onChange={(e) => {
                const val = e.target.value;
                setCurrentValue(val);
                setEdited(!(Number(val) * 100 === initialPrice));
              }}
              value={currentValue}
            />
          ) : (
            <PriceDisplay>Price: {`${currentValue}$`}</PriceDisplay>
          )}
          <Edit
            onClick={() => {
              setEditMode(!editMode);
            }}
          >
            <EditLabel>Edit</EditLabel>
            <Icon width='20px' alt={'edit icon'} src={icons.edit} />
            {edited ? (
              <Icon
                width='20px'
                alt={'save icon'}
                src={icons.save}
                onClick={savePrice}
              />
            ) : null}
          </Edit>
        </EditablePrice>
      </Preview>
    </Card>
  );
}

const Card = styled.div`
  box-shadow: rgba(17, 17, 26, 0.1) 0px 4px 16px,
    rgba(17, 17, 26, 0.05) 0px 8px 32px;
  min-height: 10em;
  background-color: #ffff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 22px;
  transition: transform 0.2s, box-shadow 0.3s;
  &:hover {
    transform: perspective(0px);
    box-shadow: rgb(85, 91, 255) 0px 0px 0px 3px,
      rgb(31, 193, 27) 0px 0px 0px 6px, rgb(255, 217, 19) 0px 0px 0px 9px,
      rgb(255, 156, 85) 0px 0px 0px 12px, rgb(255, 85, 85) 0px 0px 0px 15px;
  }
`;

const Label = styled.span`
  font-size: 1.2em;
  text-decoration: underline;
  font-weight: 500;
  padding-bottom: 20px;
`;

const Preview = styled.div`
  display: flex;
  gap: 10px;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
  min-width: 200px;
`;

const PriceDisplay = styled.span`
  font-style: italic;
  font-weight: 100;
  letter-spacing: 0.1em;
`;

const PriceEdit = styled.input`
  font-weight: 100;
  width: 50px;
  letter-spacing: 0.1em;
`;

const EditablePrice = styled.div`
  display: flex;
  align-items: center;
  flex-direction: column;
`;

const Edit = styled.button`
  display: flex;
  flex-direction: row;
  border: none;
  background-color: inherit;
  align-items: center;
  cursor: pointer;
`;

const EditLabel = styled.span`
  font-size: 1em;
  font-weight: 600;
  font-style: italic;
`;

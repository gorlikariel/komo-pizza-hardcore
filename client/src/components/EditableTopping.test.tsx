import { render, screen } from '@testing-library/react';
import EditableTopping from './EditableTopping';
import userEvent from '@testing-library/user-event';
import { toppingData } from '../data/testData';

const { id, image, name, price } = toppingData;
it('clicking the edit button opens the price input', async () => {
  const user = userEvent.setup();
  render(<EditableTopping image={image} id={id} name={name} price={price} />);
  const editButton = screen.getByRole('button');
  await user.click(editButton);
  const inputElement = screen.getByRole('textbox');
  expect(inputElement).toBeInTheDocument();
});

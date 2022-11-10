import { render, screen } from '@testing-library/react';
import SelectTopping from './SelectTopping';
import userEvent from '@testing-library/user-event';
import { toppingData } from '../data/testData';
import { ToppingData } from '../views/ToppingsView';

const testProps = {
  addTopping: (topping: ToppingData) => {
    console.log(topping);
  },
  removeTopping: (topping: ToppingData) => {
    console.log(topping);
  },
  topping: toppingData,
};
const { topping, addTopping, removeTopping } = testProps;
it('counter goes up when adding a topping', async () => {
  const user = userEvent.setup();
  render(
    <SelectTopping
      removeTopping={removeTopping}
      addTopping={addTopping}
      topping={topping}
    />
  );
  const counterElement = await screen.findByTitle('counter');
  const counterValueBeforeClick = Number(counterElement.textContent);
  const addButton = await screen.findByAltText('plus');
  await user.click(addButton);
  const counterValueAfterClick = Number(counterElement.textContent);
  expect(counterValueAfterClick).toBeGreaterThan(counterValueBeforeClick);
});

it('counter should stay at 0 when trying to remove below it', async () => {
  const user = userEvent.setup();
  render(
    <SelectTopping
      removeTopping={removeTopping}
      addTopping={addTopping}
      topping={topping}
    />
  );
  const counterElement = await screen.findByTitle('counter');
  const counterValueBeforeClick = Number(counterElement.textContent);
  const removeButton = await screen.findByAltText('minus');
  await user.click(removeButton);
  const counterValueAfterClick = Number(counterElement.textContent);
  expect(counterValueAfterClick).toEqual(counterValueBeforeClick);
});

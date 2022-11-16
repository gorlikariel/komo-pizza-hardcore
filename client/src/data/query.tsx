/* eslint-disable import/no-anonymous-default-export */

export const ToppingsQuery = `{
    toppings ( order_by: {id: asc}){
        id
        name
        price
        image
      }
  }`;

export const PizzasQuery = `{
    pizzas ( order_by: {id: asc}){
        id
        name
        price
        image
        crust
        pizza_toppings {
          topping {
            id
            name
            price
            image
          }
        }
      }
  }`;

export const ToppingPriceMutation = `
mutation updateToppingPrice($id:Int!, $newPrice:Int!) {
  update_toppings(where: { id: {_eq: $id}}, _set:{price: $newPrice}){
    affected_rows
  }
}
`;

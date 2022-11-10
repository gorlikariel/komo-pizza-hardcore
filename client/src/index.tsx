import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import { BrowserRouter } from 'react-router-dom';
import App from './App';
import { createClient, Provider } from 'urql';
const client = createClient({
  url: 'http://localhost:8080/v1/graphql',
});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Provider value={client}>
        <App />
      </Provider>
    </BrowserRouter>
  </React.StrictMode>
);

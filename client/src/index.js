import React from 'react';
import ReactDOM from 'react-dom';
import {createStore, applyMiddleware} from 'redux';
import {Provider} from 'react-redux';
import createSagaMiddleware from 'redux-saga';
import logger from 'redux-logger';
import {App} from './containers/app';

const sagaMiddleware = createSagaMiddleware();

const store = createStore(
  applyMiddleware(sagaMiddleware, logger));

sagaMiddleware.run();

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('app')
);

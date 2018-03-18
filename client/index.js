import React from 'react'
import ReactDOM from 'react-dom'

import { Provider } from 'react-redux'
import { createStore, combineReducers, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension';

import rootReducer from './reducers'
import { initializeConnection } from './actions/session'
import App from './containers/app'

import 'phoenix_html'

import style from './style/style.scss'

const store = createStore(
  rootReducer,
  composeWithDevTools(applyMiddleware(thunk))
)

store.dispatch(initializeConnection())

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('app')
)

// <ChatApp>
//   <ChatList>
//     <ChatListItem id /> 
//   </ChatList>
//   <Chat id>
//     <ChatInfoBar />
//     <ChatWindow>
//       <ChatMessage />
//     </ChatWindow>
//     <ChatInput />
//   </Chat>
// </ChatApp>

// state = {
//   currentUser: object,
//   socket: object,
//   chats: {
//     id: {
//       channel: ,
//       name: ,
//       users:
//       messages: [
//         message
//       ]
//     }
//   }
// }
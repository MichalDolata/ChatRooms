import React from 'react'
import ReactDOM from 'react-dom'
import 'phoenix_html'
import { Socket } from 'phoenix'

import style from './style/style.scss'

const token = document.head.querySelector("[name=socket_token]").content
let socket = new Socket("/socket", {params: {token}})
socket.connect()

let lobby = socket.channel("room:lobby")
lobby.join()
  .receive("ok", (message) => console.log(message))
// ReactDOM.render(
//   <div>
//     TEST
//   </div>,
//   document.getElementById('app')
// )

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
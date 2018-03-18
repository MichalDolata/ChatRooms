import { SET_SESSION } from '../constants'
import { setRooms, addRoom } from './rooms'
import { Socket } from 'phoenix'

export const initializeConnection = () => (dispatch) => {
  const token = document.head.querySelector("[name=socket_token]").content
  const socket = new Socket("/socket", {params: {token}})
  socket.connect()

  const lobby = socket.channel("room:lobby")
  lobby.on("new_room", (room) => {
    dispatch(addRoom(room))
  })

  lobby.join()
    .receive("ok", ({currentUser, rooms}) => {
      dispatch({
        type: SET_SESSION,
        session: {
          socket,
          lobby,
          currentUser
        }
      })
    dispatch(setRooms(rooms))
    })
}
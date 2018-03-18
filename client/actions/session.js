import { SET_SESSION } from '../constants'
import { setRooms } from './rooms'
import { Socket } from 'phoenix'

export const initializeConnection = () => (dispatch) => {
  const token = document.head.querySelector("[name=socket_token]").content
  const socket = new Socket("/socket", {params: {token}})
  socket.connect()

  const lobby = socket.channel("room:lobby")
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
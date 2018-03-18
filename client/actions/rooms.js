import { SET_ROOMS, JOIN_ROOM, LEAVE_ROOM, ADD_MESSAGE, ADD_ROOM, REMOVE_ROOM } from '../constants'
import { setActiveRoom, removeActiveRoom } from '../actions/activeRoom'

export const setRooms = (rooms) => {
  rooms = rooms.map((room) => {
    return {
      ...room,
      channel: null,
      messages: []
    }
  })
  return {
    type: SET_ROOMS,
    rooms: rooms
  }
}

const receiveMessage = (dispatch, message, id) => {
  dispatch({
    type: ADD_MESSAGE,
    message,
    id
  })
}

export const joinRoom = (socket, id) => (dispatch) => {
  let channel = socket.channel(`room:${id}`)
  channel.on("new_message", (message) => receiveMessage(dispatch, message, id))
  channel.join()
    .receive("ok", ({ messages }) => {
      dispatch({
        type: JOIN_ROOM,
        id,
        channel,
        messages
      })
      dispatch(setActiveRoom(id))
    })
}

export const leaveRoom = (room) => (dispatch) => {
  room.channel.leave().receive("ok", () => {
    dispatch(removeActiveRoom())
    dispatch({
      type: LEAVE_ROOM,
      id: room.id
    })
  })
}

export const sendMessage = (room, message) => {
  room.channel.push("new_message", { message: message })
}

export const addRoom = (room) => {
  return {
    type: ADD_ROOM,
    room
  }
}

export const createRoom = (socket, lobby, name) => (dispatch) => {
  lobby.push("new_room", {name}).
    receive("ok", (room) => {
      dispatch(addRoom(room)),
      dispatch(joinRoom(socket, room.id))
    })
}

export const removeRoom = (id) => {
  return {
    type: REMOVE_ROOM,
    id
  }
}
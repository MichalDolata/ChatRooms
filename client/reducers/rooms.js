import { SET_ROOMS, JOIN_ROOM, LEAVE_ROOM, ADD_MESSAGE, ADD_ROOM, REMOVE_ROOM } from '../constants'
import update from 'react-addons-update';

const initialState = []

const rooms = (state = initialState, action) => {
  switch(action.type) {
    case SET_ROOMS:
      return action.rooms
      break
    case JOIN_ROOM:
      return state.map((room) => {
        return room.id == action.id ? { ...room, channel: action.channel, messages: action.messages }
                              : room
      })
      break
    case LEAVE_ROOM:
      return state.map((room) => {
        return room.id == action.id ? { ...room, channel: null, messages: [] } : room
      })
      break
    case ADD_MESSAGE:
      return state.map((room) => {
        return room.id == action.id ? { ...room, messages: [...room.messages, action.message] }
                              : room
      })
      break
    case ADD_ROOM:
      if(state.findIndex((room) => 
        room.id == action.room.id) == -1) {
          return [
            ...state,
            {
              ...action.room,
              channel: null,
              messages: []
            }
          ]
        } else {
          state
        }
      break
    case REMOVE_ROOM:
      return state.filter((room) => {
        room.id !== action.id
      })
      break
    default:
      return state
  }
}

export const isJoinned = (rooms, id) => {
  return rooms.find((room) => {
    return room.id == id
  }).channel !== null
}

export const currentRoom = (state) => {
  const currentRoomId = state.activeRoom
  return state.rooms.find((room) => {
    return room.id == currentRoomId
  })
}

export default rooms
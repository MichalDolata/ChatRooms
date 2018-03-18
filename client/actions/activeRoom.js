import { SET_ACTIVE_ROOM, REMOVE_ACTIVE_ROOM } from '../constants'

export const setActiveRoom = (id) => {
  return {
    type: SET_ACTIVE_ROOM,
    id
  }
}

export const removeActiveRoom = () => {
  return {
    type: REMOVE_ACTIVE_ROOM
  }
}
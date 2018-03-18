import { SET_ACTIVE_ROOM, REMOVE_ACTIVE_ROOM } from '../constants'

const initialState = null;

const activeRoom = (state = initialState, action) => {
  switch(action.type) {
    case SET_ACTIVE_ROOM:
      return action.id
      break
    case REMOVE_ACTIVE_ROOM:
      return null
      break
    default:
      return state
  }
}

export default activeRoom
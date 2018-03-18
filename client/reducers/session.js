import { SET_SESSION } from '../constants'

const initialState = {
  currentUser: {
    id: 0,
    name: ""
  },
  socket: null,
  lobby: null
}

const session = (state = initialState, action) => {
  switch(action.type) {
    case SET_SESSION:
      return action.session
      break
    default:
      return state
  }
}

export const isConnected = (state) =>
  state.session.socket !== null

export default session
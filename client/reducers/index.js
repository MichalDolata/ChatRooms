import { combineReducers } from 'redux'

import session from './session'
import rooms from './rooms'
import activeRoom from './activeRoom'

export default combineReducers({
  session,
  rooms,
  activeRoom
})
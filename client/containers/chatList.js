import React, { Component } from 'react'
import { connect } from 'react-redux'

import ChatListItem from '../components/chatListItem'
import { joinRoom, createRoom } from '../actions/rooms';
import { setActiveRoom } from '../actions/activeRoom'
import { isJoinned } from '../reducers/rooms'

class ChatList extends Component {
  constructor(props) {
    super(props)

    this.handleClick = this.handleClick.bind(this)
    this.handleCreate = this.handleCreate.bind(this)
  }

  handleClick(id) {
    const { socket, dispatch, rooms } = this.props
    if(isJoinned(rooms, id)) {
      dispatch(setActiveRoom(id))
    } else {
      dispatch(joinRoom(socket, id))
    }
  }

  handleCreate() {
    const { dispatch, lobby, socket } = this.props
    let name = window.prompt("Enter a name for new room")
    dispatch(createRoom(socket, lobby, name))
  }

  render() {
    const rooms = this.props.rooms

    return (
    <div id="chat_list">
          <div id="chat_list_button" onClick={this.handleCreate}>
            Create new chat room
          </div>
          <ul>
            {
              rooms.map((room, id) => (
                <ChatListItem key={id} isJoinned={room.channel !== null} {...room} onClick={() => this.handleClick(room.id)} />
              ))
            }
          </ul>
          <a data-csrf="PC0tGSk9fVIeO1lCeE4PATFqSTRNJgAArjWqGm33vC1sL+fpE3yE4A==" data-method="delete" data-to="/logout" href="#" id="chat_logout" rel="nofollow">Logout</a>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    rooms: state.rooms,
    socket: state.session.socket,
    lobby: state.session.lobby
  }
}

export default connect(mapStateToProps)(ChatList)
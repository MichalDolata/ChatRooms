import React, { Component } from 'react'
import { connect } from 'react-redux'

import { leaveRoom, sendMessage } from '../actions/rooms'
import { currentRoom } from '../reducers/rooms'
import ChatBody from './chatBody';
import ChatForm from './chatForm';

class ChatFrame extends Component {  
  constructor(props) {
    super(props)

    this.leave = this.leave.bind(this)
    this.sendMessage = this.sendMessage.bind(this)
  }

  leave() {
    this.props.dispatch(leaveRoom(this.props.currentRoom))
  }

  sendMessage(message) {
    sendMessage(this.props.currentRoom, message)
  }
  
  render() {
    const { currentRoom } = this.props
    const Fragment = React.Fragment

    return (
      <div id="chat_frame">
        {currentRoom !== undefined ? 
        (<Fragment>
          <div id="chat_infobar"><span>{currentRoom.name}</span> <button onClick={this.leave}>Leave channel</button></div>
          <ChatBody />
          <ChatForm sendMessage={this.sendMessage} />
        </Fragment>) : 
        (<div></div>)
        }
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    currentRoom: currentRoom(state)
  }
}

export default connect(mapStateToProps)(ChatFrame)
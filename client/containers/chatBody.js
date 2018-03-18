import React, { Component } from 'react'
import { connect } from 'react-redux'

import { currentRoom } from '../reducers/rooms'
import ChatMessage from '../components/chatMessage'

class ChatBody extends Component {
  scrollToBottom() {
    this.messagesEnd.scrollIntoView({ behavior: "smooth" });
  }
  
  componentDidMount() {
    this.scrollToBottom();
  }
  
  componentDidUpdate() {
    this.scrollToBottom();
  }

  render() {
    const { currentRoom, currentUser } = this.props
    return (
      <div id="chat_body">
        { currentRoom.messages.map((message, id) => (
            <ChatMessage key={id} message={message} ownMessage={message.user.id === currentUser.id} />
          ))
        } 
        <div ref={(el) => { this.messagesEnd = el }}></div>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    currentRoom: currentRoom(state),
    currentUser: state.session.currentUser
  }
}

export default connect(mapStateToProps)(ChatBody)
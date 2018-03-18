import React, { Component } from 'react'

class ChatMessage extends Component {
  render() {
    const { message, ownMessage } = this.props
    const time = new Date(message.time)
    const type = ownMessage ? 'sent' : 'received'
    const classes = `message message-${type}`
    return (
      <div className={classes}>
        <small>{time.toTimeString().split(' ')[0].split(':').slice(0, -1).join(':')} <span className="message-sender">{message.user.name}: </span></small>
        <span>{message.message}</span>
      </div>
    )
  }
}

export default ChatMessage
import React, { Component } from 'react'

class ChatListItem extends Component {
  render() {
    const { name, users, onClick, isJoinned } = this.props
    return (
      <li className="chat_list_item" onClick={onClick}>
        <span>{name} {isJoinned && <small>(Joined)</small>}</span> 
        <span className="badge badge-primary badge-pill">{users}</span>
      </li>
    )
  }
}

export default ChatListItem
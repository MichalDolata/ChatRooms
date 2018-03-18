import React, { Component } from 'react'
import { connect } from 'react-redux'

class ChatForm extends Component {
  constructor(props) {
    super(props)

    this.state = { message: '' }

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleChange(event) {
    this.setState({ message: event.target.value })
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.sendMessage(this.state.message)
    this.setState({message: ''})
  }

  render() {
    return (
      <form id="chat_form" onSubmit={this.handleSubmit}>
        <input type="text" id="chat_input" value={this.state.message} onChange={this.handleChange} />
        <button id="chat_send_button">Send</button>
      </form>
    )
  }
}

export default ChatForm
import React, { Component } from 'react'
import { connect } from 'react-redux'

import { isConnected } from '../reducers/session'

import ChatList from './chatList'
import ChatFrame from './chatFrame'

class App extends Component {
  render() {
    const Fragment = React.Fragment

    return (
      <Fragment>
        <ChatList />
        <ChatFrame />
      </Fragment>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    isConnected: isConnected(state)
  }
}

export default connect(mapStateToProps)(App)
import React, { Component } from 'react'
import ReactDOM from 'react-dom'

export default class HeaderNav extends Component {
  constructor (props) {
    super(props)

    this.toggleNavbar = this.toggleNavbar.bind(this)
    this.state = {
      collapsed: true
    }
  }

  toggleNavbar () {
    this.setState({
      collapsed: !this.state.collapsed
    })
  }
  render () {
    return (
      <div>
        <nav className="" id="application_nav">
          <div className="hamburger">
            <span></span>
            <span></span>
            <span></span>
          </div>
          <h4>Beacon</h4>
        </nav>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <HeaderNav />,
    document.querySelector('.navigation'),
  )
})

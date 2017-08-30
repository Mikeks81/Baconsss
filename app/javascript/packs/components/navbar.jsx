import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import SideNav from './side-nav.jsx'

export default class HeaderNav extends Component {
  constructor (props) {
    super(props)

    this.toggleNavbar = this.toggleNavbar.bind(this)
    this.state = {
      collapsed: true
    }
  }

  componentWillMount () {
    // const contentProps = document.getElementById('navigation')
    // console.log(contentProps.getAttribute('data'))
  }

  toggleNavbar () {
    this.setState({
      collapsed: !this.state.collapsed
    })
  }
  render () {
    console.log(this.props)
    return (
      <div>
        <SideNav {...this.props} />
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
  const erbProps = document.getElementById('navigation')
  const data = JSON.parse(erbProps.getAttribute('data'))
  ReactDOM.render(
    <HeaderNav {...data} />,
    document.querySelector('.navigation'),
  )
})

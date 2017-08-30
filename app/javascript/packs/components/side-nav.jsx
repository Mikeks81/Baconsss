import React, { Component } from 'react'

export default class SideBar extends Component {
  render () {
    const props = this.props
    return (
      <div>
        <div className='side-navi'>
          <div className='menu-container'>
            <ul>
              <li>
                <a href={props.root_path}> Home </a>
              </li>
              <li>
                <a href={props.edit_user_path}> Edit User </a>
              </li>
              <li>
                <a href={props.user_contacts_path}> Contacts </a>
              </li>
              <li>
                <a href='#'>HELLO</a>
              </li>
              <li>
                <a href='#'>HELLO</a>
              </li>
              <li>
                {props.current_user &&
                  <a href={props.destroy_user_session_path} className='logout'
                  method='delete'>
                   Log Out
                  </a>
                }
              </li>
            </ul>
          </div>
        </div>
        <div className='side-navi-fade' />
      </div>
    )
  }
}

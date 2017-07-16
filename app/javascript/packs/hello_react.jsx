// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'
import { AutoComplete } from 'material-ui'
import injectTapEventPlugin from 'react-tap-event-plugin'

export default class Hello extends Component {
  constructor (props) {
    super(props)
    injectTapEventPlugin()
    this.state = {
      dataSource: []
    }
  }

  handleUpdateInput (value) {
    this.setState({
      dataSource: [
        value,
        value + value,
        value + value + value
      ]
    })
  };

  render () {
    return (
      <MuiThemeProvider>
        <div>
          <div>Hello {this.props.name}!</div>
          <AutoComplete
              hintText="Type anything"
              dataSource={this.state.dataSource}
              onUpdateInput={this.handleUpdateInput.bind(this)}
              floatingLabelText="Full width"
              fullWidth={true}
            />
        </div>
      </MuiThemeProvider>
    )
  }
}

// const Hello = props => (
//
//   <MuiThemeProvider>
//     <div>
//       <div>Hello {props.name}!</div>
//       <AutoComplete
//           hintText="Type anything"
//           dataSource={this.state.dataSource}
//           onUpdateInput={this.handleUpdateInput}
//           floatingLabelText="Full width"
//           fullWidth={true}
//         />
//     </div>
//   </MuiThemeProvider>
// )

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React!!!!!!!!!!!!!!" />,
    document.body.appendChild(document.createElement('div')),
  )
})

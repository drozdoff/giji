import React, {Component} from 'react';
// import {PropTypes} from 'prop-types';
import {connect} from 'react-redux';

class App extends Component {
  render() {
    const lol = this.state;
    return (<div>Test: {lol}</div>);
  }
}

const mapStateToProps = state => (state);

export default connect(mapStateToProps)(App);

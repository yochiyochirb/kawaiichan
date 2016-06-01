import React from 'react'
import ReactDOM from 'react-dom'

var PostEditor = React.createClass({
  getInitialState: function() {
    return {title: this.props.title, body: this.props.body};
  },

  componentDidMount: function(event) {
    // Workaround: Delay a bit because it will invoked before WebSocket connection is established...
    setTimeout(() => { App.post.preview({'title': this.state.title, 'body': this.state.body}); }, 100);
  },

  handleChange: function(event) {
    App.post.preview({
      'title': document.getElementById('post_title').value,
      'body': document.getElementById('post_body').value
    });

    this.setState({
      'title': document.getElementById('post_title').value,
      'body': document.getElementById('post_body').value
    });
  },

  render: function() {
    return (
      <div>
        <div className="row">
          <div className="input-field col s12">
            <label htmlFor="post_title">Title</label>
            <input id="post_title" className="validate" type="text" name="post[title]" onChange={this.handleChange} defaultValue={this.props.title}></input>
          </div>
        </div>
        <div className="row">
          <div className="input-field col s12">
            <label htmlFor="post_body">Body</label>
            <textarea id="post_body" className="materialize-textarea" name="post[body]" onChange={this.handleChange} defaultValue={this.props.body}></textarea>
          </div>
        </div>
      </div>
    )
  }
});

var Markdown = React.createClass({
  render: function() {
    return (
      <div>
        <PostEditor {...this.props}/>
      </div>
    )
  }
})

export class Editor {
  constructor (element, props = {}) {
    this.element = element
      this._props = props
  }

  get props () {
    return this._props
  }

  set props (props) {
    Object.assign(this._props, props)
      return this.render()
  }

  render () {
    return ReactDOM.render(
      <Markdown {...this.props} />, this.element
    )
  }
}

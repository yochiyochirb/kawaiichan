import React from 'react'
import ReactDOM from 'react-dom'

var PostInput = React.createClass({
  componentDidMount: function(event){
    App.post.preview(document.getElementById('post-input').value);
  },

  handleKeyDown: function(event){
    App.post.preview(event.target.value);
  },

  render: function(){
    return (
      <div>
        <textarea id="post-input" name="post[body]" onKeyDown={this.handleKeyDown} defaultValue={this.props.body}></textarea>
      </div>
    )
  }
});

var PostPreview = React.createClass({
  getInitialState: function(){
    return { text: this.props.body };
  },

  update: function(val){
    this.setState({text: val})
  },

  render: function(){
    return (
      <div className="preview" dangerouslySetInnerHTML={{__html: this.state.text}}></div>
    )
  }
});

var Markdown = React.createClass({
  render: function(){
    return (
      <div>
        <PostInput {...this.props}/>
        <PostPreview ref="preview" {...this.props} />
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

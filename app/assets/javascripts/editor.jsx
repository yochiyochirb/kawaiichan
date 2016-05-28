import React from 'react'
import ReactDOM from 'react-dom'

var PostTitle = React.createClass({
  componentDidMount: function(event){
    App.post.preview(document.getElementById('post_title').value);
  },

  handleKeyDown: function(event){
    App.post.preview({ 'title': event.target.value, 'body': document.getElementById('post_body').value });
  },

  render: function(){
    return (
      <div className="form-group">
        <label htmlFor="post_title">Title</label>
        <input id="post_title" className="form-control" type="text" name="post[title]" onKeyDown={this.handleKeyDown} defaultValue={this.props.title}></input>
      </div>
    )
  }
});

var PostBody = React.createClass({
  componentDidMount: function(event){
    App.post.preview(document.getElementById('post_body').value);
  },

  handleKeyDown: function(event){
    App.post.preview({ 'title': document.getElementById('post_title').value, 'body': event.target.value });
  },

  render: function(){
    return (
      <div className="form-group">
        <label htmlFor="post_body">Body</label>
        <textarea rows="35" id="post_body" className="form-control" name="post[body]" onKeyDown={this.handleKeyDown} defaultValue={this.props.body}></textarea>
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
        <PostTitle {...this.props}/>
        <PostBody {...this.props}/>
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

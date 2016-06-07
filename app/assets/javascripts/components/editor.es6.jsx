class Editor extends React.Component {
  handleChange(event) {
    App.post.preview({
      'title': document.getElementById('post_title').value,
      'body': document.getElementById('post_body').value
    });
  }

  componentDidMount() {
    // Workaround for triggering materialize autoresizing function on TextArea
    $('#post_body').keyup();
  }

  render() {
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
    );
  }
}

Editor.propTypes = {
  title: React.PropTypes.string,
  body: React.PropTypes.string
};

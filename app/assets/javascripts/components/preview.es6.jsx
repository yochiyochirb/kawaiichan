class Preview extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      content: this.props.content
    };
  }

  componentDidMount() {
    this.setupSubscription();
  }

  update(val) {
    this.setState({ content: val });
  }

  setupSubscription() {
    App.post = App.cable.subscriptions.create('PostChannel', {
      received(data) {
        this.update(data['preview_html']);
      },

      preview(source) {
        this.perform('preview', { 'source': source });
      },

      update: this.update.bind(this)
    });
  }

  render() {
    return (
      <div
        className="post__preview"
        dangerouslySetInnerHTML={{ __html: this.state.content }}
      ></div>
    );
  }
}

Preview.propTypes = {
  content: React.PropTypes.string
};

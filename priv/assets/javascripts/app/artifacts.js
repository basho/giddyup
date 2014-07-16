/** @jsx React.DOM **/
var shortPath = function(url){
  // We want to extract the shortest meaningful path from the given
  // URL. For now we assume the file will either be named "ID.log"
  // where ID is a number, or "ID/some/deep/path/to/tehfile.bmp". For
  // the former, just return the full thing, for the latter, strip off
  // the ID prefix.
  if(url === undefined || url === null)
    return '';

  var path = url.split("/").slice(3);
  if(path[0].match("^[0-9]+$"))
    return path.slice(1).join("/");
  else
    return path.join('/');
};

var parseContentType = function(ctype){
    return ctype.toString().split(";")[0].trim().split("/");
};

ArtifactList = React.createClass({
    getInitialState: function(){
        return { loaded: false };
    },
    loadArtifacts: function(){
        var self = this;
        GiddyUp.fetchArtifacts(this.props.test_result,
                               function(artifacts){
                                   self.setState({ loaded: true });
                               });
    },
    componentDidMount: function(){
        if(this.props.active){
            this.loadArtifacts();
        }
    },
    componentWillReceiveProps: function(nextProps){
        if(nextProps.active && !this.state.loaded)
            this.loadArtifacts();
    },
    render: function(){
        var active = this.props.active,
            loaded = this.state.loaded,
            showing = this.props.showing,
            artifacts = this.props.test_result.artifacts,
            friendlyUrl = this.props.friendlyUrl;
        if(active && loaded){
            var list = artifacts.map(function(a){
                return <ArtifactLink showing={showing}
                        key={a.id} artifact={a} friendlyUrl={friendlyUrl}/>;
            });
            return <ul className="nav nav-list">{list}</ul>;
        } else {
            return <span />;
        }
    }
});

ArtifactLink = React.createClass({
    render: function(){
        var artifact = this.props.artifact,
            showing = this.props.showing,
            active = (showing.artifact_id === artifact.id.toString()),
            klass = (active) ? "active" : "",
            friendlyUrl = this.props.friendlyUrl,
            url;
        url = '#' + routie.lookup('artifact',
                                  {project_id: showing.project_id,
                                   scorecard_id: showing.scorecard_id,
                                   test_instance_id: friendlyUrl,
                                   test_result_id: showing.test_result_id,
                                   artifact_id: artifact.id});
        return (<li className={klass}>
                  <a href={url}>
                    <MediaIcon ctype={artifact.content_type} />
                    {shortPath(artifact.url)}
                  </a>
                </li>);
    }
});


MediaIcon = React.createClass({
    render: function(){
        var ctype = this.props.ctype,
            type = parseContentType(ctype),
            major = type[0],
            minor = type[1],
            icon;

        if(major === 'image'){
            icon = 'icon-picture';
        } else if(major === 'text') {
            if(minor === 'csv'){
                icon = 'icon-th';
            } else {
                icon = 'icon-pencil';
            }
        } else {
            icon = 'icon-file';
        }
        return (<i className={icon} />);
    }
});

ArtifactDisplay = React.createClass({
    findArtifact: function(test, test_result_id, artifact_id){
        var test_result = undefined,
            artifact = undefined;
        test.test_results.forEach(function(tr){
            if(tr.id.toString() === test_result_id){
                test_result = tr;
            }
        });
        if(test_result && test_result.artifactsById){
            artifact = test_result.artifactsById[artifact_id];
        }
        return artifact;
    },
    render: function(){
        var showing = this.props.showing,
            artifact;
        if(showing.artifact_id){
            artifact = this.findArtifact(this.props.test,
                                         showing.test_result_id,
                                         showing.artifact_id);
            if(artifact === undefined || artifact === null){
                return <div className="span9 well">Loading...</div>
            } else {
                return (<div className="span9"><ArtifactElement artifact={artifact} /></div>);
            }
        } else {
            return (<div className="span9 well">Select a test artifact to view its contents.</div>);
        }
    }
});

ArtifactElement = React.createClass({
    getInitialState: function(){
        return { text: undefined };
    },
    componentDidMount: function(){
        var artifact = this.props.artifact;
        this.loadContents(artifact);
    },
    componentWillReceiveProps: function(nextProps){
        if(this.props.artifact !== nextProps.artifact){
            this.setState({text: undefined});
            this.loadContents(nextProps.artifact);
        }
    },
    loadContents: function(artifact){
       var major = parseContentType(artifact.content_type)[0],
           self = this;
        if(major === 'text') {
            GiddyUp.fetchArtifactContents(artifact, function(t){
                self.setState({ text: t });
            });
        }
    },
    render: function(){
        var artifact = this.props.artifact,
            major = parseContentType(artifact.content_type)[0];

        if(major === 'image'){
            return <img src={artifact.url} />;
        } else if (major === 'text') {
            if(this.state.text){
                return <pre className="unabridged">{this.state.text}</pre>;
            } else {
                return <pre className="unabridged">Loading...</pre>;
            }
        } else {
            return (<p>
                    <i className="icon-download"/>
                    <a target="_blank" href={artifact.url}>Download this artifact</a>
                    </p>);
        }
    }
});

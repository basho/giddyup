/** @jsx React.DOM */
Matrix = React.createClass({
    getInitialState: function(){
        return {loaded: false};
    },
    componentDidMount: function(){
        this.loadMatrix(this.props.scorecard);
    },
    componentWillReceiveProps: function(nextProps) {
        if(this.props.scorecard !== nextProps.scorecard){
            this.setState({loaded: false});
            this.loadMatrix(nextProps.scorecard);
        }
    },
    render: function() {
        return (this.state.loaded) ? (
            <table className="table table-striped" key={this.props.scorecard.id}>
                <MatrixHeader platforms={this.props.scorecard.platforms}
                              scorecard={this.props.scorecard} />
                <MatrixBody scorecard={this.props.scorecard}
                    platforms={this.props.scorecard.platforms}
                    tests={this.props.scorecard.tests} />
            </table>
        ) : (<table className="table table-striped" key={this.props.scorecard.id}></table>);
    },
    loadMatrix: function(scorecard) {
        var self = this;
        GiddyUp.fetchMatrix(scorecard, function(){ self.setState({ loaded: true });  });
    }
});

MatrixHeader = React.createClass({
    render: function(){
        var scorecardId = this.props.scorecard.id;
        var headers = this.props.platforms.map(function(p){return (<th key={p}><a href={"/scorecards/" + scorecardId + "/" + p + "/coverage"}>{p}</a></th>); });
        return (<thead>
                <th></th>
                {headers}
                </thead>);
    }
});

MatrixBody = React.createClass({
    render: function(){
        var rows = [];
        for(testname in this.props.tests){
            rows.push(<MatrixRow scorecard={this.props.scorecard}
                                 key={testname}
                                 test={this.props.tests[testname]}
                                 platforms={this.props.platforms} />);
        }
        return (<tbody> {rows} </tbody>);
    }
});

MatrixRow = React.createClass({
    render: function(){
        var cells = [];
        var props = this.props;
        props.platforms.forEach(function(p){
            var platform = props.test[p];
            cells.push(<MatrixCell key={p} bubbles={platform}
                       scorecard={props.scorecard} />);
        });
        cells.unshift(<td key={"title"}>{this.props.key}</td>);
        return (<tr> {cells} </tr>);
    }
});

MatrixCell = React.createClass({
    render: function() {
        var props = this.props,
            bubbles = props.bubbles.map(function(b){
                return (<MatrixBubble key={b.id} test={b}
                                      scorecard={props.scorecard} />);
            });
        return (<td>{bubbles}</td>);
    }
});

var resultStatus = function(tr){ return tr.status; };

var bubbleBackgroundStyle = function(test){
    var status = bubbleStatus(test),
        testResults, gradient, stepSize,
        red = "#b94a48", green = "#468847";
    if(status === 'warning'){
      testResults = test.test_results.map(resultStatus).slice(0,4);
      stepSize = 100 / test.test_results.length;
      gradient = "linear-gradient(right";
      testResults.forEach(function(st, idx){
        var color = (st === true) ? green : red;
        gradient += ", " + color + " " + (stepSize * idx) + "%";
        gradient += ", " + color + " " + (stepSize * (idx+1)) + "%";
      });
      gradient += ")";
      var fgradient = ["-moz-", "-ms-", "-o-", "-webkit-", ""].map(
          function(prefix){ return "background-image: " + prefix +
                            gradient; }).join("; ");
      // ugly hack because React or DOM doesn't allow multiple
      // elements of the same style
      return {background: "inherit; " + fgradient};
    } else {
      return {};
    }
};

var bubbleStatus = function(test){
    if(test.test_results.length === 0){
        return null;
    } else {
        if(test.test_results.every(resultStatus)){
            return true;
        }
        if(test.test_results.some(resultStatus)){
            return 'warning';
        }
        return false;
    }
};

var bubbleClassName = function(test){
    var status = bubbleStatus(test),
        classes = ['badge'];

    if(status === true) {
      classes.push('badge-success');
    }
    if(status === false) {
      classes.push('badge-important');
    }
    if(status === 'warning') {
      classes.push('badge-warning');
    }
    if(status === undefined) {
      classes.push('badge-loading');
    }
    return classes.join(' ');
};

var bubbleAbbreviation = function(test){
    var parts = [];
    switch(test.backend){
    case 'bitcask':
        parts.push('B'); break;
    case 'eleveldb':
        parts.push('L'); break;
    case 'memory':
        parts.push('M'); break;
    case 'multi':
        parts.push('N'); break;
    default:
        break;
    }

    switch(test.upgrade_version){
    case 'previous':
        parts.push('-1'); break;
    case 'legacy':
        parts.push('-2'); break;
    default:
        break;
    }

    if (parts.length === 0)
        return 'U';
    else
        return parts.join('');
};

MatrixBubble = React.createClass({
    render: function() {
        var friendlyId = friendlyTestUrl(this.props.scorecard, this.props.test),
            url = ('#' + routie.lookup('test_instance', {
                project_id: this.props.scorecard.project,
                scorecard_id: this.props.scorecard.id,
                test_instance_id: friendlyId}));
        return (<div>
                  <span className={bubbleClassName(this.props.test)}
                        style={bubbleBackgroundStyle(this.props.test)}>
                     <a href={url}>{bubbleAbbreviation(this.props.test)}</a>
                  </span>
                </div>);
    }
});

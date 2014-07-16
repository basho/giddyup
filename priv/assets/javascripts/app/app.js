/** @jsx React.DOM */
var GiddyUp = window.GiddyUp = {
    projects: [],
    projectsById: {},
    showing: {},
    activeAjax: {},
    guid: 0
};

GiddyUp.nextGuid = function(){
    GiddyUp.guid += 1;
    return GiddyUp.guid;
};

GiddyUp.sortBy = function(prop) {
    return function(a,b) {
        if(a[prop] < b[prop]) return -1;
        if(a[prop] > b[prop]) return 1;
        return 0;
    };
};

var Nav = React.createClass({
    render: function(){
        var children = [<ProjectsNav key="projects"
                        showing={this.props.showing} />];

        if(this.props.showing.project_id) {
            var pid = this.props.showing.project_id;
            var project = GiddyUp.projectsById[pid];
            if(project){
                children.push(<ScorecardsNav key={pid + "/scorecards"}
                              project={project}
                              showing={this.props.showing} />);
            }
        }
        return (<div>{children}</div>);
    }
});

var Main = React.createClass({
  render: function(){
    var showing = this.props.showing;
    if(showing.scorecard_id){
        var project, scorecard, test;
        GiddyUp.fetchProjects(function(projects){
            project = GiddyUp.projectsById[showing.project_id];
            GiddyUp.fetchScorecards(project, function(scorecards){
                scorecard = project.scorecardsById[showing.scorecard_id];
                if(showing.test_instance_id && scorecard.testsById){
                    test = scorecard.testsById[showing.test_instance_id];
                }
            });
        });
        if(project && scorecard){
            if(test){
                return (<Results scorecard={scorecard}
                        showing={showing} test={test} />);
            } else {
                return (<Matrix scorecard={scorecard} />);
            }
        } else {
            return <div />;
        }
    } else {
      return <div />;
    }
  }
});

var App = React.createClass({
    render: function(){
        return (
                <div className="container-fluid">
                  <Nav showing={this.props.showing} />
                  <Help content={Help[this.props.help]} />
                  <Loading queue={this.props.loading} />
                  <Main showing={this.props.showing} />
                </div>
        );
    }
});

GiddyUp.render = function() {
    window.requestAnimationFrame(function(){
        React.renderComponent(<App showing={GiddyUp.showing}
                                   help={GiddyUp.help}
                                   loading={GiddyUp.activeAjax} />,
                              document.getElementById('app'));
    });
};

minispade.require('polyfills');
minispade.require('ajax');
minispade.require('help');
minispade.require('loading');
minispade.require('projects');
minispade.require('scorecards');
minispade.require('matrix');
minispade.require('results');
minispade.require('artifacts');
minispade.require('raf');
minispade.require('routes');

routie.navigateToHash();

/** @jsx React.DOM */
var GiddyUp = window.GiddyUp = {
    projects: [],
    projectsById: {},
    showing: {},
    activeAjax: [],
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

var App = React.createClass({
    render: function(){
        return (
                <div className="container-fluid">
                  <Nav showing={this.props.showing} />
                  <Help content={Help[this.props.help]} />
                  <Loading queue={this.props.loading} />
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
minispade.require('help');
minispade.require('loading');
minispade.require('projects');
minispade.require('scorecards');
minispade.require('matrix');
minispade.require('raf');
minispade.require('routes');

routie.navigateToHash();

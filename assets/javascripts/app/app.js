/** @jsx React.DOM */
var GiddyUp = window.GiddyUp = {
    // projects: {},
    showing: {}
};

var sortBy = function(prop) {
    return function(a,b) {
        if(a[prop] < b[prop]) return -1;
        if(a[prop] > b[prop]) return 1;
        return 0;
    };
};

var App = React.createClass({
    render: function(){
        return (
                <div className="container-fluid">
                  <ProjectsNav />
                  <Help showing={this.props.showing} />
                </div>
        );
    }
});

var Help = React.createClass({
    getInitialState: function(){
        return {visible: false};
    },
    handleClick: function(event){
        this.setState({visible: !this.state.visible});
    },
    render: function(){
        var helpStyle = {
            right: "110px",
            left: "auto",
            top: "40px",
            display: this.state.visible ? "block" : "none"
        };
        return <div>
                 <img className="cowboy" src="/images/cowboy.png" onClick={this.handleClick} />
                 <div id="help" className="popover left" style={helpStyle}>
                   <div className="arrow" style={{top: 48}} />
                     <h3 className="popover-title">Welcome to GiddyUp!</h3>

                     <div className="popover-content">
                       <p>GiddyUp is an API and user-interface to test results we collect
                          from <code>riak_test</code>. I'm your guide, <em>Artie</em>, the
                          Lone Testing Ranger.</p>

                       <p>To get started, click a project to see which versions we've wrangled.</p>
                     </div>
                  </div>
              </div>;
    }
});

var ProjectsNav = React.createClass({
    getInitialState: function(){
        return { projects: [] };
    },
    componentDidMount: function(){
        var self = this;
        $.getJSON('/projects', function(result){
            var projects = result['projects'].sort(sortBy('name'));
            self.setState({
                projects: projects
            });
        });
    },
    render: function() {
        var projects = this.state.projects.map(function(project) {
            var key = project.name;
            return <ProjectNavLink key={key} project={project} />;
        });
        return (
                <div className="navbar" style={{marginBottom: 0}} >
                  <div className="navbar-inner">
                    <a href="#/projects" className="brand">GiddyUp</a>
                    <ul className="nav">
                      {projects}
                    </ul>
                  </div>
                </div>
        );
    }
});

var ProjectNavLink = React.createClass({
    render: function(){
        var url = "#/projects/" + this.props.project.name;
        return <li>
                  <a href={url}> {this.props.project.name} </a>
               </li>;
    }
});



React.renderComponent(<App />,
                      document.getElementById('app'));

/** @jsx React.DOM */

ScorecardsNav = React.createClass({
    getInitialState: function(){
        return { scorecards: {} };
    },
    componentDidMount: function(){
        var self = this;
        GiddyUp.fetchScorecards(
            this.props.project,
            function(scorecards){
                self.setState({scorecards: scorecards})
            });
    },
    render: function() {
        var self = this,
            links = [],
            version;
        for(version in this.state.scorecards){
            var dropdown = (<ScorecardNavGroup key={version}
                            version={version}
                            showing={this.props.showing}
                            scorecards={this.state.scorecards[version]} />);
            links.push([version, dropdown]);
        }
        links.sort(GiddyUp.sortBy(0)).reverse();
        links = links.map(function(l){ return l[1]; });
        return (
                <div className="navbar" style={{marginTop: "-1px"}}>
                  <div className="navbar-inner">
                    <ul className="nav">{links}</ul>
                  </div>
                </div>
        );

    }
});

ScorecardNavGroup = React.createClass({
    getInitialState: function(){
        return { dropdown: false };
    },
    className: function(){
        var id = this.props.showing.scorecard_id,
            match = this.props.scorecards.find(function(s){ return (s.id == id); });
            classes = ['dropdown'];
        if(this.state.dropdown)
            classes.push('open');
        if(match)
            classes.push('active');
        return classes.join(' ');
    },
    linkText: function(){
        var id = this.props.showing.scorecard_id,
            match = this.props.scorecards.find(function(s){ return (s.id == id); });
        if(match){
            return match.name;
        } else {
            return this.props.version;
        }
    },
    handleClick: function(){
        this.setState({ dropdown: (!this.state.dropdown) });
        return false;
    },
    render: function(){
        if(this.props.scorecards.length == 1) {
            return (<ScorecardNavLink
                    showing={this.props.showing}
                    scorecard={this.props.scorecards[0]} />);
        } else {
            var self = this;
            var classname = this.className();
            var text = this.linkText();
            var links = this.props.scorecards.map(function(s){
                return (
                        <ScorecardNavLink scorecard={s}
                        key={s.id}
                        showing={self.props.showing} />);
            });
            return (<li className={classname}>
                    <a href="#" className="dropdown-toggle"
                      onClick={this.handleClick}>
                      {text}
                       <b className="caret"></b>
                    </a>
                    <ul className="dropdown-menu">{links}</ul>
                    </li>);
        }
    }
});

ScorecardNavLink = React.createClass({
    render: function(){
        var active = (this.props.showing.scorecard_id ==
                      this.props.scorecard.id),
            url = '#' + routie.lookup('scorecard', {
                scorecard_id: this.props.scorecard.id,
                project_id: this.props.scorecard.project
            });

        return (<li className={active ? "active" : ""}>
                <a href={url}> {this.props.scorecard.name} </a>
                </li>);
    }
});

var groupScorecards = function(scorecards){
    var grouped = {},
        sortByName = GiddyUp.sortBy('name');
    scorecards.forEach(function(scorecard){
        var version = parseVersion(scorecard);
        if(version in grouped){
            grouped[version].push(scorecard);
            grouped[version].sort(sortByName);
        } else {
            grouped[version] = [scorecard];
        }
    });
    return grouped;
};

var parseVersion = function(scorecard){
    var name = scorecard.name,
        num_version = /\d+(?:\.\d+)+/.exec(name),
        digits;

    if(num_version === undefined || num_version === null){
        return name;
    } else {
        num_version = num_version[0];
        digits = num_version.split('.');
        for(var i = 0; i < (3 - digits.length); i++){
            num_version += ".0";
        }
        return num_version;
    }
};

GiddyUp.fetchScorecards = function(project, cb){
    if(cb === undefined || cb === null){
        cb = function(){};
    }
    if('scorecards' in project){
        cb(project.scorecards);
    } else {
        $.ajax({
            dataType: "json",
            url:"/scorecards",
            data:{ids: project.scorecard_ids},
            context:{
                helpText: "Scorecards for '" +
                    project.name + "'",
                id: GiddyUp.nextGuid()
             }}).
            done(function(result){
                project.scorecards =
                    groupScorecards(result['scorecards']);
                cb(project.scorecards);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments) });
    }
};

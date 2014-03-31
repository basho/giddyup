/** @jsx React.DOM */
Help = React.createClass({
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
                     <h3 className="popover-title">{this.props.content.title}</h3>
                     <div className="popover-content">{this.props.content.body}</div>
                  </div>
              </div>;
    }
});


Help.projects = {
    title: "Welcome to GiddyUp!",
    body: <div><p key='projects1'>GiddyUp is an API and user-interface to test results we collect
                   from <code>riak_test</code>. I'm your guide, <em>Artie</em>, the
                   Lone Testing Ranger.</p>
                <p key='projects2'>To get started, click a project to see which versions we've wrangled.</p></div>
};

Help.project = {
  title: "Yeehaw!",
  body: <p>These are all the versions we've tested on the project, which I
            reckon are called scorecards. Click one in the second row to see a
            matrix of its results.</p>
};

Help.scorecard = {
  title: "Lookout, stampede!",
  body: <div>
  <p>Y'er looking at the results of test runs for a single project
version.</p>

<p>Down the leftmost column are the test names that were run. Across
  the top are the platforms the tests were run against.</p>

<p>The colored bubbles indicate whether the latest run was a <span
   className="badge badge-success">pass</span> or a <span className="badge
   badge-important">failure</span>. Tests that have no results
   recorded are <span className="badge">gray</span>. While we're still
   counting the steers, the bubble will be <span className="badge
   badge-loading"><a>outlined</a></span>.</p>

<p>The text in the bubble tells ye' the parameters for the
test:</p>

<ul>
  <li> <span className="badge">U</span> Default backend</li>
  <li> <span className="badge">B</span> Bitcask backend</li>
  <li> <span className="badge">L</span> LevelDB backend</li>
  <li> <span className="badge">M</span> Memory backend</li>
  <li> <span className="badge">N</span> Multi-backend</li>
  <li> <span className="badge">-1</span> Upgraded from previous</li>
  <li> <span className="badge">-2</span> Upgraded from legacy</li>
</ul>

<p>"Ye' can click a bubble to see the results we got in the corral.</p></div>

};

Help.test_instance = {
  title: "Have a look-see",
  body: <div>  <p>We herded these here test results into the corral for ye'.</p>

  <p>Down the left side are all the results, whether they be good or
    bad, how old they are, and which brood <em>erm</em> version they
    came from. Select one and ye'll see its output on the right.</p></div>

};

Help.test_result = {
  title: "Git along, lil' dogie!",
  body: <p>We herded a number for ye' from the time that there test was run.
  Click an artifact to get an ideer of how things transpired.</p>
};

Help.artifact = {
  title: "Whoa, boy!",
  body: <div>  <p>That there is a lot of stuff! riak_test uses lots of four-dollar
  words, I tell ye'.</p>

  <p>Scroll down to see the rest of the output if the thing you've
  selected is text. Otherwise just have a look at the pretty
  picture!</p></div>
};

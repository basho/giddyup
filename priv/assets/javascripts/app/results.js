/** @jsx React.DOM */

var testDescription = function(test){
    var desc = [];

    if(test.name) desc.push(test.name);
    if(test.platform) desc.push(test.platform);
    if(test.backend) desc.push(test.backend);
    if(test.upgrade_version) desc.push(test.upgrade_version);
    if(test.multi_config) desc.push(test.multi_config);
    return desc.join(" / ");
};

var timeAgoInWords = function(date){
  // Based roughly on distance_of_time_in_words from Ruby on Rails,
  // with ideas from John Resig's "prettyDate" function.
  if(date === undefined || date === null)
    return '';

  var now = (new Date()).getTime(),
      distance_in_seconds = (now - date.getTime()) / 1000,
      distance_in_minutes = Math.round(distance_in_seconds / 60.0),
      distance_in_hours = Math.round(distance_in_minutes / 60.0),
      distance_in_days = Math.round(distance_in_minutes / 1440.0),
      distance_in_months = Math.round(distance_in_minutes / 43200.0),
      distance_in_years = Math.round(distance_in_days / 365);

  if(distance_in_minutes <= 1) {
    return (distance_in_minutes === 0) ? "just now" : "1 minute ago";
  } else if(distance_in_minutes >= 2 && distance_in_minutes <= 44) {
    return distance_in_minutes + " minutes ago";
  } else if(distance_in_minutes >= 45 && distance_in_minutes <= 89) {
    return "about 1 hour ago";
  } else if(distance_in_minutes >= 90 && distance_in_minutes <= 1439) {
    return "about " + distance_in_hours + " hours ago";
  } else if(distance_in_minutes >= 1440 && distance_in_minutes <= 2519) {
    return "1 day ago";
  } else if(distance_in_minutes >= 2520 && distance_in_minutes <= 43199) {
    return distance_in_days + " days ago";
  } else if(distance_in_minutes >= 43200 && distance_in_minutes <= 86399) {
    return "about 1 month ago";
  } else if(distance_in_minutes >= 86400 && distance_in_minutes <= 525599) {
    return distance_in_months + " months ago";
  } else if(distance_in_months < 13){
    return "about 1 year ago";
  } else if(distance_in_years < 2) {
    return "over 1 year ago";
  } else {
    return distance_in_years + " years ago";
  }
};

Results = React.createClass({
    render: function(){
        var scorecard = this.props.scorecard,
            test = this.props.test,
            showing = this.props.showing,
            description, scorecard_url,
            result, result_list, display;

        description = testDescription(test);
        scorecard_url = '#' + routie.lookup('scorecard',
                                      {project_id: showing.project_id,
                                       scorecard_id: showing.scorecard_id});

        result_list = test.test_results.map(function(tr){
            return (<TestResult key={tr.id} scorecard={scorecard}
                    test={test} test_result={tr} showing={showing} />);
        });
        return (<div>
                <div className="row-fluid">
                  <h4><a href={scorecard_url}>{scorecard.name}</a> : {description}</h4>
                </div>
                <div className="row-fluid">
                  <div className="span3 well">
                  <ul className="nav nav-list">{result_list}</ul>
                  </div>
                  <ArtifactDisplay showing={showing} test={test} />
                </div>
                </div>);
    }
});

TestResult = React.createClass({
    render: function(){
        var showing = this.props.showing,
            scorecard = this.props.scorecard,
            test = this.props.test,
            test_result = this.props.test_result,
            active = (test_result.id.toString() === showing.test_result_id),
            labelClass = (test_result.status) ? "label label-success" : "label label-important",
            labelText = (test_result.status) ? "Success" : "Failure",
            liClass = (active) ? "active" : "",
            friendlyUrl = friendlyTestUrl(scorecard, test),
            url;
        url = '#' + routie.lookup('test_result',
                            {project_id: showing.project_id,
                             scorecard_id: showing.scorecard_id,
                             test_instance_id: friendlyUrl,
                             test_result_id: test_result.id});
        return (<li className={liClass}>
                  <a href={url} className={liClass}>
                    <span className={labelClass}>{labelText}</span>
                    {timeAgoInWords(new Date(test_result.created_at))} [{test_result.long_version}]
                  </a>
                  <ArtifactList showing={showing} test_result={test_result}
                                friendlyUrl={friendlyUrl} active={active}/>
                </li>);
    }
});

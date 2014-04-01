/** @jsx React.DOM */
Loading = React.createClass({
    render: function(){
        var statusStyle = {
            right: "10px",
            left: "auto",
            top: "140px",
            display: (this.props.queue.length > 0) ? "block" : "none"
        };
        var queue = this.props.queue.map(function(req){
            return (<li key={req.id}> - {req.helpText} </li>);
        });
        return (
            <div className="popover bottom" style={statusStyle}>
              <div className="arrow" style={{left: "75%"}}/>
              <h3 className="popover-title">Hold yer horses!</h3>
              <div className="popover-content">
                <p>I've got <span className="text-info"> {queue.length} </span>
                more steers to herd.</p>
                <ul className="unstyled"> { queue } </ul>
              </div>
            </div>
        );
    }
});


$(document).ajaxSend(function(event, jqXHR, settings){
    GiddyUp.activeAjax.push(settings.context);
    GiddyUp.render();
});

$(document).ajaxComplete(function(event, jqXHR, settings){
    GiddyUp.activeAjax.splice(
            GiddyUp.activeAjax.indexOf(settings.context),
            1);
    GiddyUp.render();
});

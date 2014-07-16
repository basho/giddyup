/** @jsx React.DOM */
Loading = React.createClass({
    render: function(){
        var queue = this.props.queue,
            length = Object.keys(queue).length,
            statusStyle = {
                right: "10px",
                left: "auto",
                top: "140px",
                display: (length > 0) ? "block" : "none"
            },
            requests = Object.keys(queue).map(function(k){
                var req = queue[k];
                return (<li key={req.id}> - {req.helpText} </li>);
            });
        return (
            <div className="popover bottom" style={statusStyle}>
              <div className="arrow" style={{left: "75%"}}/>
              <h3 className="popover-title">Hold yer horses!</h3>
              <div className="popover-content">
                <p>I've got <span className="text-info"> {length} </span>
                more steers to herd.</p>
                <ul className="unstyled"> { requests } </ul>
              </div>
            </div>
        );
    }
});

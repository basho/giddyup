/** @jsx React.DOM */
GiddyUp.fetchMatrix = function(scorecard, cb) {
    if(cb === undefined || cb === null){
        cb = function(){};
    }
    if('tests' in scorecard){
        cb(scorecard);
    } else {
        console.log(["matrix", scorecard, cb]);
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "/scorecards/"+scorecard.id.toString()+"/matrix",
            context:{
                id: GiddyUp.nextGuid(),
                helpText: "Test matrix for '" + scorecard.project + ""
                    + " " + scorecard.name + "'"
            }}).done(function(result){
                scorecard.platforms = extractPlatforms(result['tests']);
                scorecard.tests = groupMatrix(result['tests'], scorecard.platforms);
                cb(scorecard);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments); });
    }
};


var extractPlatforms = function(tests){
    return tests.reduce(function(t, platforms){
        if (platforms.indexOf(t.platform) === -1)
            platforms.push(t.platform);
    }, []).sort();
};

var groupMatrix = function(tests, platforms) {
    return tests.reduce(function(t, matrix){
        if(!t.name in matrix){
            matrix[t.name] = platforms.reduce(function(p, row){ row[p] = []; });
        }
        matrix[t.name][t.platform].push(t);
    });
};

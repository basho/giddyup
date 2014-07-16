/*
 * Global Ajax Handlers
 */

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

/*
 * Utility functions for massaging received data
 */

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

var indexScorecards = function(scorecards){
    return scorecards.reduce(function(acc, s){ acc[s.id] = s; return acc;}, {});
};


var indexTests = function(tests){
    return tests.reduce(function(index, t){
        index[t.id] = t;
        return index;
    }, {});
};

var extractPlatforms = function(tests){
    return tests.reduce(function(platforms, t){
        if (platforms.indexOf(t.platform) === -1)
            platforms.push(t.platform);
        return platforms;
    }, []).sort();
};

var groupMatrix = function(tests, platforms) {
    return tests.reduce(function(matrix, t){
        if(!(t.name in matrix)){
            matrix[t.name] = {};
            platforms.forEach(function(p){
                matrix[t.name][p] = [];
            });
        };
        matrix[t.name][t.platform].push(t);
        return matrix;
    }, {});
};


/*
 * Fetchers
 */
GiddyUp.fetchProjects = function(cb){
  if(cb === undefined || cb === null){
      cb = function(){};
  }
  if(GiddyUp.projects.length > 0){
    cb(GiddyUp.projects);
  } else {
    $.ajax({
        dataType: "json",
        url: "/projects",
        context: {id: GiddyUp.nextGuid(), helpText: "Projects list"}
     }).done(function(result){
        var projects = result['projects'].sort(GiddyUp.sortBy('name'));
        GiddyUp.projects = projects;
        projects.forEach(function(p){
            GiddyUp.projectsById[p.name] = p;
        });
        cb(projects);
    });
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
            type: "GET",
            dataType: "json",
            url:"/projects/"+project.name+"/scorecards",
            context:{
                helpText: "Scorecards for '" +
                    project.name + "'",
                id: GiddyUp.nextGuid()
             }}).
            done(function(result){
                project.scorecardsById = indexScorecards(result['scorecards'])
                project.scorecards =
                    groupScorecards(result['scorecards']);
                cb(project.scorecards);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments); });
    }
};

GiddyUp.fetchMatrix = function(scorecard, cb) {
    if(cb === undefined || cb === null){
        cb = function(){};
    }
    if('tests' in scorecard){
        cb(scorecard);
    } else {
        $.ajax({
            type: "GET",
            dataType: "json",
            cache: false,
            url: "/scorecards/"+scorecard.id.toString()+"/matrix",
            context:{
                id: GiddyUp.nextGuid(),
                helpText: "Test matrix for '" + scorecard.project + ""
                    + " " + scorecard.name + "'"
            }}).done(function(result){
                scorecard.platforms = extractPlatforms(result['tests']);
                scorecard.tests = groupMatrix(result['tests'],
                                              scorecard.platforms);
                scorecard.testsById = indexTests(result['tests']);
                cb(scorecard);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments); });
    }
};

GiddyUp.fetchArtifacts = function(test_result, cb){
    if(cb === undefined || cb === null){
        cb = function(){};
    }
    if('artifacts' in test_result){
        cb(test_result.artifacts);
    } else {
        $.ajax({
            type: "GET",
            dataType: "json",
            url:"/test_results/"+test_result.id+"/artifacts",
            context:{
                helpText: "Artifacts for result " + test_result.id,
                id: GiddyUp.nextGuid()
             }}).
            done(function(result){
                test_result.artifacts =
                    result['artifacts'].sort(GiddyUp.sortBy('id'));
                test_result.artifactsById = {};
                test_result.artifacts.forEach(function(a){
                    test_result.artifactsById[a.id.toString()] = a;
                });
                cb(test_result.artifacts);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments); });
    }
};

GiddyUp.fetchArtifactContents = function(artifact, cb) {
    if(cb === undefined || cb === null){
        cb = function(){};
    }
    if('contents' in artifact){
        cb(artifact.contents);
    } else {
        $.ajax({
            type: "GET",
            cache: false,
            accepts: {"text": artifact.content_type},
            url:"/artifacts/"+artifact.id,
            dataType: "text",
            context:{
                helpText: "Contents of artifact " + artifact.id,
                id: GiddyUp.nextGuid()
             }}).
            done(function(result){
                artifact.contents = result;
                cb(result);
                GiddyUp.render();
            }).fail(function(){ console.log(arguments); });
    }
};

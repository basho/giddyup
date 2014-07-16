/*
 * Global Ajax Handlers
 */

var normalizeRequestURL = function(url){
    return url.split("?")[0];
};

var recordRequest = function(event, jqXHR, settings){
    var url = normalizeRequestURL(settings.url);
    GiddyUp.activeAjax[url] = settings.context;
    GiddyUp.render();
};

var removeRequest = function(event, jqXHR, settings){
    var url = normalizeRequestURL(settings.url);
    delete GiddyUp.activeAjax[url];
    GiddyUp.render();
};

$(document).ajaxSend(recordRequest);
$(document).ajaxComplete(removeRequest);
$(document).ajaxError(removeRequest);

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

var indexOnId = function(collection){
    return collection.reduce(function(acc, item){
        acc[item.id.toString()] = item;
        acc[item.id] = item;
        return acc;
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
        t.resultsById = indexOnId(t.test_results);
        matrix[t.name][t.platform].push(t);
        return matrix;
    }, {});
};


/*
 * Fetchers
 */
GiddyUp.fetchProjects = function(cb){
    GiddyUp.fetch({
        url: "/projects",
        predicate: (GiddyUp.projects.length > 0),
        shortcut: GiddyUp.projects,
        helpText: "Projects list",
        processor: function(result){
            var projects = result['projects'].sort(GiddyUp.sortBy('name'));
            GiddyUp.projects = projects;
            projects.forEach(function(p){
                GiddyUp.projectsById[p.name] = p;
            });
            return projects;
        }
    }, cb);
};

GiddyUp.fetchScorecards = function(project, cb){
    GiddyUp.fetch({
        url: "/projects/"+project.name+"/scorecards",
        predicate: ('scorecards' in project),
        shortcut: project.scorecards,
        helpText: "Scorecards for '" + project.name + "'",
        processor: function(result){
            project.scorecardsById = indexOnId(result['scorecards']);
            project.scorecards = groupScorecards(result['scorecards']);
            return project.scorecards;
        }
    }, cb);
};

GiddyUp.fetchMatrix = function(scorecard, cb) {
    GiddyUp.fetch({
        url: "/scorecards/"+scorecard.id.toString()+"/matrix",
        predicate: ('tests' in scorecard),
        shortcut: scorecard,
        helpText: "Test matrix for '" + scorecard.project + " " + scorecard.name + "'",
        processor: function(result){
            scorecard.platforms = extractPlatforms(result['tests']);
            scorecard.tests = groupMatrix(result['tests'],
                                          scorecard.platforms);
            scorecard.testsById = indexOnId(result['tests']);
            return scorecard;
        }
    }, cb);
};

GiddyUp.fetchArtifacts = function(test_result, cb){
    GiddyUp.fetch({
        url: "/test_results/"+test_result.id+"/artifacts",
        predicate: ('artifacts' in test_result),
        shortcut: test_result.artifacts,
        helpText: "Artifacts for result " + test_result.id,
        processor: function(result){
            test_result.artifacts = result['artifacts'].sort(GiddyUp.sortBy('id'));
            test_result.artifactsById = indexOnId(test_result.artifacts);
            return test_result.artifacts;
        }
    }, cb);
};

GiddyUp.fetchArtifactContents = function(artifact, cb) {
    GiddyUp.fetch({
        url: "/artifacts/"+artifact.id,
        predicate: ('contents' in artifact),
        shortcut: artifact.contents,
        helpText: "Contents of artifact " + artifact.id,
        processor: function(result){
            artifact.contents = result;
            return result;
        },
        ajax: {
            cache: false,
            accepts: {"text": artifact.content_type},
            dataType: "text"
        }
    }, cb);
};

GiddyUp.fetch = function(options, cb) {
    var url = options.url,
        predicate = options.predicate,
        shortcut = options.shortcut,
        helpText = options.helpText,
        processor = options.processor,
        ajaxOptions = options.ajax || {},
        callback = cb || $.noop,
        requestOptions = {
            type: "GET",
            dataType: "json",
            url: url,
            context: {
                id: GiddyUp.nextGuid(),
                helpText: helpText,
                callbacks: [callback]
            }
        },
        active = GiddyUp.activeAjax[url];

    if(predicate){
        callback(shortcut);
    } else if (active) {
        active.callbacks.push(callback);
    } else {
        var option;
        for(option in ajaxOptions){
            requestOptions[option] = ajaxOptions[option];
        }
        $.ajax(requestOptions).done(function(result){
            var param = processor(result);
            this.callbacks.forEach(function(deferred){ deferred(param); });
        }).fail(function(){ console.log(arguments) });
        GiddyUp.render(); // Render the loading box
    }
};

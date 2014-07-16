// For initial load
routie.navigateToHash = function(){
    var hash = window.location.hash.substring(1);
    if(hash === "" || hash === undefined)
        window.location.hash = "#/";
};

friendlyTestUrl = function(scorecard, test) {
    var parts = [scorecard.id, test.id, test.name, test.platform];
    if(test.backend){ parts.push(test.backend); }
    if(test.upgrade_version){ parts.push(test.upgrade_version); }
    return encodeURIComponent(parts.join('-'));
};

extractTestId = function(segment){
  segment = decodeURIComponent(segment);
  return segment.split('-')[1];
};

routie({
    'projects /': function(p){
        // Go to root
        GiddyUp.showing = {};
        GiddyUp.help = 'projects';
        GiddyUp.fetchProjects(GiddyUp.render);
    },
    'project /projects/:project_id': function(p){
        // Load scorecards, display scorecard nav
        GiddyUp.showing = {project_id: p};
        GiddyUp.help = 'project';
        GiddyUp.fetchProjects(function(){
            var project = GiddyUp.projectsById[p];
            GiddyUp.fetchScorecards(project, GiddyUp.render);
        });
    },
    'scorecard /projects/:project_id/scorecards/:scorecard_id': function(p,s){
        // Check if scorecard's matrix is loaded, if not render the
        // progress bar and start loading them. When it is loaded and
        // computed, render the matrix.
        GiddyUp.showing = {project_id: p, scorecard_id: s};
        GiddyUp.help = 'scorecard';
        GiddyUp.fetchProjects(function(){
            var project = GiddyUp.projectsById[p];
            GiddyUp.fetchScorecards(project, function(scorecards){
                GiddyUp.fetchMatrix(project.scorecardsById[s], GiddyUp.render);
            });
        });
    },
    'test_instance /projects/:project_id/scorecards/:scorecard_id/:test_instance_id': function(p,s,ti){
        // Replace the matrix view with the master/detail view of test
        // results
        GiddyUp.showing = {project_id: p, scorecard_id: s,
                           test_instance_id: extractTestId(ti)};
        GiddyUp.help = 'test_instance';
        GiddyUp.fetchProjects(function(){
            var project = GiddyUp.projectsById[p];
            GiddyUp.fetchScorecards(project, function(scorecards){
                GiddyUp.fetchMatrix(project.scorecardsById[s], GiddyUp.render);
            });
        });
    },
    'test_result /projects/:project_id/scorecards/:scorecard_id/:test_instance_id/:test_result_id': function(p,s,ti,tr){
        // Load the artifacts for the test result and display them in
        // the list
        ti = extractTestId(ti);
        GiddyUp.showing = {project_id: p, scorecard_id: s,
                           test_instance_id: ti,
                           test_result_id: tr};
        GiddyUp.help = 'test_result';
        GiddyUp.fetchProjects(function(){
            var project = GiddyUp.projectsById[p];
            GiddyUp.fetchScorecards(project, function(scorecards){
                GiddyUp.fetchMatrix(project.scorecardsById[s], function(scorecard){
                    GiddyUp.fetchArtifacts(scorecard.testsById[ti].resultsById[tr], GiddyUp.render);
                });
            });
        });
    },
    'artifact /projects/:project_id/scorecards/:scorecard_id/:test_instance_id/:test_result_id/artifacts/:artifact_id': function(p,s,ti,tr,a){
        // Load the artifact body
        ti = extractTestId(ti);
        GiddyUp.showing = {project_id: p, scorecard_id: s,
                           test_instance_id: ti,
                           test_result_id: tr,
                           artifact_id: a};
        GiddyUp.help = 'artifact';
        GiddyUp.fetchProjects(function(){
            var project = GiddyUp.projectsById[p];
            GiddyUp.fetchScorecards(project, function(scorecards){
                GiddyUp.fetchMatrix(project.scorecardsById[s], function(scorecard){
                    GiddyUp.fetchArtifacts(scorecard.testsById[ti].resultsById[tr],function(artifacts){
                        GiddyUp.fetchArtifactContents(scorecard.testsById[ti].resultsById[tr].artifactsById[a], 
                                                      GiddyUp.render);
                    });
                });
            });
        });
        GiddyUp.render();
    }
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require cocoon
//= require bootstrap-sprockets
//= require js-routes
//= require_tree .
//= require turbolinks

window.loadedActivities = [];


var addActivity = function(item) {
	var found = false;
	for (var i = 0; i < window.loadedActivities.length; i++) {
		if (window.loadedActivities[i].id == item.id) {
			var found = true;
		}
	}

	if (!found) {
		window.loadedActivities.push(item);
		window.loadedActivities.sort(function(a, b) {
      var returnValue;
      if (a.created_at > b.created_at)
        returnValue = -1;
      if (b.created_at > a.created_at)
        returnValue = 1;
      if (a.created_at == b.created_at)
        returnValue = 0;
      return returnValue;
    });

	}


	return item;
}


var renderActivities = function() {
  var source = $('#activities-template').html();
  var template = Handlebars.compile(source);
  var html = template({
    count: window.loadedActivities.length
  });
  var $activityFeedLink = $('li#activity-feed');  
  $activityFeedLink.html(html);
  window.loadedActivities = [];
}

Handlebars.registerHelper('ifCond', function(v1, options) {
  if(v1 === 0) {
    return options.fn(this);
  }
  return options.inverse(this);
});

var pollActivity = function() {

	
if (typeof currentUserId === 'undefined') {

}
else {
		$.ajax({
			url: Routes.activities_path({format: 'json', current_user_id_for_since: currentUserId}),
			type: "GET",
			dataType: "json",
			success: function(data) {
				console.log(data);
				window.lastFetch = Math.floor((new Date).getTime() / 1000);
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						addActivity(data[i]);
					}
				}
				renderActivities();
			}
		})
	}
}

window.pollInterval = window.setInterval( pollActivity, 1000 );
pollActivity();

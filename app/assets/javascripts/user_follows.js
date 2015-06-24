$(document).ready(function() {

	$('#add-follow').click(function(event) {
		event.preventDefault();
		var addFollowBtn = $(this);
		$.ajax({
			url: Routes.user_follows_path({user_follow: { followed_user_id:addFollowBtn.data('userFollowedId')}}),
			dataType: 'json',
			type: 'POST',
			success: function(e) {
				addFollowBtn.hide();
				$('#follow-status').html("<h2>You are now following this user!</h2>");
			}
		})
	});

});
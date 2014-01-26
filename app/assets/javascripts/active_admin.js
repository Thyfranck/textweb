//= require active_admin/base

$(document).ready(function(){
    $('#add-course-btn, #course_cancel_action').click(function(){
        $("form#new_course").toggle();
        return false;
    });
})
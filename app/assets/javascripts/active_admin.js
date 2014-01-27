//= require active_admin/base

$(document).ready(function(){
    $('#add-course-btn, #course_cancel_action').click(function(){
        $("form#new_course").toggle();
        return false;
    });

    $("form#new_course").submit(function(){
        var $name = $("input#course_name");
        if($name.val().length < 1) {
            $name.parent("li").addClass("error");
            $name.siblings("p.inline-errors").remove();
            $name.after("<p class=\"inline-errors\">can't be blank</p>");
            return false;
        }
        return true;
    });

    $("a.ex-course").click(function(){
        var html = $(this).html();
        if(html == "+") $(this).html("&minus;");
        else $(this).html("+");
        
        $(this).parent("span").siblings("ul").toggle();
    });


    $("#add-topic-btn, #topic_cancel_action").click(function(){
        $("form#new_topic").toggle();
        return false;
    });
    
    $("form#new_topic").submit(function(){
        var $name = $("input#topic_name");
        $name.parent("li").removeClass("error");
        $name.siblings("p.inline-errors").remove();
        
        if($name.val().length < 1) {
            $name.parent("li").addClass("error");
            $name.after("<p class=\"inline-errors\">can't be blank</p>");
        }

        var url = "/admin/schools/1/courses/cse-103/topics"
        $.ajax({
            type: 'POST',
            url: url,
            data: $(this).serialize(),
            dataType: "script"
        });

        return false;
    });

})
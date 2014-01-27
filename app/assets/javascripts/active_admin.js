//= require active_admin/base

$(document).ready(function(){
    $("form#new_course").on('submit', function(){
        var $name = $("input#course_name");
        if($name.val().length < 1) {
            $name.parent("li").addClass("error");
            $name.siblings("p.inline-errors").remove();
            $name.after("<p class=\"inline-errors\">can't be blank</p>");
            return false;
        }
        return true;
    });
});

$(document).on("click", "a.toggle-list", function(){
    var html = $(this).html();
    if(html == "+") $(this).html("&minus;");
    else $(this).html("+");
    var $list = $(this).parent("span").siblings("ul");
    $list.toggle();
});

$(document).on("click", ".expan-form", function(){
    var $form = $(this).parent('span').siblings('form');
    $form.toggle();
    return false;
});

$(document).on("click", ".close-form", function(){
    var $form = $(this).parent('li').parent('ol').parent('fieldset').parent('form');
    $form.toggle();
    return false;
});

$(document).on("submit", "form.topic, form.section", function(){
    var $form = $(this);
    var form_id = $form.attr("id");
    var $name = $("#"+form_id+" input.name-field");

    $name.parent("li").removeClass("error");
    $name.siblings("p.inline-errors").remove();

    if($name.val().length < 1) {
        $name.parent("li").addClass("error");
        $name.after("<p class=\"inline-errors\">can't be blank</p>");
    }

    $.ajax({
        type: 'POST',
        url: $form.attr("action"),
        data: $form.serialize(),
        dataType: "script"
    });

    return false;
});
$(document).ready(function(){

    $("a.fancybox").fancybox();

    $('.show_replies').click(function(){
        $(this).next('div.replies').show();
        $(this).hide();
    })

    $('.cancel_reply').click(function(){
        $(this).closest('div[class^="reply_form"]').hide();
    })

    $('.reply').click(function(){
        $(this).closest('div[class^="row-fluid"]').next('div[class^="row-fluid"]').find('div.reply_form').toggle();
    })

    $(".toggle-link").click(function(){
        var icon_class = "";
        if($(this).has('i')){
            icon_class = $(this).children('i').attr('class');
        }
        if(icon_class=="icon-plus-sign"){
            $(this).children('i').removeClass("icon-plus-sign");
            $(this).children('i').addClass("icon-minus-sign");
        }
        if(icon_class=="icon-minus-sign"){
            $(this).children('i').removeClass("icon-minus-sign");
            $(this).children('i').addClass("icon-plus-sign");
        }
    });


    $("#open-submit-link").click(function(){
        $('#new_link').slideToggle('slow');
    });

    $("#close-submit-link").click(function(){
        $('#new_link').hide('slow');
        return false;
    });

    $('.toggle-form').submit(function() {
        $('.toggle-form').slideToggle('slow');
    });

    $('.course-show-container').css('min-height', $(window).height() + 'px');

    $('.ajax-submit-loader').click(function(){
        $('#spinner').removeClass('hidden');
    });


    $('#school_select').change(function(){
        $(this).closest("form").submit();
    });
});

$(document).ready(function(){
    var field_width = $(".email-input-append .text_field").width();
    var add_on_width = $(".email-input-append .add-on").width();
    $(".email-input-append .text_field").css("width", (field_width - add_on_width - 11));
});

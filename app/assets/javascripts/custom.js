$(document).ready(function(){

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

    $('.ajax-submit-loader').click(function(){
        $('#spinner').removeClass('hidden');
    });


    $('#school_select').change(function(){
        $(this).closest("form").submit();
    });

    $('.arrow-up').click(function(){
        var link_id = $(this).attr('id')
        $.ajax({
            type: 'POST',
            url: '/vote',
            data: {
                rate : 'up',
                id : link_id
            },
            dataType: "script"
        });
    })

    $('.arrow-down').click(function(){
        var link_id = $(this).attr('id')
        $.ajax({
            type: 'POST',
            url: '/vote',
            data: {
                rate : 'down',
                id : link_id
            },
            dataType: "script"
        });
    })

//    $('.link_section').mouseover(function(){
//        $(this).addClass('active');
//    })
//
//    $('.link_section').mouseout(function(){
//        $(this).removeClass('active');
//    })
});

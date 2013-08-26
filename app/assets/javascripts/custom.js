$(document).ready(function(){

    $(".toggle-link").click(function(){
        var icon_class = "";
        if($(this).has('i')){
            icon_class = $(this).children('i').attr('class');
        }
        if(icon_class=="icon-plus"){
            $(this).children('i').removeClass("icon-plus");
            $(this).children('i').addClass("icon-minus");
        }
        if(icon_class=="icon-minus"){
            $(this).children('i').removeClass("icon-minus");
            $(this).children('i').addClass("icon-plus");
        }
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
});

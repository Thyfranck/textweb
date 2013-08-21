$(document).ready(function(){
    $('#school_select').change(function(){
        $(this).closest("form").submit();
    });

    $('.arrow-up').click(function(){
        var link_id = $(this).attr('id')
        $.ajax({
            type: 'POST',
            url: '/rate',
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
            url: '/rate',
            data: {
                rate : 'down',
                id : link_id
            },
            dataType: "script"
        });
    })
});

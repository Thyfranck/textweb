$(document).ready(function(){
    $('#school_select').change(function(){
        $(this).closest("form").submit();
    });
});

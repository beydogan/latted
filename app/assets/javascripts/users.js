$(function() {
    $( ".tabs > li > a" ).click(function(e){
        var target = $(this).data("tab");
        $("#user-tabs > div:visible").fadeOut({
            duration: 500,
            complete: function(){
                $("#user-tabs ." + target).fadeIn("slow");
            }
        });
        $(".tab-title").html($(this).data("title"));
    });

    $(".user-item").hover(
        function(){
            $(this).find(">div").not(".item-more").animate({
                opacity: 0.25
            }, 400);
            $(this).find(".item-more").fadeIn("slow");
        },
        function(){
            $(this).find(">div").not(".item-more").animate({
                opacity: 1
            }, 200);
            $(this).find(".item-more").fadeOut();
        }
    )
});
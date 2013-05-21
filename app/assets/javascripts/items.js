// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $(".item-actioned-stats a").click(function(){
        var action = $(this).data('action');
        var id = $(this).data('item-id');
        var path = "/items/" + id + "/who/" + action;
        $(".modal-body").load(path);
    })
})
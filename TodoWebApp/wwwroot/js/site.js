$(document).ready(function () {
    $("body").on("click", "a[data-mode]", function () {
        var buton = $(this);
        var mode = $(buton).data("mode");
        var todoId = $(buton).data("data1");

        if (mode === "TodoCreate") {
            var form = $("#todoForm").serialize();
            $.ajax({
                type: "POST",
                url: "Home/TodoCreate",
                data: form,
                success: function (result) {
                    location.reload();
                }
            })
        }
        else if (mode === "TodoAdd") {
            $("#modalTodoDetails").modal("show");
            var url = 'Home/TodoRead/';
            $(".modal-content").load(url);
        }
        else if (mode === "TodoRead") {
            $("#modalTodoDetails").modal("show");
            var url = 'Home/TodoRead/' + todoId;
            $(".modal-content").load(url);
        }
        else if (mode == "TodoUpdate") {
            var form = $("#todoForm").serialize();
            $.ajax({
                type: "PUT",
                url: "Home/TodoUpdate/",
                data: form,
                success: function (result) {
                    location.reload();
                }
            })
        }
        else if (mode === "TodoDelete") {
            $.ajax({
                type: "DELETE",
                url: "Home/TodoDelete/" + todoId,
                success: function (result) {
                    $("#trTodo_" + todoId).remove();
                }
            })
        }
    });
});
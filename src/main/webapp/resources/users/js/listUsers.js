// 유저 삭제 버튼
$('.deleteBtn').on('click', function(){
    var username = $(this).closest('tr').find('a[id^="listUsername"]').text();
    $('#deleteUser').modal('show');

    $('#deleteUserBtn').on('click', function(){
        $.ajax({
            type : "POST",
            url : "/deleteUser",
            data : { username : username},
            beforeSend: function (jqXHR, settings) {
                var header = $("meta[name='_csrf_header']").attr("content");
                var token = $("meta[name='_csrf']").attr("content");
                jqXHR.setRequestHeader(header, token);
            },
            success : function(result) {
                location.replace(result)

            },
            error : function(request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    })
})
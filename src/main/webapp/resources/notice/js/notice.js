/* 게시물 삭제 */
function removeNotice(nno) {
    $.ajax({
        type : "POST",
        url : "/notice/removeNotice",
        data : {
            nno : nno
        },
        beforeSend: function (jqXHR, settings) {
            var header = $("meta[name='_csrf_header']").attr("content");
            var token = $("meta[name='_csrf']").attr("content");
            jqXHR.setRequestHeader(header, token);
        },
        success : function(result) {
            alert("공지가 삭제되었습니다.")
            window.location.href = '/notice/list';
        },
        error : function(request, status, error) {
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    })
    window.location.href = '/notice/list';
}
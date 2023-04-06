//findId 제출 시 처리
$('#findIdBtn').on('click', function(){
    var name = $('#name').val();
    var tel = $('#tel').val();
    $.ajax({
        type : "POST",
        url : "/findId",
        data : { name : name,
                tel : tel },
        datatype : { String },
        beforeSend: function (jqXHR, settings) {
            var header = $("meta[name='_csrf_header']").attr("content");
            var token = $("meta[name='_csrf']").attr("content");
            jqXHR.setRequestHeader(header, token);
        },
        success : function(result) {
            $("#modalContent").html(result);
            $('#findIdModal').modal('show');
        },
        error : function(request, status, error) {
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
});


//findPw 제출 시 처리 (modal 생성 후 띄우기)
$('#findPwBtn').on('click', function(){
    var username = $('#username').val();
    var name = $('#name').val();
    var tel = $('#tel').val();

    $.ajax({
        type : "POST",
        url : "/findPw",
        data : { name : name,
                tel : tel,
                username : username},
        datatype : { String },
        beforeSend: function (jqXHR, settings) {
            var header = $("meta[name='_csrf_header']").attr("content");
            var token = $("meta[name='_csrf']").attr("content");
            jqXHR.setRequestHeader(header, token);
        }, //spring security 로 인한 csrf token 전송
        success : function(result) {
            if (result != null && result != ""){
                $("#modalContent").html("<form id=\"pwUpdateForm\">\n" +
                                            "<div>새로 사용할 비밀번호를 입력해주세요.</div>" +
                                            "<input name=\"password\" type=\"password\" id=\"password\" placeholder=\"비밀번호\"><br>" +
                                            "<input name=\"ChkPassword\" type=\"password\" id=\"ChkPassword\" placeholder=\"비밀번호 확인\">" +
                                            "<input type=\"hidden\" name=\"${_csrf.parameterName}\" value=\"${_csrf.token}\" />\n" +
                                        "</form>");
                $("#modalBtn").html("<button type=\"button\" class=\"btn btn-secondary\" id=\"updatePwBtn\">비밀번호 변경</button>\n" +
                                    "<button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">닫기</button>");
            } else {
                $("#modalContent").html("<p>잘못된 정보를 입력하였습니다.<br>다시 입력해주세요.</p>");
                $("#modalBtn").html("<button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">닫기</button>");
            }
            $('#findPwModal').modal('show');

            $('#updatePwBtn').on('click', function(){
                var password = $('#password').val();
                var ChkPassword = $('#ChkPassword').val();
                $.ajax({
                    type : "POST",
                    url : "/updatePw",
                    data : { username : username,
                            password : password,
                            Chkpassword : ChkPassword },
                    datatype : { String },
                    beforeSend: function (jqXHR, settings) {
                        var header = $("meta[name='_csrf_header']").attr("content");
                        var token = $("meta[name='_csrf']").attr("content");
                        jqXHR.setRequestHeader(header, token);
                    },
                    success : function(result) {
                        if (password == ChkPassword) {
                            location.replace("/login")
                        } else {
                            $("#modalContent").html("<form id=\"pwUpdateForm\">\n" +
                                                        "<div>새로 사용할 비밀번호를 입력해주세요.</div>" +
                                                        "<input name=\"password\" type=\"password\" id=\"password\" placeholder=\"비밀번호\"><br>" +
                                                        "<input name=\"ChkPassword\" type=\"password\" id=\"ChkPassword\" placeholder=\"비밀번호 확인\">" +
                                                        "<input type=\"hidden\" name=\"${_csrf.parameterName}\" value=\"${_csrf.token}\" />\n" +
                                                        "<div style='color:red;'>비밀번호가 일치하지 않습니다. 다시 입력해주세요. </div>" +
                                                    "</form>");
                        }
                    },
                    error : function(request, status, error) {
                        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }
                });
            });
        },
        error : function(request, status, error) {
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
});
/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

var emailChk = true; //이메일 유효여부
var telChk = true; //전화번호 유효여부

//이메일 유효성 확인 함수
function emailValidator(args) {
    if(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/.test(args)) {
        return true;
    } //입력값이 숫자or영문@숫자or영문.숫자or영문 이면 true 반환

    return false;
}

//전화번호 유효성 확인 함수
function telValidator(args) {
    if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(args)) {
        return true;
    } //입력값이 숫자(2,3글자)-숫자(3,4글자)-숫자(4글자) 면 true 반환

    return false;
}

//이메일 입력 후 다른 곳 클릭시 이벤트 실행
$('#email').on("focusout", function(e){
    var email = $(this).val(); //이메일 입력값 가져오기
    var validate = emailValidator(email); //validate에 전화번호가 유효한 값이면 true를 아니면 false를 저장한다.
    if(validate || email == '') {
        //유효한 값이거나 이메일이 공란이면 초록색 글씨로 메시지를 출력해준다.
        $('#validEmail').html("<div style='color:green;'>사용가능한 이메일입니다.</div>");
        emailChk = true;
    } else{
        //유효하지 않은 값이면 메시지를 출력해준다.
        $('#validEmail').html("잘못된 이메일입니다.");
        emailChk = false;
    }
});

//전화번호 입력 후 다른 곳 클릭시 이벤트 실행
$('#tel').on("focusout", function(e) {
    var username = $('#username').val();
    var tel = $(this).val();
    $.ajax({
        type : "GET",
        url : "/TelChk",
        data : { tel : tel,
                username : username },
        success : function(result) {
            if(result && telValidator(tel)) { //중복 아이디가 없고, id가 유효값이 라면
                $('#validTel').html("<div style='color:green;'>사용가능한 전화번호입니다.</div>");
                telChk = true;
            } else if(!telValidator(tel)) { //tel이 유효값이 아니라면
                $('#validTel').html("잘못된 전화번호입니다.<br>010-000-0000의 형식으로 입력해주세요");
                telChk = false;
            } else { //중복 전화번호가 존재한다면
                $('#validTel').html("중복된 전화번호입니다..<br> 다른 전화번호를 입력해주세요.");
                telChk = false;
            }
        }, error : function(request, status, error) {
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
});

//정보 수정 폼 작성 후 제출 시 실행되는 함수
$('.submit').on('click', function(e) {
    if(!emailChk) { //이메일 오류 모달
        $('#modalTitle').html('이메일 사용 불가');
        $('#modalContent').html('<p>올바른 이메일 주소를 입력해주세요.</p>');
        $('#errorModal').modal('show');
    } else if(!telChk) { //전화번호 오류 모달
        $('#modalTitle').html('전화번호 사용 불가');
        $('#modalContent').html('<p>올바른 전화번호를 입력해주세요.<br>전화번호는 000-000-0000 형식으로 작성해야합니다.</p>');
        $('#errorModal').modal('show');
    } else { //유효성이 통과하면 제출
        $('#submitForm').submit();
    }
})
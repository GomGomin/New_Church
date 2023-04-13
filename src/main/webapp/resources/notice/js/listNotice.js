/* 검색 */
document.getElementById("searchBtn").onclick = function () {
    let searchType = document.getElementsByName("searchType")[0].value;
    let keyword =  document.getElementsByName("keyword")[0].value;

    location.href = "/notice/list?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
};

/* window 특정 크기 이하일때(모바일) title 줄여서 뿌리기 */
window.onload = function() {
    if ($(window).width() < 770) {
        for(var i = 0; i < 10; i++){
            if(document.getElementsByClassName("listTitle")[i].innerText.length>5){
                var title = document.getElementsByClassName("listTitle")[i].innerText.slice(0,3);
                document.getElementsByClassName("listTitle")[i].innerText= title + '...';
            }
        }
    }
}
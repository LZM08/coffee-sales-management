function  reset(){
    document.input.pcode.value="";
    document.input.saledate.value="";
    document.input.scode.value="";
    document.input.amount.value="";
    return true;
}

function insertCheck() {
    if (document.frm_insert.pcode.value == "") {
        alert("상품코드가 입력되지 않았습니다.");
        frm_inset.pcode.focus();
        return false;
    }
    ;

    if (document.frm_insert.saledate.value == "") {
        alert("판매날짜가 입력되지 않았습니다.");
        frm_inset.saledate.focus();
        return false;
    }
    ;

    if (document.frm_insert.amount.value == "") {
        alert("판매수량이 입력되지 않았습니다.");
        frm_inset.amount.focus();
        return false;
    };
    success();
    return true;
}

function success() {
    alert("판매등록이 완료 되었습니다.");
}


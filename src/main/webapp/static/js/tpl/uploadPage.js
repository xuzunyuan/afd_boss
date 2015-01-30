$(function() {
    $('#submitBtn').click(function () {
        if('' === $('#uploadFile').val()) {
            alert('请选择上传文件！');
            return;
        }
        myToggle();
    });
    $('#cancelBtn').click(function () {
        myToggle();
    });
    $('#uploadBtn').click(function () {
        $('#myForm').submit();
    });
});

function myToggle() {
    $('.mask-bg').toggle();
    $('.mask-show').toggle();
}
$(function () {
    $('#alipay').click(function () {
        // 发起支付请求
        request_data = {
            'orderid': $(this).attr('data-orderid')
        }
        console.log('a')
        $.get('/pay/', request_data, function (response) {
            console.log(response)
            if (response.status == 1){
                window.open(response.alipayurl, target='_self')
            }
        })
    })
})
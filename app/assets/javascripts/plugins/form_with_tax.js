(function( $ ){

    function initialize(el) {
        $(el).find('.calc-net').on('click', calcNet);
        $(el).find('.calc-gross').on('click', calcGross);
    }
    
    function calcGross() {
        var net = document.getElementById('amount_net').value;
        var tax = document.getElementById('tax').value;
        if (net == '' || tax == '') return;
        var taxFactor = 100 + parseInt(tax)
        var gross = Math.round(net * taxFactor / 100);
        document.getElementById('amount_gross').value = gross;
        displayTax();
    }

    function calcNet() {
        var gross = document.getElementById('amount_gross').value;
        tax = document.getElementById('tax').value;
        if (gross == '' || tax == '') return;
        taxFactor = 100 + parseInt(tax);
        net = Math.round((gross / taxFactor) * 100);
        document.getElementById('amount_net').value = net;
        displayTax();
    }

    function setTax(categoryId) {
        tax = category_taxes[categoryId];
        document.getElementById('tax').value = tax;
    }

    function displayTax() {
        net = document.getElementById('amount_net').value;
        gross = document.getElementById('amount_gross').value;
        if (gross == '' || net == '') return;
        tax = gross - net;
        document.getElementById('tax_display').innerHTML = tax + " Cent USt";
    }
    
    $.fn.formWithTax = function() { 
        initialize(this);
    };
    
})( jQuery );
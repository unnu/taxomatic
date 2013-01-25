var Initializers = {};

/** check if there is a global initializer function for the current page and run it.
 * if there isn't, run globalInit() instead.
 */
$(document).ready(function() {
    var pageInitializer = $('body').data('initializer');
    if (typeof Initializers[pageInitializer] == 'function') {
        Initializers[pageInitializer]($);
    } else {
        Initializers.Default($);
    }
})

function calcGross(net) {
    tax = document.getElementById('tax').value
    if (net == '' || tax == '') return;
    taxFactor = 100 + parseInt(tax)
    gross = Math.round(net * taxFactor / 100);
    document.getElementById('amount_gross').value = gross;
    displayTax();
}

function calcNet(gross) {
    tax = document.getElementById('tax').value
    if (gross == '' || tax == '') return;
    taxFactor = 100 + parseInt(tax)
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
    document.getElementById('tax_display').innerHTML = tax;
}
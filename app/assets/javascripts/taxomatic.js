jQuery(document).ready(function() {    

    var pageInitializer = jQuery('body').data('initializer');
    funcName = "init" + pageInitializer;    
    if (typeof funcName == 'string' && eval('typeof ' + funcName) == 'function') {
        eval(funcName + '(jQuery)');
    } else {
        globalInit();
    }
    
})

function globalInit() {
    if (document.getElementById('itemslist')) {
        initHighlightRows(document.getElementById('itemslist'));
    }
    focusForm();
}

function focusForm() {  
    if (document.forms[0]) {
        document.forms[0].elements[0].focus();
    }
}

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

function initHighlightRows(el) {
    trs = el.getElementsByTagName('tr');
    for (i=0; i<trs.length; i++) {
        if (trs[i].className != 'nohl') {
            addEvent(trs[i], 'mouseover', highlightRow);
            addEvent(trs[i], 'mouseout', highlightRow);
        }
    }
}

function highlightRow(e) {
    // aus dem event browserunabh. eine referenz auf die tr holen
    e = (e) ? e : ((window.event) ? window.event : '');
    eTarget = e.srcElement ? e.srcElement : e.target;

    // sometimes i get no element reference from ie.
    if (!eTarget) return;

    eTarget = getFirstAncestor(eTarget, 'TR');

    switch (e.type) {
        case 'mouseover':
        color = '#e5e5e5';
        isHighlighted = true;
        break;
        case 'mouseout':
        color = '';
        isHighlighted = false;
        break;
    }

    if (colNames == false) {
        var colNames = new Array();
        ths = document.getElementById('productTableHeader').getElementsByTagName('TH');
        printfire(ths[10].firstChild.nodeValue);
        for (i=0;i<ths.length;i++) {
            colNames[i] = true
        }
        printfire(colNames);
    }

    // highlight der zeile
    tds = eTarget.getElementsByTagName('td');
    for (i=0; i<tds.length; i++) {
        tds[i].style.backgroundColor = color;
    }
    // merken ob zeile gehighlighted oder nicht
    eTarget.setAttribute('highlighted', (isHighlighted ? 'false' : 'true'));
}
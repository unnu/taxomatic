function initTaxUst($) {

    initHighlightRows(document.getElementById('itemslist'));

    Slides = new TabCtrl('tabContainer');

    $(document).on('click', '#show-date', function() {
        var month = jQuery('#ust-date-select select#date_month').val();
        var year = jQuery('#ust-date-select select#date_year').val();
        window.location = "/tax/ust/" + year + "/" + month;
    });

}
function initTaxUst($) {

    Slides = new TabCtrl('tabContainer');

    $(document).on('change', '#ust-date-select select', function() {
        var month = jQuery('#ust-date-select select#date_month').val();
        var year = jQuery('#ust-date-select select#date_year').val();
        if (month && year) {
            window.location = "/tax/ust/" + year + "/" + month;            
        }
    });

}
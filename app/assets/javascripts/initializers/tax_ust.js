Initializers.TaxUst = function($) {

    $('#tabContainer').tabs();

    $(document).on('change', '#ust-date-select select', function() {
        var month = $('#ust-date-select select#date_month').val();
        var year = $('#ust-date-select select#date_year').val();
        if (month && year) {
            window.location = "/tax/ust/" + year + "/" + month;            
        }
    });

}
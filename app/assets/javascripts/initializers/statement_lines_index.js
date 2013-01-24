function initStatementLinesIndex($) {

    initHighlightRows(document.getElementById('itemslist'));

    $(".expense_toggler")

        .on('click', function(event) {
            $(this).attr('disabled', true);
            event.preventDefault();
        })
        
        .on('ajax:success', function() {  
            var checkbox = $(this);
            checkbox.attr('disabled', false);
            checkbox.prop('checked', !checkbox.is(':checked'));
        })
        
        .on('ajax:error', function() {  
            var checkbox = $(this);
            checkbox.attr('disabled', false);
        });

}
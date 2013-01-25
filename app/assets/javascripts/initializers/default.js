//
// this is run for all pages that don't have a page-specific initializer
//
Initializers.Default = function($) {
    $('form[data-with-tax]').formWithTax();
}
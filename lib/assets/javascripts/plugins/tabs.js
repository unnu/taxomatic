(function( $ ) {

    $.fn.tabs = function() {

        var Slides = {
            
            initialize: function(tabContainerId) {
                this.currentSlide = 0;
                this.slides = [];

                var tmp = document.getElementById(tabContainerId).childNodes;
                for (var i=0, max=tmp.length; i<max; i++) {
                    if (tmp[i].nodeType == 1)  {
                        this.slides[this.slides.length] = tmp[i];
                    }
                }
                this.lastSlideNr = this.slides.length - 1;
                this.first();

                self = this;
                $(document).on('click', '#tabSelector a', function() {
                    // register tab switching
                    self.show($(this).data('tab-id'));
                    // highlight links
                    $('#tabSelector a').removeClass('selected');
                    $(this).addClass('selected');
                });
            },

            show: function(nr) {
                if (nr >= this.slides.length) {
                    return;
                }
                this.currentSlide = nr;
                for (var i=0, max=this.slides.length; i<max; i++) {
                    this.slides[i].style.display = (i == nr) ? 'block' : 'none';
                }
            },

            first: function() {
                this.show(0);
            },

            last: function() {
                this.show(this.lastSlideNr);
            },

            next: function() {
                if (this.currentSlide == this.lastSlideNr) {
                    newSlide = 0;
                } else {
                    newSlide = this.currentSlide + 1;
                }
                this.show(newSlide);
            },

            prev: function() {
                if (this.currentSlide == 0) {
                    newSlide = this.lastSlideNr;
                } else {
                    newSlide = this.currentSlide - 1;
                }
                this.show(newSlide);
            }
        };

        Slides.initialize($(this).attr('id'));
    };
    })( jQuery );
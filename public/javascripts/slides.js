var TabCtrl = Class.create();
TabCtrl.prototype = {

  initialize: function(tabContainerId)
  {
    this.currentSlide = 0;
    this.slides = new Array();
    
    var tmp = document.getElementById(tabContainerId).childNodes;
    for (var i=0, max=tmp.length; i<max; i++) {
      //if (tmp[i].className == 'slide')  {
      // ELEMENT_NODE )= 1 
      if (tmp[i].nodeType == 1)  {
        this.slides[this.slides.length] = tmp[i];
      }
    }
    this.lastSlideNr = this.slides.length - 1;
    // show first slide
    this.first();
  },

  // shows a tab by giving its number, starting from 0
  show: function(nr)
  {
    if (nr >= this.slides.length) {
      return;
    }
    this.currentSlide = nr;
    //window.status = nr
    for (var i=0, max=this.slides.length; i<max; i++) {
      this.slides[i].style.display = (i == nr) ? 'block' : 'none';
    }
  },

  first: function()
  {
    this.show(0);
  },

  last: function()
  {
    this.show(this.lastSlideNr);
  },

  next: function()
  {
    if (this.currentSlide == this.lastSlideNr) {
      newSlide = 0;
    } else {
      newSlide = this.currentSlide + 1;
    }
    this.show(newSlide);
  },

  prev: function()
  {
    if (this.currentSlide == 0) {
      newSlide = this.lastSlideNr;
    } else {
      newSlide = this.currentSlide - 1;
    }
    this.show(newSlide);
  },
}
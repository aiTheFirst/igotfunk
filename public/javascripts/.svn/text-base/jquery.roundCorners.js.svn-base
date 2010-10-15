/**
*
* jquery.roundCorners.js
*
* Inspired by:
*   v1.0 jquery.corners.js
*   Contact: Christian Haack Arnaboldi (ragamo@gmail.com)
*   http://ragamo.medioclick.com
*
* v1.1
* Contact: Douglas J Meyer (DouglasYMan@Yahoo.com)
* http://dougmeyer.nfshost.com/
*
*
* License: GPL
*
* Copyright (c) 2008, Christian Haack Arnaboldi
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright notice,
*       this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright notice,
*       this list of conditions and the following disclaimer in the documentation
*       and/or other materials provided with the distribution.
*     * Neither the name of Splunk Inc nor the names of its contributors may
*       be used to endorse or promote products derived from this software without
*       specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
* SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
* OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
* Usage:
*  $(selector).roundCorners([options])
*
* Supported options:
*   radio - (int) radius size of corners
*   inColor - (color) inside color of element
*   outColor - (color) outside color of corners
*
*   Examples:
*   $('#example_1').roundCorners();
*   $('#example_2').roundCorners({ inColor: '#8FC7FF' });
*   $('#example_3').roundCorners({ inColor: '#FEFF8F', outColor: '#000' });
*   $('#example_4').roundCorners({ radio: 30 });
*   $('#example_5').roundCorners({ radio: 40, inColor: '#FFCC66', outColor: '#D2FBAE' });
*/



(function($) {
  $.fn.roundCorners = function(options) {

    var options = $.extend({
      radio: 10,
      outColor: '#FFF',
      inColor: '#FFF',
      borderSize: 1,
      borderColor: '#000'
    }, options || {});

    if(options.borderSize > options.radio) {
      options.radio = options.borderSize;
    }

    return this.each(function() {
      var $this = $(this),
        children = $this.children();
      if($this.attr('data-rounded')){
        return;
      }
      $this.attr('data-rounded', 'true');

      if($this.css('backgroundColor')!='transparent') {
        options.inColor = $this.css('backgroundColor');
      }

      if(options.borderSize == 0) {
        options.borderColor = $this.css('border-left-color') ||
                              $this.css('border-top-color') ||
                              $this.css('border-bottom-color') ||
                              $this.css('border-right-color');
        if(($this.css('borderWidth')!='medium') || ($this.css('borderWidth')!='')) {
          options.borderSize = ($this.outerWidth()-$this.innerWidth())/2 ||
                               ($this.outerHeight()-$this.innerHeight())/2;
        }
      }

      $this
        .css({
          position: 'relative',
          backgroundColor: options.inColor,
          borderStyle: 'solid',
          borderWidth: options.borderSize+'px',
          borderColor: options.borderColor
        })
        .empty()
        .append('<canvas width='+ options.radio +' height='+ options.radio +'></canvas>')
        .append('<canvas width='+ options.radio +' height='+ options.radio +'></canvas>')
        .append('<canvas width='+ options.radio +' height='+ options.radio +'></canvas>')
        .append('<canvas width='+ options.radio +' height='+ options.radio +'></canvas>')
        .append('<div></div>')
        .find('div')
          .append(children)
          .css({
            position: 'relative',
            zIndex: 1
          })
          .end();
      var canvases = $this.find('canvas')
        .css({
          position: 'absolute',
          zIndex: 0,
          width: options.radio+'px',
          height: options.radio+'px',
          backgroundColor: options.inColor
        });

      if(options.borderSize != 0) {
        var B = -(options.borderSize);
        $(canvases[0]).css({ top: B+'px', left: B+'px' });
        $(canvases[1]).css({ top: B+'px', right: B+'px' });
        $(canvases[2]).css({ bottom: B+'px', right: B+'px' });
        $(canvases[3]).css({ bottom: B+'px', left: B+'px' });
      } else {
        $(canvases[0]).css({ top: '0px', left: '0px' });
        $(canvases[1]).css({ top: '0px', right: '0px' });
        $(canvases[2]).css({ bottom: '0px', right: '0px' });
        $(canvases[3]).css({ bottom: '0px', left: '0px' });

        options.borderColor = options.inColor;
      }

      if($.browser.msie) {
        options.borderColor = options.borderColor;
        options.inColor = options.inColor;
      } else {
        var tmp = options.borderColor;
        options.borderColor = options.inColor;
        options.inColor = tmp;
      }

      var xs = [ options.radio, 0, 0, options.radio ];
      var ys = [ options.radio, options.radio, 0, 0 ];
      canvases.each(function(index){
        var canvas = excanvas(this);
        if (canvas && canvas.getContext) {
          var ctx = canvas.getContext("2d");

          ctx.fillStyle = options.outColor;
          ctx.fillRect(0,0,options.radio,options.radio);

          ctx.fillStyle = options.borderColor;
          ctx.arc(xs[index], ys[index], options.radio, 0, 2*Math.PI, 0);
          ctx.fill();

          ctx.fillStyle = options.inColor;
          ctx.arc(xs[index], ys[index], (options.radio-options.borderSize), 2*Math.PI, 0, 1);
          ctx.fill();
        }
      });

    });
  };
})(jQuery)

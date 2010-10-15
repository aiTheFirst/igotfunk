// Coded with confidence by Douglas Meyer <meyedou@iit.edu>
// Feel free to contact me with questions or future work
(function($){
  var rankingToName = function(ranking){
      return(rankingName[ (ranking == 100 ? 4 : Math.floor(ranking/20) ) ]);
    },
    rankingToIndex = function(ranking){
      if (ranking == 100) { return(4); }
      return(Math.floor(ranking/25));
    },
    rankingName = [
      'Lame', 'Ok', 'Good', 'Great', 'Awesome'
    ],
    reds =   [ 51,   0, 204, 230, 255],
    greens = [  0, 255, 255, 178, 102],
    blues =  [204, 102,  51,  25,   0],
    setMeter = function($meter, ranking){
      $meter.find('a,p').each(function(index){
        index = 4-index
        if(index > rankingToIndex(ranking-1)+1) {
          $(this).css({
            'background-color': 'white'
          });
        } else {
          var opacity = 1;
          if(ranking == undefined){
            opacity = 0.5;
          }else if(ranking == 100){
          }else if(index == rankingToIndex(ranking)+1){
            opacity = (ranking % 25)/25;
          }
          var red = reds[index], green = greens[index], blue = blues[index];
          $(this).css({
            'background-color': 'rgb('+red+','+green+','+blue+')',
            'opacity': opacity
          });
        }
      });
    };
  jQuery.fn.FunkOMeter = function(){
    return this.each(function(){
      var $meter = $(this),
        ranking = $meter.attr('data-ranking'),
        mini = $meter.attr('data-mini'),
        links,
        url;
      $meter
        .find('a:last')
          .after('<button disabled="disabled">Funk<br />This</button>')
          .end()
        .css({
          'width': (mini ? '30px' : '38px'),
          'background-color': 'white',
          'padding': '3px',
          'border': '1px solid black'})
        .roundCorners()
        .find('a,p')
          .css({'display': 'block', 'height': (mini ? '17px' : '30px'), 'margin': '0'});
      if($meter.find('a').length == 0){
        links = false
        $meter.attr('title', rankingName[rankingToIndex(ranking)] || 'No Ranking');
      } else {
        $meter.mouseout(function(){ setMeter($meter, ranking); });
        var $button = $meter.find('button')
          .css({ 'height': '40px', 'width': '38px' })
          .click(function(e){
            $.ajax({ 'type': 'PUT',
                      'url': url,
                      'data': { 'score': ranking , 'authenticity_token' : window._token},
                  'success': function(text){
              var $parent = $meter.parent();
              var indexOfMeter = $parent.children().index($meter);
              $meter.replaceWith(text);
              $parent.children('*:nth-child('+(indexOfMeter+1)+')').FunkOMeter();
              $meter = $parent = $button = undefined; //attempt to clean-up
            }});
            $button.addClass('loading').text('Saving').attr('disabled', 'disabled');
          });
        $meter.find('a').each(function(index){
          var $link = $(this);
          $link.attr('title', rankingName[4-index])
            .mouseover(function(){ setMeter($meter, (4-index)*25); })
            .click(function(){
              ranking = (4-index)*25;
              url = $link.attr('href');
              $button.attr('disabled', '').text('Funk This');
              return false;
            });
        });
      }
      setMeter($meter, ranking);
    });
  };
})(jQuery);
jQuery(function($){ $('.funk-o-meter').FunkOMeter(); });



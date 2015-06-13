var tags = [ "oatmeal", "rice", "peanut butter", "chick peas", "lentils", "milk powder", "pumpkin",
             "black beans" ];

$(document).ready(function () {
  $( "#food1" ).autocomplete({
    source: function( request, response ) {
      var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
      response( $.grep( tags, function( item ){
        return matcher.test( item );
      }) );
    }
  });

  $( "#food2" ).autocomplete({
    source: function( request, response ) {
      var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
      response( $.grep( tags, function( item ){
        return matcher.test( item );
      }) );
    }
  });

  $( "#food3" ).autocomplete({
    source: function( request, response ) {
      var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
      response( $.grep( tags, function( item ){
        return matcher.test( item );
      }) );
    }
  });

});

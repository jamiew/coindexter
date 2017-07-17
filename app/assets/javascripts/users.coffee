# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  new AvatarCropper()

  $('span.glyphicon-remove').on 'click', ->
    $('div#mailing-list').hide()
    $.ajax
      url: '/newsletters/prevent_display'
      success: (result) ->
        return

  emailPattern = /// ^ #begin of line
   ([\w.-]+)         #one or more letters, numbers, _ . or -
   @                 #followed by an @ sign
   ([\w.-]+)         #then one or more letters, numbers, _ . or -
   \.                #followed by a period
   ([a-zA-Z.]{2,6})  #followed by 2 to 6 letters or periods
   $ ///i            #end of line and ignore case

  $('input#newsletter-email-capture').on "keyup", ->
    if $(this).val().match emailPattern
      $('#newsletter-email-submit').prop 'disabled', false
    else 
      $('#newsletter-email-submit').prop 'disabled', true

  $('input#newsletter-email-capture').on "blur", ->
    if $(this).val().match emailPattern
      $('#newsletter-email-submit').prop 'disabled', false
    else 
      $('#newsletter-email-submit').prop 'disabled', true

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 400, 400]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    $('#network_crop_x').val(coords.x)
    $('#network_crop_y').val(coords.y)
    $('#network_crop_w').val(coords.w)
    $('#network_crop_h').val(coords.h)
    $('#coin_crop_x').val(coords.x)
    $('#coin_crop_y').val(coords.y)
    $('#coin_crop_w').val(coords.w)
    $('#coin_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
        width: Math.round(100/coords.w * $('#cropbox').width()) + 'px'
        height: Math.round(100/coords.h * $('#cropbox').height()) + 'px'
        marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
        marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
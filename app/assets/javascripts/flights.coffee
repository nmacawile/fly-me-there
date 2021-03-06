# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.datepicker').datepicker
    clearBtn: true
    startDate: '02/05/2018'
    endDate: '02/15/2018'
    autoclose: true
    
  $('.booking-row').click ->
    $('.booking-row').removeClass 'info'
    $('input[type=radio]').removeProp 'checked', false
    $(this).find('input[type=radio]').prop 'checked', true
    $(this).addClass 'info'
    $('#booking-button').prop 'disabled', false
    return
    
  $('.selectpicker').selectpicker()
  return
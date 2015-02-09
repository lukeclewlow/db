$(document).ready(function() {

  var categories = $( "#categories" );

  $('#genre-button').click(function(event) {
    categories.slideToggle();
  });

  // $('.temperature-down').on('click', function() {
  //   thermostat.downButton();
  //   changeTemp();
  // });

  // $('.reset').on('click', function() {
  //   thermostat.resetButton();
  //   changeTemp();
  // });

  // $('.PSM-on').on('click', function() {
  //   thermostat.switchPowerSaveModeOn();
  //   changeTemp();
  // });

  // $('.PSM-off').on('click', function() {
  //   thermostat.switchPowerSaveModeOff();
  //   changeTemp();
  // });

});

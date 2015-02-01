$(document).ready(function() {

  var categories = $( "#categories" );

  $('#genre-button').on('click', function(event) {
    categories.toggle(showOrHide);
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

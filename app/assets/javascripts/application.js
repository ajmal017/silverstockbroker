// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require ckeditor/init
//= require_tree .
//= require bootstrap-sprockets
//= require Chart.min

var ready = function() {
const stocks = $('.stock-list li').map(function(){
              return $.trim($(this).text());
            }).get();



const stockStr = `https://api.iextrading.com/1.0/stock/market/batch?symbols=${stocks.join(',')}&types=quote,news,chart&range=1m&last=5`

// Clean stock list
$('.stock-graph-list').empty();

$.get(stockStr, function(data){
  $.each(data, function (k,v) {
    $('.stock-graph-list').append('<div class="tr">' +
      '<span class="td">' + v.quote.symbol + '</span>' +
      '<span class="td">' + v.quote.latestPrice + '</span>' +
      '<span class="td stock-val">' + v.quote.change + '</span>' +
      '<span class="td">' + v.quote.changePercent + '</span>' +
      '<span class="td">' + v.quote.latestVolume + '</span>' +
      '<a class="stock-link" href="./stocks/' + v.quote.symbol + '"></a>' +
    '</div>')
  })
});


var dailyData = [];
var dailyTime = [];
$.get('https://api.iextrading.com/1.0/stock/slv/chart/1d', function (data) {

  for (var i = 0; i < data.length; i+= 10) {
    if (data[i].average > 0) {
      dailyData.push(data[i].average)
      dailyTime.push(data[i].minute);
    }
  }

  var ctx = document.getElementById('daily-chart').getContext('2d');
  var chart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: dailyTime,
          datasets: [{
              label: "SLV",
              backgroundColor: '#0d9ad6',
              borderColor: '#0f6bad',
              data: dailyData
          }]
      },

      // Configuration options go here
      options: {}
  });
})

var moData = [];
var moTime = [];
  $.get('https://api.iextrading.com/1.0/stock/slv/chart/1m', function (data) {
    for (var i = 13; i < data.length; i++) {
      moData.push(data[i].close)
      moTime.push(data[i].date);
    }

    var ctx = document.getElementById('weekly-chart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: moTime,
            datasets: [{
                label: "SLV",
                backgroundColor: '#0d9ad6',
                borderColor: '#0f6bad',
                data: moData
            }]
        },
    });
  })
};

$(document).on('turbolinks:load', ready);

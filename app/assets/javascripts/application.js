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
      '<span class="td blue">' + v.quote.symbol + '</span>' +
      '<span class="td">' + v.quote.latestPrice.toFixed(2) + '</span>' +
      '<span class="td stock-change">' + v.quote.change + '</span>' +
      '<span class="td stock-percent">' + (v.quote.changePercent).toFixed(3) + '</span>' +
      '<span class="td">' + (v.quote.latestVolume) + '</span>' +
      '<a class="stock-link" href="../stocks/' + v.quote.symbol + '"></a>' +
    '</div>')

    if (v.quote.change >= 0) {
      $('.stock-change').addClass('success');
    } else {
      $('.stock-change').addClass('danger');
    }

    if (v.quote.changePercent >= 0) {
      $('.stock-percent').addClass('success');
    } else {
      $('.stock-percent').addClass('danger');
    }
  })
});

$('.bar-box').on('click', function () {
  $('.inner-nav').toggleClass('show-nav');
  $(this).children().toggleClass('fa-angle-up fa-angle-down')
})

var dailyData = [];
var dailyTime = [];
$.get('https://api.iextrading.com/1.0/stock/slv/chart/1d', function (data) {
  console.log(data);

  for (var i = 0; i < data.length; i+= 30) {
    if (data[i].average > 0) {
      dailyData.push(data[i].average)
      dailyTime.push(data[i].minute);
    }
  }

  if ($('#daily-chart').length > 0) {
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
  }
})

var moData = [];
var moTime = [];
  $.get('https://api.iextrading.com/1.0/stock/slv/chart/1m', function (data) {
    for (var i = 13; i < data.length; i++) {
      moData.push(data[i].close)
      moTime.push(data[i].date);
    }

    if ($('#weekly-chart').length > 0) {
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
    }
  })

  // toggle popup
  $('.popup').on('click', function() {
    $(this).fadeOut();
  })

  $('.popup .callout').on('click', function (e) {
    e.stopPropagation();
  })
};

$(document).on('turbolinks:load', ready);

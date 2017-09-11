<template>
  <nav class="navbar navbar-light bg-primary">
    <div class='action-buttons'>
      <a type="button" class="btn-floating btn-large btn-menu" @click='toggleNav'><i class='fa fa-bars'></i></a>
      <a href="/#/orders/me" type="button" class="btn-floating btn-large btn-orders">{{metrics[2]}}</a>
    </div>
    <div class='action-form'>
      <form class="form-inline pull-xs-right autocomplete">
          <input
           v-model="q"
           v-on:keyup="search"
           v-on:focus="redirect"

           class="form-control col-md-12 col-xs-12"
           type="text"
           placeholder="Référence ou #emplacement"
          />
          <a href='#' class='barcode-scan' @click="startScan()"><i class='fa fa-qrcode'></i></a>
      </form>

    </div>
    <div class='metrics'>
      <span class="metrics">{{metrics[0]}}/{{metrics[1]}}</span>
    </div>
  </nav>
</template>

<script>

import Quagga from 'quagga';

export default {
  data: function() {
    return this.$store.state.PositionStore;
  },
  methods: {
    search: function() {
      this.$store.dispatch('PositionStore/search', this.q)
    },
    redirect: function() {
      return window.location.href = '/#/';
    },
    toggleNav: function() {
      window.$("[data-is='mainNav']").toggleClass('active');
    },
    startScan: function() {
      window.$('.modal-body.scanner').removeClass('done');
      window.$(".modal-body .result").hide();
      window.$("#modalScanner").modal();

      Quagga.init({
        inputStream : {
          name : "Live",
          type : "LiveStream",
          target: document.querySelector('#barcode'),
          constraints: {
            width: 480,
            height: 320,
            facingMode: "environment"
          },
        },
        decoder : {
          readers : ["ean_reader"]
        }
      },
      function(err) {
        if(err) {
          console.log(err);
          return;
        }
        Quagga.start();
      });

      Quagga.onProcessed(function (result) {
        var drawingCtx = Quagga.canvas.ctx.overlay,
        drawingCanvas = Quagga.canvas.dom.overlay;

        if (result) {
          if (result.boxes) {
            drawingCtx.clearRect(0, 0, parseInt(drawingCanvas.getAttribute("width")), parseInt(drawingCanvas.getAttribute("height")));
            result.boxes.filter(function (box) {
              return box !== result.box;
            }).forEach(function (box) {
              Quagga.ImageDebug.drawPath(box, { x: 0, y: 1 }, drawingCtx, { color: "green", lineWidth: 2 });
            });
          }

          if (result.box) {
            Quagga.ImageDebug.drawPath(result.box, { x: 0, y: 1 }, drawingCtx, { color: "#00F", lineWidth: 2 });
          }

          if (result.codeResult && result.codeResult.code) {
            Quagga.ImageDebug.drawPath(result.line, { x: 'x', y: 'y' }, drawingCtx, { color: 'red', lineWidth: 3 });
          }
        }
      });

      Quagga.onDetected(function (result) {
        console.log("Barcode detected and processed : [" + result.codeResult.code + "]", result);
      });
    }
  }
}

</script>

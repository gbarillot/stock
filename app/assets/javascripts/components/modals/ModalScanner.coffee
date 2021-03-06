@ModalScanner = Vue.component 'ModalScanner',
  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='modalScanner' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Scan</h4>
          </div>

          <div class='modal-body scanner'>
            <video id="qr-preview" autoplay='autoplay' style='transform: scaleX(-1);'></video>
            <div class='result status-0'>
              <i class='fa fa-check'></i>
            </div>

            <div class='result status-1'>
              <i class='fa fa-times'></i>
              <p>Caméra non détectée</p>
            </div>

            <div class='result status-2'>
              <i class='fa fa-times'></i>
              <p>Erreur</p>
            </div>

            <div class='result status-3'>
              <i class='fa fa-times'></i>
              <p>Pas de QR Code détecté</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  '''
